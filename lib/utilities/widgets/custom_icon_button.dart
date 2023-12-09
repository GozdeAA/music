import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key, required this.assetName, this.onPressed, this.size, this.flex, this.grade})
      : super(key: key);

  final String assetName;
  final VoidCallback? onPressed;
  final double? size;
  final int? flex;
  final double? grade;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex ?? 1,
      child: GestureDetector(
        onTap: onPressed ?? () {},
        child: SvgPicture.asset(
          "assets/images/icons/$assetName.svg",
          height: size ?? 24.sp,
        ),
      ),
    );
  }
}
