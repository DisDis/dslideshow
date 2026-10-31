import 'dart:async';
import 'dart:math' as math;

import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/repository/yandex_drive_repository.dart';
import '../bloc/yandex_drive_bloc.dart';
import '../wigdgets/settings_section.dart';

class YandexDriveSettings extends StatelessWidget {
  const YandexDriveSettings({super.key, required this.config, required this.repository, required this.onChanged});
  final YandexDriveStorageConfig config;
  final YandexDriveRepository repository;
  final ValueChanged<YandexDriveStorageConfig> onChanged;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => YandexSettingsCubit(repository: repository, config: config, onChanged: onChanged)..load(),
    child: const _YandexSettingsView(),
  );
}

class _YandexSettingsView extends StatelessWidget {
  const _YandexSettingsView();

  @override
  Widget build(BuildContext context) => BlocBuilder<YandexSettingsCubit, YandexSettingsState>(
    builder: (context, state) {
      final l = context.localizations;
      final cubit = context.read<YandexSettingsCubit>();
      final remote = state.remote;
      final accountIds = <String>{
        ...state.config.accounts.map((account) => account.accountId),
        ...?remote?.connections.map((account) => account.accountId),
      };
      return Column(
        children: [
          SettingsSection(
            title: l.sync_settings_title,
            icon: Icons.sync,
            children: [
              SettingsTextField(
                label: l.sync_period_label,
                initialValue: state.config.syncPeriod.inMinutes.toString(),
                suffixText: l.minutes_unit,
                isNumber: true,
                validator: (value) {
                  final minutes = int.tryParse(value ?? '');
                  return minutes != null && minutes > 0 && minutes <= 525600 ? null : l.invalid_positive_integer;
                },
                onChanged: (value) {
                  final minutes = int.tryParse(value);
                  if (minutes != null && minutes > 0 && minutes <= 525600) cubit.setPeriod(minutes);
                },
              ),
            ],
          ),
          SettingsSection(
            title: l.yandex_application_setup,
            icon: Icons.security_outlined,
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(l.yandex_application_hint)),
              if (remote?.clientId.isNotEmpty == true)
                ListTile(title: Text(l.client_id_label), subtitle: SelectableText(remote!.clientId)),
              Padding(
                padding: const EdgeInsets.all(12),
                child: OutlinedButton.icon(
                  onPressed: state.busy ? null : () => _configureApplication(context, cubit),
                  icon: const Icon(Icons.settings_outlined),
                  label: Text(l.yandex_configure_application),
                ),
              ),
            ],
          ),
          SettingsSection(
            title: l.yandex_accounts,
            icon: Icons.account_circle_outlined,
            children: [
              if (state.busy) const LinearProgressIndicator(),
              if (state.failure != null) _FailureMessage(failure: state.failure!, retry: cubit.load),
              if (accountIds.isEmpty && !state.busy)
                Padding(padding: const EdgeInsets.all(20), child: Text(l.yandex_connections_empty)),
              for (final accountId in accountIds)
                _AccountCard(
                  accountId: accountId,
                  config: state.config.accounts.where((account) => account.accountId == accountId).firstOrNull,
                  connection: remote?.connections.where((account) => account.accountId == accountId).firstOrNull,
                  busy: state.busy,
                ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: state.busy || remote?.clientId.isNotEmpty != true
                          ? null
                          : () => _connect(context, cubit),
                      icon: const Icon(Icons.add),
                      label: Text(l.yandex_add_account),
                    ),
                    TextButton.icon(
                      onPressed: state.busy ? null : cubit.load,
                      icon: const Icon(Icons.refresh),
                      label: Text(l.yandex_refresh),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (remote != null) _RuntimeCard(runtime: remote.runtime, busy: state.busy),
        ],
      );
    },
  );

  Future<void> _configureApplication(BuildContext context, YandexSettingsCubit cubit) async {
    final result = await showDialog<DriveResult>(
      context: context,
      builder: (_) => BlocProvider(
        create: (_) =>
            YandexApplicationCubit(repository: cubit.repository, clientId: cubit.state.remote?.clientId ?? ''),
        child: _ApplicationDialog(secretConfigured: cubit.state.remote?.clientSecretConfigured ?? false),
      ),
    );
    if (result != null) cubit.applicationConfigured(result);
  }

  Future<void> _connect(BuildContext context, YandexSettingsCubit cubit) async {
    unawaited(cubit.startAuthorization());
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(value: cubit, child: const _AuthorizationDialog()),
    );
    await cubit.cancelAuthorization();
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({required this.accountId, required this.config, required this.connection, required this.busy});
  final String accountId;
  final YandexDriveAccountConfig? config;
  final DriveConnection? connection;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final cubit = context.read<YandexSettingsCubit>();
    final label = config?.label.isNotEmpty == true ? config!.label : connection?.label ?? accountId;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: Icon(connection == null ? Icons.link_off : Icons.cloud_done_outlined),
              title: Text(label),
              subtitle: Text(
                connection == null
                    ? l.yandex_not_connected
                    : config == null
                    ? l.yandex_not_configured
                    : l.yandex_folder_count(config!.paths.length),
              ),
            ),
            if (config != null) ...[
              SettingsTextField(
                label: l.yandex_alias,
                initialValue: config!.label,
                onChanged: (value) => cubit.setAccountLabel(accountId, value),
              ),
              SwitchListTile(
                title: Text(l.yandex_sync_enabled),
                value: config!.enabled,
                onChanged: (value) => cubit.setAccountEnabled(accountId, value),
              ),
              for (final path in config!.paths.take(10))
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2), child: Text(path)),
            ],
            Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: busy || connection == null ? null : () => _folders(context, cubit, label),
                    icon: const Icon(Icons.folder_outlined),
                    label: Text(l.yandex_choose_folders),
                  ),
                  if (connection != null)
                    TextButton(
                      onPressed: busy ? null : () => _disconnect(context, cubit),
                      child: Text(l.yandex_disconnect),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _folders(BuildContext context, YandexSettingsCubit cubit, String label) async {
    final paths = await showDialog<List<String>>(
      context: context,
      builder: (_) => BlocProvider(
        create: (_) =>
            YandexFolderCubit(repository: cubit.repository, accountId: accountId, selected: config?.paths ?? [])
              ..open('disk:/'),
        child: const YandexFolderDialog(),
      ),
    );
    if (paths != null) cubit.setPaths(accountId, label, paths);
  }

  Future<void> _disconnect(BuildContext context, YandexSettingsCubit cubit) async {
    final l = context.localizations;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.yandex_disconnect_title),
        content: Text(l.yandex_disconnect_message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.cancel_button)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l.yandex_disconnect)),
        ],
      ),
    );
    if (confirm == true) await cubit.disconnect(accountId);
  }
}

