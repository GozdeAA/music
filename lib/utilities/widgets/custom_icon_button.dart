import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key,
      required this.assetName,
      this.onPressed,
      this.size,
      this.flex,
      this.title,
      this.textStyle,
      this.grade})
      : super(key: key);

  final String assetName;
  final VoidCallback? onPressed;
  final double? size;
  final int? flex;
  final double? grade;
  final String? title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex ?? 1,
      child: GestureDetector(
        onTap: onPressed ?? () {},
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/images/icons/$assetName.svg",
              height: size ?? 24.sp,
            ),
            if (title != null && title!.isNotEmpty)
              SizedBox(
                width: 3.w,
              ),
            if (title != null && title!.isNotEmpty)
              Text(
                title!,
                style: textStyle,
              )
          ],
        ),
      ),
    );
  }
}
