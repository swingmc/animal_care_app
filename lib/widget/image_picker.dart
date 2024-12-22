import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animalCare/logger/logger.dart';
import 'package:animalCare/main.dart';
import 'package:animalCare/pages/user_center/user_info_page.dart';
import 'package:animalCare/widget/bottom_selection_box.dart';
import 'package:animalCare/util/export_file.dart';

import 'package:flutter/widgets.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';


class CircleImagePicker extends StatefulWidget {
  String? imageUrl;
  Image? image;
  bool? isUserInfoPage;

  CircleImagePicker({Key? key, this.imageUrl, this.image, this.isUserInfoPage = true}) : super(key: key);

  @override
  _CircleImagePickerState createState() => _CircleImagePickerState();
}

class _CircleImagePickerState extends State<CircleImagePicker> {
  //int? _imageURL;
  String? _uploadedImageURL;

  @override
  void initState() {
    super.initState();
    //if(widget.imageUrl?.length > 0)
    //_imageURL = widget.imageUrl;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isUserInfoPage == false) {
          showBottomPopup(context, TextButton(onPressed: () {
            _editImage().then((value) => {

            });

            Navigator.pop(context);
          }, child: text("Select from the phone album")));
        } else {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => UserInfoPage(
                  image: widget.image, imageUrl: widget.imageUrl)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2
          ),
        ),
        child: CircleAvatar(
          radius: widget.isUserInfoPage == true ? 60 : 40,
          backgroundImage: widget.image?.image ?? DEFAULT_AVATAR.image,
          backgroundColor: Colors.white,
          // _imageURL != null ? NetworkImage(_imageURL??"") : null,
          //child: _imageURL == null ? Icon(Icons.add_a_photo, size: 50) : null,
          //child: widget.image,
        ),
      ),
    );
  }

  /*
  Future<void> _editImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Upload the image to the server


      File file = File(pickedImage.path);

      int? imageId = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ImageEditorWidget(imageFile: file)),
      );

      if(imageId != null) {
        Uint8List data = await UserCenterDao.getImage(imageId);
        Image avatar = Image.memory(data);
        setState(() {
          //logger.error(imageId);
          widget.image = avatar;
        });
        saveUserAvatar(imageId, data);
        myDataProvider.refreshUserData();
      }
    }
  }

   */


  Future<String?> _editImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // 获取应用程序的文档目录路径
      final directory = await getApplicationDocumentsDirectory();
      final String newPath = '${directory.path}/${pickedImage.name}';

      // 将选中的图片复制到文档目录中
      final File newImage = await File(pickedImage.path).copy(newPath);

      _uploadedImageURL = newPath;

      shareMediaProvider.setImagePath(newPath);

      // 获取图片数据
      Uint8List data = await newImage.readAsBytes();
      Image avatar = Image.memory(data);

      // 更新当前显示的图片
      setState(() {
        widget.image = avatar;
      });

      // 保存用户头像并刷新用户数据
      //saveUserAvatar(newPath, data);

      logger.error("image Path:" + newPath);

      // 返回新的文件路径
      return newImage.path;


    }
    return null;
  }

  void _bottomPop(){
    showBottomPopup(context, Container(
      height: 120,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: (){

        },
        child: textName("Select from the phone album"),
      ),
    ));
  }
}