class _RuntimeCard extends StatelessWidget {
  const _RuntimeCard({required this.runtime, required this.busy});
  final DriveRuntime runtime;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final cubit = context.read<YandexSettingsCubit>();
    final lastSync = runtime.lastSync?.toLocal();
    return SettingsSection(
      title: l.yandex_runtime_title,
      icon: Icons.sync,
      children: [
        ListTile(
          title: Text(
            !runtime.active
                ? l.yandex_runtime_inactive
                : runtime.paused
                ? l.yandex_runtime_paused
                : runtime.running && runtime.totalItems == null
                ? l.yandex_sync_discovering
                : runtime.running
                ? l.yandex_runtime_running
                : l.yandex_runtime_idle,
          ),
          subtitle: runtime.active
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.yandex_sync_counts(runtime.downloaded, runtime.skipped, runtime.failed)),
                    Text(
                      runtime.totalItems != null && runtime.progress != null
                          ? l.yandex_sync_progress(
                              runtime.processedItems,
                              runtime.totalItems!,
                              (runtime.progress! * 100).floor(),
                            )
                          : l.yandex_sync_processed(runtime.processedItems),
                    ),
                    if (lastSync != null)
                      Text(
                        l.yandex_last_sync(
                          '${MaterialLocalizations.of(context).formatShortDate(lastSync)} ${TimeOfDay.fromDateTime(lastSync).format(context)}',
                        ),
                      ),
                  ],
                )
              : null,
        ),
        if (runtime.running) LinearProgressIndicator(value: runtime.progress),
        if (runtime.error != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              runtime.error == DriveFailure.authorizationRequired ||
                      runtime.error == DriveFailure.authorizationDenied ||
                      runtime.error == DriveFailure.authorizationExpired
                  ? l.yandex_reconnect_hint
                  : l.yandex_runtime_failure,
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: !runtime.active || busy || runtime.running ? null : cubit.syncNow,
                icon: const Icon(Icons.sync),
                label: Text(l.yandex_sync_now),
              ),
              TextButton(
                onPressed: !runtime.active || busy ? null : () => cubit.setPaused(!runtime.paused),
                child: Text(runtime.paused ? l.yandex_resume : l.yandex_pause),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ApplicationDialog extends StatelessWidget {
  const _ApplicationDialog({required this.secretConfigured});
  static final _registrationUri = Uri.https('oauth.yandex.ru', '/client/new/id/');
  static final _redirectUri = Uri.https('oauth.yandex.ru', '/verification_code');
  final bool secretConfigured;

  @override
  Widget build(BuildContext context) => BlocBuilder<YandexApplicationCubit, YandexApplicationState>(
    builder: (context, state) {
      final l = context.localizations;
      final cubit = context.read<YandexApplicationCubit>();
      return AlertDialog(
        title: Text(l.yandex_application_setup),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.yandex_application_hint),
                const SizedBox(height: 16),
                Text(l.yandex_oauth_create_step),
                TextButton.icon(
                  onPressed: () => _openYandexPage(context, _registrationUri),
                  icon: const Icon(Icons.open_in_new),
                  label: Text(l.yandex_oauth_create_application),
                ),
                SelectableText(_registrationUri.toString()),
                const SizedBox(height: 12),
                Text(l.yandex_oauth_platform_step),
                SelectableText(_redirectUri.toString()),
                const SizedBox(height: 12),
                Text(l.yandex_oauth_permissions_step),
                const SelectableText('cloud_api:disk.read\ncloud_api:disk.info'),
                const SizedBox(height: 12),
                Text(l.yandex_oauth_credentials_step),
                const SizedBox(height: 12),
                SettingsTextField(label: l.client_id_label, initialValue: state.clientId, onChanged: cubit.setClientId),
                SettingsTextField(
                  label: l.client_secret_label,
                  initialValue: '',
                  onChanged: cubit.setSecret,
                  obscureText: true,
                  helperText: secretConfigured ? l.yandex_secret_saved : null,
                ),
                if (state.busy) const LinearProgressIndicator(),
                if (state.failure != null) _FailureMessage(failure: state.failure!),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: state.busy ? null : () => Navigator.pop(context), child: Text(l.cancel_button)),
          FilledButton(
            onPressed: state.busy || state.clientId.trim().isEmpty
                ? null
                : () async {
                    final result = await cubit.save();
                    if (context.mounted && result != null) Navigator.pop(context, result);
                  },
            child: Text(l.config_save_button),
          ),
        ],
      );
    },
  );
}

