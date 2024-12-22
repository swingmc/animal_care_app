import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:animalCare/main.dart';
//import 'package:animalCare/pages/collection/collection_share_page.dart';
import 'package:animalCare/util/export_file.dart';
import 'package:animalCare/util/provider/collection_provider.dart';
import 'package:animalCare/widget/custom_stack_widget.dart';
import 'package:animalCare/widget/general_button.dart';
import 'package:animalCare/widget/image_picker.dart';
import 'package:animalCare/model/my_marker.dart';

class WorldSharePage extends StatefulWidget {
  const WorldSharePage({super.key});

  @override
  State<WorldSharePage> createState() => _WorldSharePageState();
}

class _WorldSharePageState extends State<WorldSharePage> {

  uploadImage() {
    //Navigator.push(context, MaterialPageRoute(builder: (_) => ContributePhotoPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: appTitleBar(
          "Share",
          isTransparent: true,
          onPressReturn: (){
            Navigator.of(context).popUntil((route) => route.isFirst);

          }),
      body: PopScope(
        canPop: false,
        child: CustomStackWidget(widget: SafeArea(
            child: WrapWithSymetricBorder(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: TextField(
                        autofocus: false,
                        controller: shareMediaProvider.controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Input info about injured animal',
                            hintStyle: TextStyle(color: buttonTagColor_01, fontSize: 14)
                        ),
                      ),
                    )
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 40),
                  child: textTitle("Add photos/videos"),
                ),
                /*
                Consumer<ShareMediaProvider>(
                    builder: (context, provider, child) {
                      if (provider.shareMediaList.isEmpty) {
                        return Container(
                          margin: const EdgeInsets.only(top: 16),
                          width: 100,
                          height: 100,
                          child: _addPicContainer(),
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: _mediaContainer(),
                        );
                      }
                    }),

                 */
                CircleImagePicker(

                  isUserInfoPage: false,
                ),
                Spacer(),
                Expanded(child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ClickCustomButton(label: 'Post', onPressed: () {
                      MyMarker marker = MyMarker(
                          shareMediaProvider.controller.text,
                          shareMediaProvider.controller.text,
                          shareMediaProvider.imagePath,
                          shareMediaProvider.latitude,
                          shareMediaProvider.longitude
                      );
                      shareMediaProvider.addMarker(marker);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                  }),
                ))
              ],
            ))
        )),
      ),
    );
  }



  _addPicContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black12
      ),
      child: InkWell(
        onTap: () {
          // if (deviceDataProvider.myEquipment.length == 1) {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => CollectionSharePage(deviceNo: '231002423'))
          //   );
          // } else if (deviceDataProvider.myEquipment.isEmpty) {
          //
          // } else {
          //
          // }
          /*
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CollectionSharePage(deviceNo: '231002423')));

           */
        },

        child: Image.asset(BIRDBOOK_ADD_PHOTO, fit: BoxFit.cover),
      ),
    );
  }
}
