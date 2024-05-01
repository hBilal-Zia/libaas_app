import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/form_validator.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/component/appbar_component.dart';
import 'package:libaas_app/component/textfield_component.dart';
import 'package:libaas_app/views/add_item/controller/add_item_controller.dart';
import 'package:http/http.dart' as http;

import '../../common_widget/text_global.dart';

class ItemDetailScreen extends StatelessWidget {
  final String image;
  final String style;
  final String category;
  final String color;
  final String season;
  final String gender;
  ItemDetailScreen(
      {super.key,
      required this.image,
      required this.style,
      required this.category,
      required this.color,
      required this.season,
      required this.gender});
  final AddItemController _addItemController = Get.put(AddItemController());
  // final FirebaseAuth _auth = FirebaseAuth.instance;

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
                title: 'Details',
                isBack: true,
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
                          child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        alignment: Alignment.center,
                        height: 260,
                        width: 300,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3))
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                            color: Color(0xffF7F1F1)),
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.contain,
                          )),
                        ),
                      )),
                      Spaces.mid,
                      TextFieldComponent(
                        hintColor: const Color(0xff24686D).withOpacity(0.6),
                        readOnly: true,
                        validator: FormValidator.validateName,
                        hintText: 'Style',
                        textEditingController:
                            _addItemController.descController,
                      ),
                      Spaces.smallh,
                      Center(
                        child: textGlobalWidget(
                            text: style,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                            textColor: Colors.black),
                      ),
                      Spaces.smallh,
                      TextFieldComponent(
                        hintColor: const Color(0xff24686D).withOpacity(0.6),
                        readOnly: true,
                        validator: FormValidator.validateName,
                        hintText: 'Category',
                        textEditingController:
                            _addItemController.categoryController,
                      ),
                      Spaces.smallh,
                      Center(
                        child: textGlobalWidget(
                            text: category,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                            textColor: Colors.black),
                      ),
                      Spaces.smallh,
                      TextFieldComponent(
                        hintColor: const Color(0xff24686D).withOpacity(0.6),
                        readOnly: true,
                        validator: FormValidator.validateName,
                        hintText: 'Color',
                        textEditingController:
                            _addItemController.colorController,
                      ),
                      Spaces.smallh,
                      Center(
                        child: textGlobalWidget(
                            text: color,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                            textColor: Colors.black),
                      ),
                      Spaces.smallh,
                      TextFieldComponent(
                        hintColor: const Color(0xff24686D).withOpacity(0.6),
                        readOnly: true,
                        validator: FormValidator.validateName,
                        hintText: 'Season',
                        textEditingController:
                            _addItemController.seasonController,
                      ),
                      Spaces.smallh,
                      Center(
                        child: textGlobalWidget(
                            text: season,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                            textColor: Colors.black),
                      ),
                      Spaces.smallh,
                      TextFieldComponent(
                        hintColor: const Color(0xff24686D).withOpacity(0.6),
                        readOnly: true,
                        validator: FormValidator.validateName,
                        hintText: 'Gender',
                        textEditingController:
                            _addItemController.genderController,
                      ),
                      Spaces.smallh,
                      Center(
                        child: textGlobalWidget(
                            text: gender,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                            textColor: Colors.black),
                      ),
                      Spaces.large,
                      Spaces.large,
                    ]),
              ),
            ))),
      ),
    );
  }
}
