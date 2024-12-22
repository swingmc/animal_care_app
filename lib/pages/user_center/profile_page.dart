import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:animalCare/core/app_state.dart';
import 'package:animalCare/db/local_cache.dart';
import 'package:animalCare/pages/user_center/change_password_page.dart';
import 'package:animalCare/util/export_file.dart';
import 'package:animalCare/widget/click_item.dart';
import 'package:animalCare/navigator/app_navigator.dart';
import 'package:animalCare/http/dao/user_center_dao.dart';
import 'package:animalCare/widget/custom_stack_widget.dart';
import 'package:animalCare/widget/pop_up_dialog.dart';
import 'package:animalCare/util/text.dart';
import 'package:animalCare/widget/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:animalCare/http/request/user_center/get_feedback_req.dart';
import 'package:flutter/foundation.dart';
import 'package:animalCare/widget/click_item_container.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends PageState<ProfilePage> {
  GetUserInfoResult? userInfo;
  Image? avatar = DEFAULT_AVATAR;

  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();

  List<Image>? iconItems;
  List<String>? texts;
  List<VoidCallback>? onPressed;

  late List<dynamic> group_1;
  late List<dynamic> group_2;
  late List<dynamic> group_3;
  late List<dynamic> group_4;

  @override
  void initState() {
    super.initState();
    if (LocalCache.getInstance().get(KEY_PROFILE_GUIDE_POPPED) == null || !LocalCache.getInstance().get(KEY_PROFILE_GUIDE_POPPED)) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([_one, _two, _three]);
      });
    }


    group_1 = [
      /*
      ClickItem(text: "Bird house management", leftIconPath: USERCENTER_EQUIPMENT_MANAGEMENT, onPressed: () {
        {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EquipmentManagementPage()),
          );
        }
      }),

       */

    ];

    group_2 = [


    ];

    group_3 = [
      ClickItem(text: "Change password", leftIconPath: USERCENTER_CHANGE_PASSWORD, onPressed: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChangePasswordPage()),);
      }),
    ];
    
    group_4 = [

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, MyDataProvider provider, child) {
      avatar = provider.avatar;
      userInfo = provider.userInfo;
      return Scaffold(
        backgroundColor: bgColor,
        resizeToAvoidBottomInset: false,
        body: CustomStackWidget(
            isDeep: true,
            widget: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Column(
                        children: [

                          Container(
                              margin: EdgeInsets.only(top: 52),
                              child: CircleImagePicker(
                                    imageUrl: userInfo?.avatar_url ?? "",
                                    image: avatar,
                                    isUserInfoPage: false,
                                  )),


                          Container(
                            alignment: Alignment.topCenter,
                            child: textName(
                                userInfo?.nickname ?? "default"),
                          ),
                          textTag('User ID: ${userInfo?.user_id}'),
                        ])
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                            children: [
                              ClickItemContainer(itemList: group_1),
                              ClickItemContainer(itemList: group_2),
                              ClickItemContainer(itemList: group_3),
                              ClickItemContainer(itemList: group_4),

                              Container(
                                margin: const EdgeInsets.only(top: 21, left: 40),
                                child: InkWell(
                                  onTap: () {
                                    showConfirmDialog(context,
                                        "Sure to log out?", () {
                                          LocalCache.getInstance()
                                              .remove(TOKEN_KEY);
                                          AppNavigator.getInstance()
                                              ?.onJumpTo(
                                              RouteStatus.login);
                                        });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(USERCENTER_ICON_LOGOUT, width: 20, height: 20),
                                      Container(
                                        margin: const EdgeInsets.only(left: 12),
                                        child: text_popver('Log out', textAlign: TextAlign.start),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                height: 40,
                              )
                            ]
                        )),
                  ),
                )
              ],
            )),
      );
    });
  }
}
