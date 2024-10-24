import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitaapp/common/index.dart';

class ContainerIcon extends StatelessWidget {
  const ContainerIcon(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.radius,
      required this.image,
        this.iconSize,
      this.onPressed});
  final double width;
  final double height;
  final Color color;
  final double radius;
  final String image;
  final double? iconSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: width,
        onPressed: onPressed,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: IconWidget.svg(
              'assets/svg/$image.svg',
              size:iconSize ?? 20,
            ),
          ),
        ));
  }
}