class _AuthorizationDialog extends StatelessWidget {
  const _AuthorizationDialog();

  @override
  Widget build(BuildContext context) => BlocBuilder<YandexSettingsCubit, YandexSettingsState>(
    builder: (context, state) {
      final l = context.localizations;
      final cubit = context.read<YandexSettingsCubit>();
      final authorization = state.authorization;
      final pending = authorization?.status == DriveAuthorizationStatus.pending;
      final uri = authorization?.verificationUrl;
      return AlertDialog(
        title: Text(l.yandex_authorization_title),
        content: SizedBox(
          width: 560,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.busy || (authorization == null && state.failure == null)) const LinearProgressIndicator(),
                Text(l.yandex_authorization_hint),
                const SizedBox(height: 12),
                Text(l.yandex_read_access_hint),
                if (pending && uri != null) ...[
                  const SizedBox(height: 16),
                  SizedBox.square(
                    dimension: 220,
                    child: QrImageView(data: uri.toString(), backgroundColor: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  SelectableText(authorization!.userCode ?? '', style: Theme.of(context).textTheme.headlineMedium),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TextButton.icon(
                        onPressed: () => Clipboard.setData(ClipboardData(text: authorization.userCode ?? '')),
                        icon: const Icon(Icons.copy),
                        label: Text(l.yandex_copy_code),
                      ),
                      FilledButton.icon(
                        onPressed: () => _openYandexPage(context, uri),
                        icon: const Icon(Icons.open_in_new),
                        label: Text(l.yandex_open_authorization),
                      ),
                    ],
                  ),
                  SelectableText(uri.toString()),
                  if (authorization.expiresAt != null)
                    Text(
                      l.yandex_expires_at(TimeOfDay.fromDateTime(authorization.expiresAt!.toLocal()).format(context)),
                    ),
                ],
                if (authorization != null)
                  Padding(padding: const EdgeInsets.only(top: 16), child: Text(_authorizationLabel(l, authorization))),
                if (authorization?.status == DriveAuthorizationStatus.connected)
                  Text(
                    state.remote?.connections
                            .where((account) => account.accountId == authorization?.accountId)
                            .firstOrNull
                            ?.label ??
                        authorization?.accountId ??
                        '',
                  ),
                if (state.failure != null)
                  _FailureMessage(
                    failure: state.failure!,
                    retry: authorization == null ? cubit.startAuthorization : cubit.refreshAuthorization,
                  ),
              ],
            ),
          ),
        ),
        actions: [
          if (authorization != null && !pending && authorization.status != DriveAuthorizationStatus.connected)
            TextButton(onPressed: state.busy ? null : cubit.startAuthorization, child: Text(l.retry_button)),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(pending || authorization == null ? l.cancel_button : l.special_done),
          ),
        ],
      );
    },
  );
}

