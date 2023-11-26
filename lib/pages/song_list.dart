import 'package:flutter/material.dart';
import 'package:freechoice_music/utilities/constants/consts.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:freechoice_music/utilities/widgets/appbar.dart';

class SongListPage extends StatelessWidget {
  const SongListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Stack(
      children: [
        Container(
          height: 100.h,
          decoration: const BoxDecoration(gradient: gradient),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppbar(
            title: "Çalma listesi adı",
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                controller: controller,
                itemBuilder: (context, i) {
                  return Padding(
                      padding: (i != 0 && i % 8 == 0)
                          ? EdgeInsets.symmetric(horizontal: 5.w)
                          : EdgeInsets.zero,
                      child: songCard(title: "title", subtitle: "subtitle"));
                }),
          ),
        ),
      ],
    );
  }

  Card songCard({required String title, required String subtitle}) {
    return Card(
      elevation: 10,
      color: colors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: Icon(Icons.menu_open_sharp),
          onPressed: () {},
        ),
      ),
    );
  }
}
