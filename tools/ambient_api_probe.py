#!/usr/bin/env python3
"""Local Google Photos Ambient API probe; no backend or generated SDK imports."""

import argparse
import contextlib
import datetime as dt
from enum import Enum, IntEnum
import fcntl
import hashlib
from http.client import HTTPException
from http import HTTPStatus
import json
import math
import os
from pathlib import Path
import re
import sys
import tempfile
import time
import urllib.error
import urllib.parse
import urllib.request
import uuid


SCOPE = 'https://www.googleapis.com/auth/photosambient.mediaitems'
API = 'https://photosambient.googleapis.com/v1'
DEVICE_CODE = 'https://oauth2.googleapis.com/device/code'
TOKEN = 'https://oauth2.googleapis.com/token'
DEFAULT_STATE = Path(__file__).resolve().parents[1] / '.local' / 'ambient-api'
JSON_LIMIT = 2 * 1024 * 1024


class Exit(IntEnum):
    OK = 0
    FAILED = 1
    INCOMPLETE = 2
    INTERRUPTED = 130


class Stage(Enum):
    AUTH = 'authorization'
    DEVICE = 'device'
    SOURCE = 'source'
    LIST = 'media_list'
    DOWNLOAD = 'download'
    DELETE = 'delete_device'


class OAuthError(Enum):
    PENDING = 'authorization_pending'
    SLOW_DOWN = 'slow_down'
    DENIED = 'access_denied'
    EXPIRED = 'expired_token'
    INVALID_GRANT = 'invalid_grant'
    UNKNOWN = 'unknown'

    @classmethod
    def parse(cls, value):
        try:
            return cls(value)
        except ValueError:
            return cls.UNKNOWN


class MediaKind(Enum):
    PHOTO = 'photo'
    VIDEO = 'video'
    UNKNOWN = 'unknown'

    @classmethod
    def from_mime(cls, value):
        # MIME strings are parsed only at the HTTP/JSON boundary.
        major = str(value).lower().split('/', 1)[0]
        return {'image': cls.PHOTO, 'video': cls.VIDEO}.get(major, cls.UNKNOWN)


class ProbeError(Exception):
    pass


class ApiError(ProbeError):
    def __init__(self, status, payload):
        self.status = status
        error = payload.get('error', {}) if isinstance(payload, dict) else {}
        if isinstance(error, dict):
            self.code = str(error.get('status', 'HTTP_ERROR'))
            self.message = str(error.get('message', ''))
            details = []
            for key in ('details', 'errors'):
                if isinstance(error.get(key), list):
                    details.extend(error[key])
            self.reasons = [str(item['reason']) for item in details
                            if isinstance(item, dict) and item.get('reason')]
        else:
            self.code = str(error or 'HTTP_ERROR')
            self.message = str(payload.get('error_description', ''))
            self.reasons = []
        super().__init__(f'HTTP {status}: {self.code}: {self.message}'
                         + (f"; reason={','.join(self.reasons)}" if self.reasons else ''))


def positive(value):
    try:
        result = float(value)
    except (TypeError, ValueError) as error:
        raise ProbeError(f'Ожидалось положительное число: {value!r}') from error
    if not math.isfinite(result) or result <= 0:
        raise ProbeError('Число должно быть конечным и положительным')
    return result


def private_directory(path):
    path.mkdir(parents=True, exist_ok=True, mode=0o700)
    return path


def save_json(path, value):
    """Replace only complete JSON; temporary files and final files have mode 0600."""
    private_directory(path.parent)
    descriptor, temporary = tempfile.mkstemp(prefix='.ambient-', dir=path.parent)
    try:
        with os.fdopen(descriptor, 'w', encoding='utf-8') as output:
            json.dump(value, output, ensure_ascii=False, indent=2)
            output.write('\n')
        os.replace(temporary, path)
    finally:
        Path(temporary).unlink(missing_ok=True)


@contextlib.contextmanager
def state_lock(directory):
    private_directory(directory)
    descriptor = os.open(directory / '.lock', os.O_CREAT | os.O_RDWR, 0o600)
    with os.fdopen(descriptor, 'w') as lock:
        try:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError as error:
            raise ProbeError('Другой probe уже использует этот --state-dir') from error
        yield


