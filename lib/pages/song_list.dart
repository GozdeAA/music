
import 'package:flutter/material.dart';
import 'package:freechoice_music/utilities/constants/consts.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:freechoice_music/utilities/widgets/appbar.dart';
import 'package:get/get.dart';
//SCALING ITEMS IN LIST
class SongListPage extends StatelessWidget {
  const SongListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
    ScrollController scrollController = ScrollController();
    return Stack(
      children: [
        Container(
          height: 100.h,
          decoration: const BoxDecoration(gradient: gradient),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppbar(
            title: "Çalma listesi adı",
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedList(
              key: listKey,
              initialItemCount: 99,
              shrinkWrap: true,
              controller: scrollController,
              itemBuilder: (context, i, animation) {
                RxDouble newScale = 1.0.obs;
                //newScale.value = (i != 0 && i % 8 == 0) ? 0.9 : 1;
                scrollController.addListener(() async {
                  var a = getPos(listKey);
                  if ((i != 0 && i % 8 == 0) && a.dy == 88) {
                    newScale.value = 0.9;
                    getPos(listKey);
                    newScale.value=1;
                  } else if((i != 0 && i % 8 == 0) && a.dy != 88){
                    newScale.value = 1.0;
                  }
                });
                //  print(a.dy);

                return Obx(
                      () => AnimatedScale(
                      duration: const Duration(seconds: 1),
                      scale: newScale.value,
                      child: songCard(
                        title: "title",
                        onPressed: () {
                          newScale.value = 1.0;
                        },
                        subtitle: "subtitle",
                      )),
                );
                // return songCard(title: "title", subtitle: "subtitle");
              },
            ),
          ),
        ),
      ],
    );
  }

  Offset getPos(listKey){
    final RenderBox renderBox =
    listKey.currentContext?.findRenderObject() as RenderBox;
    var a = renderBox.localToGlobal(Offset.zero);
    return a ;
  }
  Card songCard(
      {required String title,
        required String subtitle,
        VoidCallback? onPressed}) {
    return Card(
      elevation: 10,
      color: colors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: const Icon(Icons.menu_open_sharp),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
