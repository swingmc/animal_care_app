import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animalCare/util/export_file.dart';
import 'package:animalCare/widget/custom_stack_widget.dart';
import 'package:animalCare/widget/info_text_item.dart';

import '../../db/local_cache.dart';
import '../../http/dao/user_center_dao.dart';
import '../../navigator/app_navigator.dart';
import '../../widget/pop_up_dialog.dart';

class UserInfoPage extends StatelessWidget {
  final Image? image;
  final String? imageUrl;

  UserInfoPage(
      {Key? key,
        required this.image,
        required this.imageUrl
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, MyDataProvider provider, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: appTransparentBar(),
        body: Stack(
          children: [
            CustomStackWidget(
                widget: WrapWithSymetricBorder(Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 40),
                      child: firstLevelTitle("This is my info"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: InfoTextItem(
                        label : "Username",
                        text: provider.userInfo?.nickname ?? "default",
                        rightIconPath: USERCENTER_PROFILE_EDIT,
                        readOnly: false,
                      ),
                    ),
                    InfoTextItem(
                      label : "Email",
                      text : provider.userInfo?.email ?? "-2",
                    ),
                    InfoTextItem(
                      label: "User ID",
                      text : provider.userInfo?.user_id.toString() ?? "-2",
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: () {
                          showConfirmDialog(context,
                              "Sure to delete your account?", () {
                                UserCenterDao.closeAccount();
                                LocalCache.getInstance()
                                    .remove(TOKEN_KEY);
                                AppNavigator.getInstance()?.onJumpTo(
                                    RouteStatus.login);
                              });
                        },
                        child: const Text(
                          "Delete account",
                          style: TextStyle(
                              color: errorInfoColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    )
                  ],
                )
                ))
          ],
        ),
      );
    });
  }
}
