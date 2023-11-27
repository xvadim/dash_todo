import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/build_context_extension.dart';
import '../../../common/sizes.dart';
import '../../../common/ui_utils.dart';
import 'dropbox_auth_controller.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  late final AppLifecycleListener _listener;
  bool _isAuthInProgress = false;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(onResume: () async => _loginDropbox());
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(dropboxAuthControllerProvider);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'signin.title'.tr(),
                style: context.textTheme.headlineLarge,
              ),
              _SignInButton(
                icon: const FaIcon(
                  FontAwesomeIcons.dropbox,
                  color: Colors.blue,
                ),
                title: 'signin.signinDropbox'.tr(),
                subtitle: 'signin.syncDropbox'.tr(),
                onPressed: () async => _authorizeDropbox(),
              ),
              _SignInButton(
                icon: const FaIcon(
                  FontAwesomeIcons.file,
                  color: Colors.black,
                ),
                title: 'signin.signinLocally'.tr(),
                subtitle: 'signin.syncLocally'.tr(),
                onPressed: () => showSnackBar(context, 'Not implemented yet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _authorizeDropbox() async {
    _isAuthInProgress = true;
    await ref.read(dropboxAuthControllerProvider.notifier).authorize();
  }

  Future<void> _loginDropbox() async {
    if (_isAuthInProgress) {
      await ref.read(dropboxAuthControllerProvider.notifier).login();
      _isAuthInProgress = false;
    }
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [icon, gapW8, Text(title)],
            ),
          ),
          gapH4,
          Text(subtitle),
        ],
      ),
    );
  }
}
