import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/build_context_extension.dart';
import '../../../common/sizes.dart';
import '../../../common/ui_utils.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: () => print('tap'),
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
