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

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});
  final AddItemController _addItemController = Get.put(AddItemController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                  DateTime now = DateTime.now();

                  String formattedDateTime =
                      DateFormat('yyyy-MM-dd hh:mm:ss a').format(now);
                  if (_addItemController.isImage == true) {
                    debugPrint('Formatted Date and Time: $formattedDateTime');

                    _addItemController.addItemFirebase({
                      'category': _addItemController.jsonResponse['features']
                          ['Wear Type'],
                      'style': _addItemController.jsonResponse['features']
                          ['Style'],
                      'color': _addItemController.jsonResponse['color'],
                      'season': _addItemController.jsonResponse['features']
                          ['Weather'],
                      'gender': _addItemController.jsonResponse['features']
                          ['Gender'],
                      'image': _addItemController.downloadURL,
                      'userId': _auth.currentUser!.uid,
                      'recentlyUsed': true,
                      'lastUsed': formattedDateTime
                    });
                    _addItemController.updateImage();
                    _addItemController.isValue.value = false;
                    String code = "Item added successfully!!";
                    var snackbar = SnackBar(
                      content: Text(code),
                      backgroundColor: Colors.green,
                    );
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
              ),
            )),
        body: Stack(
          children: [
            containerGlobalWidget(Padding(
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
                                    return controller.isImage == true
                                        ? Container(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: MemoryImage(
                                                controller.bytes,
                                              ),
                                              fit: BoxFit.contain,
                                            )),
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
                            hintText: 'Style',
                            textEditingController:
                                _addItemController.descController,
                          ),
                          Spaces.smallh,
                          Obx(() {
                            return Visibility(
                              visible: _addItemController.isValue.value,
                              child: _addItemController.jsonResponse.isNotEmpty
                                  ? Center(
                                      child: textGlobalWidget(
                                          text: _addItemController
                                                  .jsonResponse['features']
                                              ['Style'],
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.start,
                                          textColor: Colors.black),
                                    )
                                  : Container(),
                            );
                          }),
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
                          Obx(() {
                            return Visibility(
                              visible: _addItemController.isValue.value,
                              child: _addItemController.jsonResponse.isNotEmpty
                                  ? Center(
                                      child: textGlobalWidget(
                                          text: _addItemController
                                                  .jsonResponse['features']
                                              ['Wear Type'],
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.start,
                                          textColor: Colors.black),
                                    )
                                  : Container(),
                            );
                          }),
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
                          Obx(() {
                            return Visibility(
                              visible: _addItemController.isValue.value,
                              child: _addItemController.jsonResponse.isNotEmpty
                                  ? Center(
                                      child: textGlobalWidget(
                                          text: _addItemController
                                              .jsonResponse['color'],
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.start,
                                          textColor: Colors.black),
                                    )
                                  : Container(),
                            );
                          }),
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
                          Obx(() {
                            return Visibility(
                              visible: _addItemController.isValue.value,
                              child: _addItemController.jsonResponse.isNotEmpty
                                  ? Center(
                                      child: textGlobalWidget(
                                          text: _addItemController
                                                  .jsonResponse['features']
                                              ['Weather'],
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.start,
                                          textColor: Colors.black),
                                    )
                                  : Container(),
                            );
                          }),
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
                          Obx(() {
                            return Visibility(
                              visible: _addItemController.isValue.value,
                              child: _addItemController.jsonResponse.isNotEmpty
                                  ? Center(
                                      child: textGlobalWidget(
                                          text: _addItemController
                                                  .jsonResponse['features']
                                              ['Gender'],
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.start,
                                          textColor: Colors.black),
                                    )
                                  : Container(),
                            );
                          }),
                          Spaces.large,
                          Spaces.large,
                        ]),
                  ),
                ))),
            Obx(() {
              return _addItemController.isLoading == true
                  ? Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.grey.withOpacity(0.5),
                      child: const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