def media_url(url):
    parts = urllib.parse.urlsplit(url)
    hostname = parts.hostname or ''
    trusted = any(hostname == domain or hostname.endswith('.' + domain)
                  for domain in ('googleusercontent.com', 'ggpht.com'))
    if (parts.scheme != 'https' or not trusted or parts.username or parts.password
            or parts.port not in (None, 443) or parts.fragment):
        raise ProbeError('baseUrl/redirect не является ожидаемым HTTPS media URL Google')
    return url


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, request, fp, code, message, headers, new_url):
        return None


class Http:
    def __init__(self, timeout=30, opener=None):
        self.timeout = timeout
        self.opener = opener or urllib.request.build_opener(NoRedirect())
        self.secrets = set()

    def clean(self, message):
        result = str(message)
        for value in sorted(self.secrets, key=len, reverse=True):
            if value:
                result = result.replace(value, '[redacted]')
        result = re.sub(r'https?://[^\s<>"\']+', '[url]', result)
        return result[:2000]

    def open(self, url, *, data=None, headers=None, media=False, timeout=None, method=None):
        headers = dict(headers or {})
        for _ in range(6):
            if media:
                media_url(url)
            request = urllib.request.Request(url, data=data, headers=headers, method=method)
            try:
                return self.opener.open(request, timeout=timeout or self.timeout)
            except urllib.error.HTTPError as error:
                with error:
                    location = error.headers.get('Location')
                    redirects = (HTTPStatus.MOVED_PERMANENTLY, HTTPStatus.FOUND,
                                 HTTPStatus.SEE_OTHER, HTTPStatus.TEMPORARY_REDIRECT,
                                 HTTPStatus.PERMANENT_REDIRECT)
                    if media and error.code in redirects and location:
                        url = urllib.parse.urljoin(url, location)
                        media_url(url)
                        continue
                    raw = error.read(JSON_LIMIT + 1)
                    try:
                        payload = json.loads(raw) if len(raw) <= JSON_LIMIT else {}
                    except (ValueError, UnicodeError):
                        payload = {}
                    raise ApiError(error.code, payload) from None
            except (urllib.error.URLError, TimeoutError, OSError, HTTPException) as error:
                raise ProbeError(f'Сетевая ошибка: {self.clean(error)}') from None
        raise ProbeError('Слишком много перенаправлений при скачивании')

    def json(self, url, *, body=None, form=None, token=None, timeout=None):
        headers = {'Accept': 'application/json'}
        data = None
        if body is not None:
            headers['Content-Type'] = 'application/json'
            data = json.dumps(body).encode()
        if form is not None:
            headers['Content-Type'] = 'application/x-www-form-urlencoded'
            data = urllib.parse.urlencode(form).encode()
        if token:
            headers['Authorization'] = 'Bearer ' + token
        with self.open(url, data=data, headers=headers, timeout=timeout) as response:
            raw = response.read(JSON_LIMIT + 1)
        if len(raw) > JSON_LIMIT:
            raise ProbeError('JSON-ответ превысил 2 MiB')
        try:
            value = json.loads(raw)
        except (ValueError, UnicodeError) as error:
            raise ProbeError('Сервер вернул некорректный JSON') from error
        if not isinstance(value, dict):
            raise ProbeError('Ожидался JSON-объект')
        if 'error' in value:
            raise ApiError(HTTPStatus.OK, value)
        return value


