import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../assets/assets.gen.dart';
import '../../../common/build_context_extension.dart';
import '../../../common/sizes.dart';
import '../../../common/ui_utils.dart';
import 'application/dropbox_auth_controller.dart';
import 'application/local_auth_controller.dart';
import 'widgets/or_separator.dart';

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
    final screenSize = MediaQuery.sizeOf(context);
    final separatorWidth = screenSize.width / 3;
    final logoSize = screenSize.width / 4;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'app.title'.tr(),
                style: context.textTheme.headlineLarge,
              ),
              Assets.images.logo.image(
                width: logoSize,
                height: logoSize,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(
                height: screenSize.height * 0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'signin.title'.tr(),
                      style: context.textTheme.headlineSmall,
                    ),
                    _SignInButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.dropbox,
                        color: Colors.blue,
                      ),
                      title: 'signin.signinDropbox'.tr(),
                      subtitle: 'signin.syncDropbox'.tr(),
                      onPressed: () async => await _authorizeDropbox(),
                    ),
                    OrSeparator(width: separatorWidth),
                    _SignInButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.file,
                        color: Colors.black,
                      ),
                      title: 'signin.signinLocally'.tr(),
                      subtitle: 'signin.syncLocally'.tr(),
                      onPressed: () => showSnackBar(
                        context,
                        'Not implemented yet',
                      ),
                    ),
                    OrSeparator(width: separatorWidth),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async => await _loginTutorial(),
                          child: Text('signin.withoutSync'.tr()),
                        ),
                        Text('signin.tutorialTasks'.tr()),
                      ],
                    ),
                  ],
                ),
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

  Future<void> _loginTutorial() async {
    await ref.read(localAuthControllerProvider.notifier).login();
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
