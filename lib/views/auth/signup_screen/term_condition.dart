import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/appbar_component.dart';

class TermConditionScreen extends StatelessWidget {
  const TermConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10.0),
              child: AppBarComponent(),
            )),
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 85.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spaces.smallh,
                      textGlobalWidget(
                          text: 'Last updated on 1/12/2023',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          textColor: const Color(0xff7C7C7C)),
                      Spaces.large,
                      textGlobalWidget(
                          text: ' 1. Clause 1',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          textColor: const Color(0xff494949)),
                      Spaces.smallh,
                      textGlobalWidget(
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                          textColor: const Color(0xff494949)),
                      Spaces.large,
                      textGlobalWidget(
                          text: ' 2. Clause 2',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          textColor: const Color(0xff494949)),
                      Spaces.smallh,
                      textGlobalWidget(
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                          textColor: const Color(0xff494949)),
                      Spaces.mid,
                      textGlobalWidget(
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                          textColor: const Color(0xff494949)),
                      Spaces.mid,
                      textGlobalWidget(
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                          textColor: const Color(0xff494949)),
                      Spaces.large,
                    ]),
              ),
            ))),
      ),
    );
  }
}
