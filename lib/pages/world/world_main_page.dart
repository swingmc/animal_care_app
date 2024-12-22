import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animalCare/main.dart';
import 'package:animalCare/pages/map/map.dart';
import 'package:animalCare/util/provider/collection_provider.dart';
import 'package:animalCare/widget/custom_stack_widget.dart';
import 'package:animalCare/widget/world/float_button.dart';
import 'package:animalCare/widget/world/world_message_card.dart';
import 'package:animalCare/http/dao/animal_dao.dart';
import 'package:animalCare/widget/world/Media.dart';
import 'package:animalCare/pages/map/map.dart';
import 'package:animalCare/model/my_marker.dart';
import '../../util/color.dart';
import '../../util/ui_layout.dart';
import 'package:provider/provider.dart';









class WorldMainPage extends StatefulWidget {
  const WorldMainPage({super.key});

  @override
  State<WorldMainPage> createState() => _WorldMainPageState();
}

class _WorldMainPageState extends State<WorldMainPage>
    with SingleTickerProviderStateMixin {

  final List<Tab> tabs = [
    Tab(height: 40, child: Text('List', style: TextStyle(fontSize: 20),)),
    Tab(height: 40, child: Text('Grid', style: TextStyle(fontSize: 20),)),
  ];

  /*
  List<MyMarker> _mediaList = [
    MyMarker("A injured deer", "it's leg is broken, need rescue", "assets/animal/deer.png", 52.0919, 5.1230),
    MyMarker("A bird", "a bird with head blooded", "assets/animal/bird.png", 52.0705, 4.3007),
    MyMarker("A homeless fox", "need food", "assets/animal/fox.png", 52.3676, 4.9041),
    MyMarker("A died tiger", "need funeral", "assets/animal/tiger.png", 52.1676, 4.6041),
    MyMarker("A injureed bird", "need rescue", "assets/animal/bird2.png", 52.5705, 4.5007),
  ];

   */


  late TabController tabController;

  @override
  void initState() {
    super.initState();

    AnimalDao.getPost().then((value) {
      setState(() {
        var emptyList = List<Media>.empty();
        (value.data?.media_list as List<dynamic>).cast<Media>() ?? emptyList;
      });
    });

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomStackWidget(widget: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: WrapWithSymetricBorder(TabBar(
                      tabs: tabs,
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                      ),
                      controller: tabController,
                      indicator: const BoxDecoration(
                        color: Colors.transparent,
                        // Set the background color of the selected tab
                        border: Border(
                          bottom: BorderSide(width: 2.0,
                              color: buttonTagColor), // Set the underline color and thickness
                        ),
                      ),
                      // Customize the indicator color
                      labelColor: buttonTagColor,
                      // Customize the selected tab label color
                      unselectedLabelColor: titleColor, // Customize the unselected tab label color
                    ))),
                Expanded(flex: 9, child: TabBarView(
                  controller: tabController,
                  children: [

                    Consumer<ShareMediaProvider>(builder: (context, provider, child) {
                      return ListView.builder(
                          itemCount: provider.mediaList.length,
                          itemBuilder: (context, index) {
                            return WrapWithSymetricBorder(WorldMessageCard(media: Media(
                                provider.mediaList[index].path, provider.mediaList[index].title, provider.mediaList[index].desc, provider.mediaList[index].lati, provider.mediaList[index].longti)));
                          });
                    }),

                    Container(),

                  ],
                ))
              ]
          ),
        ),
      )),
      floatingActionButton: const WorldFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}