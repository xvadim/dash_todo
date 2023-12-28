import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrSeparator extends StatelessWidget {
  const OrSeparator({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          const Expanded(
            child: Divider(indent: 8, endIndent: 8),
          ),
          Text('signin.or'.tr()),
          const Expanded(
            child: Divider(indent: 8, endIndent: 8),
          ),
        ],
      ),
    );
  }
}