final _yandexLinkLog = Logger('YandexOAuthLink');

Future<void> _openYandexPage(BuildContext context, Uri uri) async {
  _yandexLinkLog.fine('event=browserOpenStarted');
  bool opened;
  try {
    opened = await launchUrl(uri, mode: LaunchMode.externalApplication, webOnlyWindowName: '_blank');
    _yandexLinkLog.log(opened ? Level.FINE : Level.WARNING, 'event=browserOpenFinished opened=$opened');
  } catch (error) {
    opened = false;
    _yandexLinkLog.warning('event=browserOpenFailed type=${error.runtimeType}');
  }
  if (!opened && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.localizations.yandex_browser_failed)));
  }
}

String _authorizationLabel(AppLocalizations l, DriveAuthorization authorization) =>
    authorization.error == DriveFailure.authorizationDenied
    ? l.yandex_authorization_denied
    : switch (authorization.status) {
        DriveAuthorizationStatus.pending => l.yandex_authorization_pending,
        DriveAuthorizationStatus.connected => l.yandex_authorization_connected,
        DriveAuthorizationStatus.cancelled => l.yandex_authorization_cancelled,
        DriveAuthorizationStatus.expired => l.yandex_authorization_expired,
        DriveAuthorizationStatus.failed => switch (authorization.error) {
          DriveFailure.invalidClient => l.yandex_authorization_invalid_client,
          DriveFailure.invalidScope => l.yandex_authorization_invalid_scope,
          DriveFailure.clientUnavailable => l.yandex_authorization_client_unavailable,
          DriveFailure.network => l.yandex_authorization_network,
          DriveFailure.invalidRequest => l.yandex_authorization_invalid_request,
          DriveFailure.invalidResponse => l.yandex_authorization_invalid_response,
          _ => l.yandex_authorization_failed,
        },
      };