class Probe:
    def __init__(self, options, http=None, *, sleep=time.sleep,
                 monotonic=time.monotonic, wall=time.time, prompt=input, say=print):
        self.options = options
        self.http = http or Http(options.request_timeout)
        self.sleep, self.monotonic, self.wall = sleep, monotonic, wall
        self.prompt, self.say = prompt, say
        self.state_path = options.state_dir / 'state.json'
        self.state = {}
        self.client = {}
        self.stage = Stage.AUTH
        self.report = {'started_at': dt.datetime.now(dt.timezone.utc).isoformat(),
                       'scope': SCOPE, 'downloads': [], 'errors': [],
                       'requested_downloads': {'photo': options.photos, 'video': options.videos}}

    def save(self):
        save_json(self.state_path, self.state)

    def load(self):
        value = json.loads(self.options.client_file.read_text(encoding='utf-8'))
        if not isinstance(value, dict) or 'web' in value:
            raise ProbeError('Нужен OAuth JSON для TVs and Limited Input devices, не Web client')
        self.client = value.get('installed', value)
        if not isinstance(self.client, dict) or not all(isinstance(self.client.get(key), str) and self.client[key]
                   for key in ('client_id', 'client_secret')):
            raise ProbeError('OAuth JSON должен содержать client_id и client_secret')
        self.http.secrets.add(self.client['client_secret'])
        if self.state_path.exists():
            self.state = json.loads(self.state_path.read_text(encoding='utf-8'))
            if not isinstance(self.state, dict):
                raise ProbeError('state.json должен содержать JSON-объект')
            if self.state.get('client_id') != self.client['client_id']:
                raise ProbeError('Этот state-dir принадлежит другому OAuth client; выбери другой каталог')
            for key in ('access_token', 'refresh_token', 'device_id', 'request_id', 'source_id'):
                if key in self.state and not isinstance(self.state[key], str):
                    raise ProbeError(f'Некорректное поле {key} в state.json')
            if 'expires_at' in self.state:
                self.state['expires_at'] = positive(self.state['expires_at'])
        self.state['client_id'] = self.client['client_id']
        self.http.secrets.update(str(self.state.get(key, '')) for key in
                                 ('access_token', 'refresh_token'))
        if self.options.reauthorize:
            for key in ('access_token', 'refresh_token', 'expires_at'):
                self.state.pop(key, None)
            self.save()

    def tokens(self, value):
        token = value.get('access_token')
        if not isinstance(token, str) or not token:
            raise ProbeError('OAuth не вернул access_token')
        self.http.secrets.add(token)
        if str(value.get('token_type', 'Bearer')).lower() != 'bearer':
            raise ProbeError('OAuth вернул неподдерживаемый token_type')
        if 'scope' in value and SCOPE not in str(value['scope']).split():
            raise ProbeError('Пользователь не предоставил scope photosambient.mediaitems')
        self.state['access_token'] = token
        self.state['expires_at'] = self.wall() + positive(value.get('expires_in'))
        if value.get('refresh_token'):
            if not isinstance(value['refresh_token'], str):
                raise ProbeError('OAuth вернул некорректный refresh_token')
            self.state['refresh_token'] = value['refresh_token']
            self.http.secrets.add(value['refresh_token'])
        self.save()

    def authorize(self):
        codes = self.http.json(DEVICE_CODE, form={
            'client_id': self.client['client_id'], 'scope': SCOPE,
        })
        device_code = codes.get('device_code')
        if not all(isinstance(codes.get(key), str) and codes[key]
                   for key in ('device_code', 'user_code', 'verification_url')):
            raise ProbeError('OAuth не вернул device_code/user_code/verification_url')
        self.http.secrets.add(device_code)
        expires = positive(codes.get('expires_in'))
        deadline = self.monotonic() + min(expires, self.options.auth_timeout)
        interval = positive(codes.get('interval', 5))
        self.say(f"Открой: {codes['verification_url']}\nКод авторизации: {codes['user_code']}")
        while True:
            remaining = deadline - self.monotonic()
            if remaining <= interval:
                raise ProbeError('Истекло время ожидания OAuth; запусти probe повторно')
            self.sleep(interval)
            if self.monotonic() >= deadline:
                raise ProbeError('Истекло время ожидания OAuth')
            try:
                value = self.http.json(TOKEN, form={
                    'client_id': self.client['client_id'],
                    'client_secret': self.client['client_secret'],
                    'device_code': device_code,
                    'grant_type': 'urn:ietf:params:oauth:grant-type:device_code',
                }, timeout=min(self.http.timeout, deadline - self.monotonic()))
                self.tokens(value)
                return
            except ApiError as error:
                code = OAuthError.parse(error.code)
                if code == OAuthError.SLOW_DOWN:
                    interval += 5
                elif code != OAuthError.PENDING:
                    raise

    def token(self, force=False):
        if (not force and self.state.get('access_token')
                and self.state.get('expires_at', 0) > self.wall() + 60):
            return self.state['access_token']
        if self.state.get('refresh_token'):
            value = self.http.json(TOKEN, form={
                'client_id': self.client['client_id'],
                'client_secret': self.client['client_secret'],
                'refresh_token': self.state['refresh_token'],
                'grant_type': 'refresh_token',
            })
            self.tokens(value)
        else:
            self.authorize()
        return self.state['access_token']

    def api(self, resource, *, query=None, body=None):
        url = f'{API}/{resource}'
        if query:
            url += '?' + urllib.parse.urlencode(query)
        for attempt in range(2):
            try:
                return self.http.json(url, body=body, token=self.token(force=bool(attempt)))
            except ApiError as error:
                if error.status != HTTPStatus.UNAUTHORIZED or attempt:
                    raise

    def device(self):
        self.stage = Stage.DEVICE
        if self.state.get('device_id'):
            device = self.api('devices/' + urllib.parse.quote(self.state['device_id'], safe=''))
        else:
            # Persist before the POST: never silently create another device after
            # a timeout, dropped response or interrupted run.
            self.state.setdefault('request_id', str(uuid.uuid4()))
            self.save()
            device = self.api('devices', query={'requestId': self.state['request_id']},
                              body={'displayName': self.options.display_name})
            if not device.get('id'):
                raise ProbeError('devices.create не вернул id')
            self.state['device_id'] = device['id']
            self.save()
        if not isinstance(device.get('id'), str) or not device['id']:
            raise ProbeError('API вернул устройство без id')
        self.report['device_id'] = device['id']
        self.stage = Stage.SOURCE
        if not device.get('mediaSourcesSet') or self.options.configure:
            if not device.get('settingsUri'):
                raise ProbeError('У устройства нет settingsUri для выбора альбома')
            self.say(f"Выбери альбом для устройства: {device['settingsUri']}")
            if self.options.configure:
                self.prompt('После изменения выбора нажми Enter: ')
                device = self.api('devices/' + urllib.parse.quote(device['id'], safe=''))
            deadline = self.monotonic() + self.options.selection_timeout
            while not device.get('mediaSourcesSet'):
                config = device.get('pollingConfig') or {}
                if not isinstance(config, dict):
                    raise ProbeError('Некорректный pollingConfig')
                interval = duration(config.get('pollInterval', '5s'))
                if self.monotonic() + interval >= deadline:
                    raise ProbeError('Истекло время выбора альбома; устройство сохранено, повтори запуск')
                self.sleep(interval)
                device = self.api('devices/' + urllib.parse.quote(device['id'], safe=''))
        save_json(self.output / 'device.json', device)
        return device

    def source(self, device):
        sources = device.get('mediaSources') or []
        if not isinstance(sources, list) or any(not isinstance(source, dict) for source in sources):
            raise ProbeError('Некорректный список mediaSources')
        usable = [source for source in sources if source.get('id') and source['id'] != 'highlights']
        if not usable:
            raise ProbeError('Нет выбранных источников-альбомов; highlights не поддерживает mediaSourceId')
        requested = self.options.source_id or self.state.get('source_id')
        selected = next((source for source in usable if source['id'] == requested), None)
        for index, source in enumerate(usable, 1):
            self.say(f"{index}. {source.get('displayName', '(без имени)')} — {source['id']}")
        if self.options.source_id and selected is None:
            raise ProbeError('--source-id не входит в выбранные пользователем источники устройства')
        if selected is None and len(usable) == 1:
            selected = usable[0]
        if selected is None:
            choice = self.prompt('Выбери номер альбома или введи его ID: ').strip()
            selected = next((source for source in usable if source['id'] == choice), None)
            if selected is None and choice.isdigit() and 1 <= int(choice) <= len(usable):
                selected = usable[int(choice) - 1]
            if selected is None:
                raise ProbeError('Неизвестный источник')
        self.state['source_id'] = selected['id']
        self.save()
        self.report['source'] = selected
        return selected['id']

    def list_media(self, device_id, source_id):
        self.stage = Stage.LIST
        items, ids, tokens = [], set(), set()
        page_token = None
        for page in range(self.options.max_pages):
            query = {'deviceId': device_id, 'mediaSourceId': source_id,
                     'pageSize': self.options.page_size}
            if page_token:
                query['pageToken'] = page_token
            response = self.api('mediaItems', query=query)
            entries = response.get('mediaItems') or []
            if not isinstance(entries, list):
                raise ProbeError('Некорректный список mediaItems')
            for item in entries:
                if not isinstance(item, dict) or not isinstance(item.get('id'), str) or not item['id']:
                    raise ProbeError('Некорректный media item без id')
                if not isinstance(item.get('mediaFile', {}), dict):
                    raise ProbeError('Некорректный mediaFile')
                if item['id'] not in ids:
                    ids.add(item['id'])
                    items.append(item)
            self.report['pages'] = page + 1
            page_token = response.get('nextPageToken')
            if page_token is not None and not isinstance(page_token, str):
                raise ProbeError('Некорректный nextPageToken')
            if not page_token:
                break
            if page_token in tokens:
                raise ProbeError('API повторил nextPageToken; обход остановлен')
            tokens.add(page_token)
        self.report['truncated'] = bool(page_token)
        self.report['unique_items'] = len(items)
        self.report['counts'] = {kind.value: sum(media_kind(item) == kind for item in items)
                                 for kind in MediaKind}
        # Signed download URLs are consumed during this run, not persisted.
        save_json(self.output / 'media.json', [without_urls(item) for item in items])
        self.say(f"Получено уникальных медиа: {len(items)}; {self.report['counts']}")
        return items

    def download(self, item):
        kind = media_kind(item)
        media = item['mediaFile']
        base = media_url(media.get('baseUrl', ''))
        parts = urllib.parse.urlsplit(base)
        suffix = '=dv' if kind == MediaKind.VIDEO else '=d'
        url = urllib.parse.urlunsplit(parts._replace(path=parts.path + suffix))
        extensions = {'image/jpeg': '.jpg', 'image/png': '.png', 'image/webp': '.webp',
                      'image/gif': '.gif', 'image/heic': '.heic', 'image/avif': '.avif',
                      'video/mp4': '.mp4', 'video/webm': '.webm', 'video/quicktime': '.mov'}
        stem = kind.value + '-' + hashlib.sha256(item['id'].encode()).hexdigest()[:24]
        temporary = self.output / (stem + '.part')
        deadline = self.monotonic() + self.options.download_timeout
        digest, length, prefix = hashlib.sha256(), 0, bytearray()
        try:
            for attempt in range(2):
                try:
                    response = self.http.open(url, media=True,
                                              headers={'Authorization': 'Bearer ' + self.token(force=bool(attempt))})
                    break
                except ApiError as error:
                    if error.status != HTTPStatus.UNAUTHORIZED or attempt:
                        raise
            with response:
                if response.status != HTTPStatus.OK:
                    raise ProbeError(f'Неожиданный HTTP {response.status} вместо целого медиа')
                content_type = response.headers.get('Content-Type', '').split(';')[0].lower()
                if (MediaKind.from_mime(content_type) != kind
                        and content_type != 'application/octet-stream'):
                    raise ProbeError(f'Вместо {kind.value} сервер вернул Content-Type={content_type!r}')
                # Google can transcode the original: name the downloaded bytes,
                # rather than retaining an extension from the source metadata.
                mime = media.get('mimeType') if content_type == 'application/octet-stream' else content_type
                destination = self.output / (stem + extensions.get(mime, '.bin'))
                expected = response.headers.get('Content-Length')
                expected = int(expected) if expected is not None else None
                if expected is not None and (expected < 0 or expected > self.options.max_download_bytes):
                    raise ProbeError('Content-Length превышает лимит скачивания')
                descriptor = os.open(temporary, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
                with os.fdopen(descriptor, 'wb') as output:
                    while True:
                        if self.monotonic() >= deadline:
                            raise ProbeError('Истекло время скачивания')
                        chunk = response.read1(64 * 1024)
                        if not chunk:
                            break
                        length += len(chunk)
                        if length > self.options.max_download_bytes:
                            raise ProbeError('Тело медиа превышает лимит скачивания')
                        output.write(chunk)
                        digest.update(chunk)
                        prefix.extend(chunk[:64 - len(prefix)])
                if not length or (expected is not None and length != expected):
                    raise ProbeError('Пустое или недокачанное медиа')
                if signature_kind(prefix) != kind:
                    raise ProbeError('Сигнатура скачанного файла не соответствует ожидаемому типу медиа')
            os.replace(temporary, destination)
        finally:
            temporary.unlink(missing_ok=True)
        return {'id': item['id'], 'kind': kind.value, 'file': destination.name, 'bytes': length,
                'mime_type': content_type, 'sha256': digest.hexdigest()}

    def run(self):
        self.load()
        self.token()
        if self.options.delete_device:
            self.stage = Stage.DELETE
            identifier = self.state.get('device_id') or self.state.get('request_id')
            if not identifier:
                raise ProbeError('В этом state-dir нет принадлежащего probe устройства')
            url = API + '/devices/' + urllib.parse.quote(identifier, safe='')
            try:
                with self.http.open(url, method='DELETE',
                                    headers={'Authorization': 'Bearer ' + self.token()}):
                    pass
            except ApiError as error:
                if error.status != HTTPStatus.NOT_FOUND:
                    raise
            for key in ('device_id', 'request_id', 'source_id'):
                self.state.pop(key, None)
            self.save()
            self.say('Тестовое устройство удалено; токены сохранены.')
            return Exit.OK
        device = self.device()
        source = self.source(device)
        items = self.list_media(device['id'], source)
        self.stage = Stage.DOWNLOAD
        for kind, wanted in ((MediaKind.PHOTO, self.options.photos), (MediaKind.VIDEO, self.options.videos)):
            completed, attempted = 0, 0
            for item in items:
                if completed == wanted or attempted >= max(3, wanted):
                    break
                if media_kind(item) != kind:
                    continue
                attempted += 1
                try:
                    result = self.download(item)
                    self.report['downloads'].append(result)
                    self.say(f"Скачан {result['file']}: {result['bytes']} байт")
                    completed += 1
                except (ProbeError, OSError, ValueError, HTTPException) as error:
                    self.report['errors'].append({'id': item['id'], 'error': self.http.clean(error)})
                    self.say(f'Не удалось скачать {kind.value}: {self.http.clean(error)}')
            if completed < wanted:
                self.report['errors'].append({'kind': kind.value, 'wanted': wanted, 'downloaded': completed})
                self.say(f'{kind.value}: запрошено {wanted}, скачано {completed}; проверка неполная')
        return Exit.INCOMPLETE if self.report['errors'] or self.report['truncated'] else Exit.OK


def media_kind(item):
    return MediaKind.from_mime(item.get('mediaFile', {}).get('mimeType', ''))


def signature_kind(data):
    """Basic container signature only; no native codec/playback validation."""
    if (data.startswith((b'\xff\xd8\xff', b'\x89PNG\r\n\x1a\n', b'GIF87a', b'GIF89a',
                         b'BM', b'II*\0', b'MM\0*', b'\xff\x0a', b'\0\0\0\x0cJXL '))
            or (data[:4] == b'RIFF' and data[8:12] == b'WEBP')):
        return MediaKind.PHOTO
    if data[4:8] == b'ftyp':
        image_brands = (b'heic', b'heix', b'hevc', b'hevx', b'mif1', b'msf1', b'avif', b'avis')
        return MediaKind.PHOTO if data[8:12] in image_brands else MediaKind.VIDEO
    if (data.startswith((b'\x1aE\xdf\xa3', b'\0\0\x01\xba', b'\0\0\x01\xb3'))
            or (data[:4] == b'RIFF' and data[8:12] == b'AVI ')):
        return MediaKind.VIDEO
    return MediaKind.UNKNOWN


def duration(value):
    if not isinstance(value, str) or not re.fullmatch(r'\d+(?:\.\d{1,9})?s', value):
        raise ProbeError('Некорректный pollingConfig.pollInterval')
    return positive(value[:-1])


def without_urls(value):
    if isinstance(value, dict):
        return {key: without_urls(item) for key, item in value.items() if key != 'baseUrl'}
    if isinstance(value, list):
        return [without_urls(item) for item in value]
    return value


def parser():
    result = argparse.ArgumentParser(description=__doc__)
    result.add_argument('--client-file', type=Path, required=True, help='Google OAuth client JSON (TVs and Limited Input devices)')
    result.add_argument('--state-dir', type=Path, default=DEFAULT_STATE)
    result.add_argument('--output-dir', type=Path, help='Parent for a new private run directory; default: state-dir/runs')
    result.add_argument('--display-name', default='DSlideshow local Ambient probe')
    result.add_argument('--source-id', help='ID from AmbientDevice.mediaSources, not a Library API album ID')
    result.add_argument('--configure', action='store_true', help='Show settingsUri and wait for Enter before checking selection')
    result.add_argument('--reauthorize', action='store_true', help='Discard saved tokens and repeat device OAuth; retain device/source')
    result.add_argument('--delete-device', action='store_true', help='Delete only the device/request saved by this probe')
    result.add_argument('--photos', type=int, default=1)
    result.add_argument('--videos', type=int, default=1)
    result.add_argument('--page-size', type=int, default=100)
    result.add_argument('--max-pages', type=int, default=10)
    result.add_argument('--max-download-bytes', type=int, default=512 * 1024 * 1024)
    result.add_argument('--request-timeout', type=float, default=30)
    result.add_argument('--download-timeout', type=float, default=300)
    result.add_argument('--auth-timeout', type=float, default=600)
    result.add_argument('--selection-timeout', type=float, default=600)
    return result


def main(argv=None):
    arguments = parser()
    options = arguments.parse_args(argv)
    if (min(options.photos, options.videos) < 0 or not 1 <= options.page_size <= 100
            or not 1 <= options.max_pages <= 240 or options.max_download_bytes <= 0
            or not 1 <= len(options.display_name) <= 100):
        arguments.error('Invalid counts, limits or display name; see --help')
    for name in ('request_timeout', 'download_timeout', 'auth_timeout', 'selection_timeout'):
        try:
            positive(getattr(options, name))
        except ProbeError as error:
            arguments.error(str(error))
    probe = Probe(options)
    try:
        with state_lock(options.state_dir):
            parent = options.output_dir or options.state_dir / 'runs'
            private_directory(parent)
            probe.output = Path(tempfile.mkdtemp(prefix=dt.datetime.now(dt.timezone.utc).strftime('%Y%m%dT%H%M%SZ-'), dir=parent))
            probe.say(f'Результаты: {probe.output}')
            try:
                status = probe.run()
            except KeyboardInterrupt:
                status = Exit.INTERRUPTED
                probe.report['errors'].append({'error': 'Interrupted by user'})
            except (ProbeError, OSError, ValueError, EOFError, HTTPException) as error:
                status = Exit.FAILED
                message = probe.http.clean(error)
                probe.report['errors'].append({'error': message})
                print(f'Ошибка на этапе {probe.stage.value}: {message}', file=sys.stderr)
            probe.report.update({'exit_code': int(status), 'last_stage': probe.stage.value})
            save_json(probe.output / 'report.json', probe.report)
            probe.say(f'Код результата: {int(status)}; отчёт: {probe.output / "report.json"}')
            return int(status)
    except KeyboardInterrupt:
        print('Проверка прервана.', file=sys.stderr)
        return int(Exit.INTERRUPTED)
    except (ProbeError, OSError) as error:
        print(f'Ошибка: {probe.http.clean(error)}', file=sys.stderr)
        return int(Exit.FAILED)


if __name__ == '__main__':
    sys.exit(main())
