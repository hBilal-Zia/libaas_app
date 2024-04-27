import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/form_validator.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/component/appbar_component.dart';
import 'package:libaas_app/component/textfield_component.dart';
import 'package:libaas_app/views/add_item/controller/add_item_controller.dart';

import '../../common_widget/text_global.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});
  final AddItemController _addItemController = Get.put(AddItemController());
  bool isValue = true;
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
                title: 'Add items',
                isBack: false,
                isShowUser: false,
                isShowDone: true,
                onClick: () {
                  _addItemController.descController.clear();
                  _addItemController.categoryController.clear();
                  _addItemController.colorController.clear();
                  _addItemController.seasonController.clear();
                  _addItemController.genderController.clear();
                  _addItemController.imageUpdate();
                },
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
                        child: GestureDetector(
                          onTap: () {
                            _addItemController.showOptions(context);
                          },
                          child: GetBuilder<AddItemController>(
                              init: AddItemController(),
                              builder: (controller) {
                                return controller.image != null
                                    ? Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(
                                                    controller.image!),
                                                fit: BoxFit.cover)),
                                      )
                                    : const Icon(
                                        Icons.add,
                                        size: 80,
                                        color: Colors.black,
                                      );
                              }),
                        ),
                      )),
                      Spaces.mid,
                      TextFieldComponent(
                        hintColor: const Color(0xff24686D).withOpacity(0.6),
                        readOnly: true,
                        validator: FormValidator.validateName,
                        hintText: 'Description',
                        textEditingController:
                            _addItemController.descController,
                      ),
                      Spaces.smallh,
                      Visibility(
                        visible: isValue,
                        child: Center(
                          child: textGlobalWidget(
                              text: 'Casual Hoodies Sleeve',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                              textColor: Colors.black),
                        ),
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
                      Visibility(
                        visible: isValue,
                        child: Center(
                          child: textGlobalWidget(
                              text: 'Hoodies',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                              textColor: Colors.black),
                        ),
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
                      Visibility(
                        visible: isValue,
                        child: Center(
                          child: textGlobalWidget(
                              text: 'Silver',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                              textColor: Colors.black),
                        ),
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
                      Visibility(
                        visible: isValue,
                        child: Center(
                          child: textGlobalWidget(
                              text: 'Winter',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                              textColor: Colors.black),
                        ),
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
                      Visibility(
                        visible: isValue,
                        child: Center(
                          child: textGlobalWidget(
                              text: 'Male',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                              textColor: Colors.black),
                        ),
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
