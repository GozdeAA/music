import 'package:flutter/material.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';

class BackgroundGrad extends StatelessWidget {
  const BackgroundGrad(
      {Key? key, this.child, this.height, this.colors, this.width})
      : super(key: key);

  final Widget? child;
  final double? height;
  final double? width;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 100.h,
      width: width ?? 100.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors ??
                  [
                    const Color(0xff3b0951),
                    const Color(0xff130023),
                  ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      child: child,
    );
  }
}
