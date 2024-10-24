import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/icon.dart';

class InputSuffixClearIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const InputSuffixClearIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 24,
      onPressed: onTap,
      child: IconWidget.svg(
        'assets/svg/close.svg',
        size: 18,
      ),
    );
  }
}

/// The password show or not icon with input form.
class InputSuffixEyesIcon extends StatefulWidget {
  final ValueChanged<bool>? onValueChanged;

  const InputSuffixEyesIcon({super.key, this.onValueChanged});

  @override
  State<InputSuffixEyesIcon> createState() => _InputSuffixEyesIconState();
}

class _InputSuffixEyesIconState extends State<InputSuffixEyesIcon> {

  bool _passwordShow = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 24,
      onPressed: () {
        widget.onValueChanged?.call(_passwordShow);
        setState(() {
          _passwordShow = !_passwordShow;
        });
      },
      child: IconWidget.svg(
        _passwordShow ? 'assets/svg/ico_show_password_sel.svg' : 'assets/svg/ico_show_password_nor.svg',
        size: 24,
      ),
    );
  }
}
