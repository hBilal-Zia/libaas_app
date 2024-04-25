import 'package:flutter/material.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/appbar_component.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10.0),
              child: AppBarComponent(
                title: 'Notification',
                isBack: false,
                isShowUser: false,
                isShowDone: false,
              ),
            )),
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spaces.large,
                      Center(
                        child: textGlobalWidget(
                            text: 'Activity',
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.black),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: textGlobalWidget(
                            text: 'Hello Ali Check Your Today’s Outfit',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.black),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: textGlobalWidget(
                            text: 'Ali Try a New Outfit',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.black),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 2,
                      ),
                    ]),
              ),
            ))),
      ),
    );
  }
}