class YandexFolderDialog extends StatelessWidget {
  const YandexFolderDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<YandexFolderCubit, YandexFolderState>(
    builder: (context, state) {
      final l = context.localizations;
      final cubit = context.read<YandexFolderCubit>();
      final selectedPaths = state.selected.toList();
      return Dialog(
        insetPadding: const EdgeInsets.all(12),
        child: SizedBox(
          width: 620,
          height: math.min(640, MediaQuery.sizeOf(context).height * 0.85),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(l.yandex_folder_selection, style: Theme.of(context).textTheme.headlineSmall),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(l.yandex_recursive_hint),
                            Text(l.yandex_folder_count(state.selected.length)),
                            if (selectedPaths.isNotEmpty)
                              SizedBox(
                                height: 54,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: selectedPaths.length,
                                  itemBuilder: (context, index) {
                                    final path = selectedPaths[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: InputChip(label: Text(path), onDeleted: () => cubit.select(path, false)),
                                    );
                                  },
                                ),
                              ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: state.busy || state.path == 'disk:/' ? null : cubit.parent,
                                  tooltip: l.yandex_parent_folder,
                                  icon: const Icon(Icons.arrow_upward),
                                ),
                                Expanded(child: Text(state.path, maxLines: 2, overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                            CheckboxListTile(
                              title: Text(l.yandex_select_current_folder),
                              value: state.selected.contains(state.path) || cubit.selectedByParent(state.path),
                              onChanged: cubit.selectedByParent(state.path)
                                  ? null
                                  : (value) => cubit.select(state.path, value ?? false),
                            ),
                            if (state.busy) const LinearProgressIndicator(),
                            if (state.failure != null) _FailureMessage(failure: state.failure!, retry: cubit.retry),
                            if (state.page?.folders.isEmpty == true)
                              Padding(padding: const EdgeInsets.all(12), child: Text(l.yandex_no_folders)),
                          ],
                        ),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: state.page?.folders.length ?? 0,
                      itemBuilder: (context, index) {
                        final folder = state.page!.folders[index];
                        return ListTile(
                          leading: Checkbox(
                            value: state.selected.contains(folder.path) || cubit.selectedByParent(folder.path),
                            onChanged: cubit.selectedByParent(folder.path)
                                ? null
                                : (value) => cubit.select(folder.path, value ?? false),
                          ),
                          title: Text(folder.name),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: state.busy ? null : () => cubit.open(folder.path),
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: OverflowBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: state.busy || state.previousOffsets.isEmpty ? null : cubit.previousPage,
                            child: Text(l.yandex_previous_page),
                          ),
                          TextButton(
                            onPressed: state.busy || state.page?.nextOffset == null ? null : cubit.nextPage,
                            child: Text(l.yandex_next_page),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: OverflowBar(
                  alignment: MainAxisAlignment.end,
                  spacing: 8,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text(l.cancel_button)),
                    FilledButton(
                      onPressed: state.busy ? null : () => Navigator.pop(context, selectedPaths..sort()),
                      child: Text(l.yandex_apply_folders),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _FailureMessage extends StatelessWidget {
  const _FailureMessage({required this.failure, this.retry});
  final YandexPanelFailureKind failure;
  final VoidCallback? retry;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(switch (failure) {
            YandexPanelFailureKind.load => l.yandex_load_failed,
            YandexPanelFailureKind.rejected => l.yandex_request_failed,
            YandexPanelFailureKind.outcomeUnknown => l.yandex_outcome_unknown,
            YandexPanelFailureKind.authorization => l.yandex_reconnect_hint,
          }, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          if (retry != null) TextButton(onPressed: retry, child: Text(l.retry_button)),
        ],
      ),
    );
  }
}
