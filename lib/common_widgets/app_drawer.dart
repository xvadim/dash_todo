import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/build_context_extension.dart';
import '../common/consts.dart';
import '../common/sizes.dart';
import '../features/authentication/data/dropbox_auth_repository.dart';
import '../features/authentication/domain/app_user.dart';
import '../features/settings/data/settings_repository.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(child: _AppUserHeader()),
        ),
        Consumer(
          builder: (_, WidgetRef ref, __) {
            return ListTile(
              leading: const Icon(Icons.logout),
              title: Text('menu.logout'.tr()),
              onTap: () async {
                final settingsRepos =
                    ref.read(settingsRepositoryProvider).requireValue;
                final authRepos = ref.read(dropboxAuthRepositoryProvider);
                await settingsRepos.removeAppUser();
                await authRepos.logout();
              },
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text('menu.settings'.tr()),
          onTap: () => {},
        ),
        const Divider(),
        AboutListTile(
          icon: const Icon(Icons.info),
          // applicationIcon:
          // Image(image: AssetImage('app.iconSmall'.tr())),
          applicationName: appTitle,
          applicationVersion: '1.0.0',
          applicationLegalese: '© 2023-24 XBASoft',
          child: Text('menu.about'.tr()),
        ),
      ],
    );
  }
}

class _AppUserHeader extends ConsumerWidget {
  const _AppUserHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropboxAuthRepository = ref.watch(dropboxAuthRepositoryProvider);
    final AppUser? appUser = dropboxAuthRepository.appUser.value;
    if (appUser == null) {
      return const Icon(Icons.person);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(appUser.avatarUrl),
        ),
        gapH8,
        Text(appUser.name),
        Text(appUser.email, style: context.textTheme.bodySmall),
      ],
    );
  }
}
