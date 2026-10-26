# Сборка финального DEB

Точка входа — `./build.sh` из этого каталога. Синхронизация frontend/backend,
автоматическое увеличение build-номера и оформление `changelog.md` описаны в
[руководстве выпуска](../doc/releasing.md).

Штатный `scripts/sensorsScript.sh` передаёт температуру и, при наличии тахометра
Raspberry Pi 5, фактический RPM вентилятора. Формат, отсутствие показаний,
диагностика и проверки описаны в [руководстве датчиков](../doc/sensors.md).

* install md5deep, dpkg-deb
* Create 'source_arm64'
* Create 'source_arm64/flutter-pi/'
* Put special 'flutter-pi' in 'source_arm64/flutter-pi/'
    with dpms support
* Run build.sh

## Проверка упаковки

Из корня репозитория:

```bash
python3 -m unittest discover -s deb_factory -p 'test_*.py' -v
sh -n deb_factory/build.sh
sh -n deb_factory/template_build_arm64/opt/dslideshow/scripts/sensorsScript.sh
```

Тест использует небольшие готовые assets вместо Flutter-компиляции и вызывает
настоящие `build.sh`, `md5deep` и `dpkg-deb`. После распаковки проверяются полнота
и значения контрольных сумм, относительные пути в `DEBIAN/md5sums`, сохранность
native runtime и файла версии. Пути в `md5sums` должны быть относительными:
список используется для проверки файлов на устройстве, где каталога машины
сборки нет.
