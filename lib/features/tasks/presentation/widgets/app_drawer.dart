import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/build_context_extension.dart';
import '../../../../common/consts.dart';
import '../../../../common/sizes.dart';
import '../../../authentication/domain/app_user.dart';
import '../../../authentication/presentation/application/app_user_controller.dart';
import '../../../authentication/presentation/application/dropbox_auth_controller.dart';
import '../../../core/sync_type_provider.dart';
import '../../../../routing/app_router.dart';

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
              onTap: () async => _logout(ref),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text('menu.settings'.tr()),
          onTap: () {
            context.pop();
            context.pushNamed(AppRoute.filesSetup.name);
          },
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

  Future<void> _logout(WidgetRef ref) async {
    await Future.wait([
      ref.read(syncTypeProvider).setSyncType(SyncType.unset),
      ref.read(appUserControllerProvider).logout(),
      ref.read(dropboxAuthControllerProvider.notifier).logout(),
    ]);
  }
}

class _AppUserHeader extends ConsumerWidget {
  const _AppUserHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUserCtr = ref.watch(appUserControllerProvider);
    final AppUser? appUser = appUserCtr.appUser.value;
    if (appUser == null) {
      return const Icon(Icons.person);
    }
    final avatarUrl = appUser.avatarUrl;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage:
              avatarUrl.isEmpty ? null : CachedNetworkImageProvider(avatarUrl),
          child: avatarUrl.isNotEmpty ? null : Text(appUser.name[0]),
        ),
        gapH8,
        Text(appUser.name),
        Text(appUser.email, style: context.textTheme.bodySmall),
      ],
    );
  }
}
