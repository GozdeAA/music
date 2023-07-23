import 'package:flutter/material.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        width: preferredSize.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff3b0951),
          Color(0xff130023),
        ])),
        child: Text(title,style: const TextStyle(color: Colors.white),),
      ),
    );
  }

  @override
  Size get preferredSize => Size(100.w, kToolbarHeight);
}
