import 'package:nestjs_test_flutter/app/routes/app_pages.dart';
import 'package:nestjs_test_flutter/app/screen/Mypage/controller/mypage_controller.dart';
import 'package:nestjs_test_flutter/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MypageView extends GetView<MypageController> {
  const MypageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              title: Obx(
                () => Text(
                  'testuser 님의 계정 정보',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            body: Center(
              child: Container(
                child: SizedBox(
                  width: 300,
                  child: ListView(
                    children: [
                      // TODO : implement the showable widget list.
                      // for example, like the CreateStory view.
                      ListViewIdField(),
                      ListViewLogOutButton(),
                      ListViewWithDrawButton(),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget ListViewIdField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
            width: 80,
            child: Text(
              "ID",
              textAlign: TextAlign.center,
            )),
        Expanded(
            child: TextField(
          enabled: false,
          controller: controller.idTextControl,
        ))
      ],
    );
  }



  Widget ListViewLogOutButton() {
    return Padding(
      padding: EdgeInsets.only(left: 75, right: 75, top: 15, bottom: 5),
      child: ElevatedButton(
        child: const Text("로그아웃"),
        onPressed: controller.logout,
      ),
    );
  }

  Widget ListViewWithDrawButton() {
    return Padding(
      padding: EdgeInsets.only(left: 75, right: 75, top: 15, bottom: 5),
      child: ElevatedButton(
          child: const Text(
            "회원 탈퇴",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red[300]),
          onPressed: () {
            Get.defaultDialog(
                title: "경고",
                content: Text("회원 탈퇴 시, 10년 내 사망 확률이 유의미하게 증가할 수 있습니다. 정말 탈퇴하시겠습니까?"),
                onCancel: () {},
                onConfirm: controller.withDraw);
          }),
    );
  }
}
