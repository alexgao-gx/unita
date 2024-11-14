import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/input_suffix_clear.dart';
import 'package:unitaapp/common/index.dart';

/// 密码文本输入框
class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget(
      {super.key,
      this.controller,
      this.hintText,
      this.isShowSuffix = true,
      this.isShowValidateText = false,  this.isShowMaxCount = false});

  final TextEditingController? controller;
  final String? hintText;
  final bool isShowSuffix;
  final bool isShowValidateText;
  final bool isShowMaxCount;
  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _isObscureText = true;

  /// status=0: initial 1: error 2: pass
  int _pwdCharacterMaxStatus = 0;
  int _pwdCharacterNumStatus = 0;
  int _pwdCharacterUpperStatus = 0;
  int _pwdCharacterSpecialStatus = 0; // New status for special character check

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if ((widget.controller?.text.length ?? 0) > 7) {
        _pwdCharacterMaxStatus = 2;
      } else {
        _pwdCharacterMaxStatus = 1;
      }
      if (Validators.containsNumber(widget.controller?.text)) {
        _pwdCharacterNumStatus = 2;
      } else {
        _pwdCharacterNumStatus = 1;
      }
      if (Validators.containsUppercase(widget.controller?.text)) {
        _pwdCharacterUpperStatus = 2;
      } else {
        _pwdCharacterUpperStatus = 1;
      }
      if (Validators.containsSpecialCharacter(widget.controller?.text)) { // Check for special character
        _pwdCharacterSpecialStatus = 2;
      } else {
        _pwdCharacterSpecialStatus = 1;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputWidget.textBorder(
          controller: widget.controller,
          type: InputWidgetType.underlineBorder,
          contentPadding: EdgeInsets.zero,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          hintText: widget.hintText,
          isObscureText: _isObscureText,
          maxLength:widget.isShowMaxCount ?  15 : null,
          suffixIcon: Align(
            widthFactor: 0.5, // 宽度为自身宽度的一倍
            alignment: Alignment.centerRight, // 靠右
            child: InputSuffixEyesIcon(
              onValueChanged: (v) {
                setState(() {
                  _isObscureText = v;
                });
              },
            ),
          ),
        ),
        Offstage(
          offstage: !widget.isShowValidateText,
          child: Column(
            children: [
              _buildValidateText('8 characters minimum'.tr, _pwdCharacterMaxStatus),
              _buildValidateText('must contain one number'.tr, _pwdCharacterNumStatus),
              _buildValidateText('one uppercase'.tr, _pwdCharacterUpperStatus),
              _buildValidateText('one special character'.tr, _pwdCharacterSpecialStatus), // New validation message
            ],
          ),
        )
      ],
    );
  }

  /// status=0: initial
  /// status=1: error
  /// status=2: pass
  Widget _buildValidateText(String text, int status) {
    String assetName = 'ico_password_circle';
    double iconSize = 8;
    Matrix4 translationMatrix = Matrix4.translationValues(0.0, 0.0, 0.0);
    Color color = AppColors.color_A7998F;
    if (status == 1) {
      assetName = 'ico_password_close';
      iconSize = 15;
      translationMatrix = Matrix4.translationValues(-3.0, 0.0, 0.0);
      color = AppColors.color_FD8A5E;
    } else if (status == 2) {
      assetName = 'ico_password_pass';
      color = AppColors.color_65AF7C;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Transform(
              transform: translationMatrix,
              child: IconWidget.svg(
                'assets/svg/$assetName.svg',
                size: iconSize,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 5),
          TextWidget(
            text: text,
            style: GoogleFonts.openSans(
                fontSize: 12, fontWeight: FontWeight.w400, color: color),
          )
        ],
      ),
    );
  }
}
