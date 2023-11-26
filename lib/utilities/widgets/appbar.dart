import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freechoice_music/utilities/constants/consts.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    required this.title,
    this.leading,
    this.trailing,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
        ), //ilgi renk eklenebilir
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(1.h),
            height: preferredSize.height,
            width: preferredSize.width,
            decoration: const BoxDecoration(gradient: gradient),
            child: Row(children: [
              leading != null
                  ? Flexible(flex: 1, child: leading!)
                  : Flexible(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () async {
                            if (await Navigator.maybePop(context)) {
                              Get.back();
                            }
                          },
                          child: Icon(
                            CupertinoIcons.chevron_down,
                            color: colors.primary,
                          )),
                    ),
              Flexible(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp)),
                ),
              ),
              if (trailing != null) Flexible(child: trailing!)
            ]),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(100.w, kToolbarHeight);
}
