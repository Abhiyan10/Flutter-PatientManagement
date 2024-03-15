import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:group4_project/controllers/patient_controller.dart';
import 'package:group4_project/models/patient.dart';
import 'package:group4_project/utils/base_url.dart';
import 'package:group4_project/widgets/custom_appbar.dart';
import 'package:group4_project/widgets/custom_button.dart';

class AddPatient extends StatelessWidget {
  AddPatient({super.key});

  final Patient? patient = Get.arguments != null ? Get.arguments[0] : null;
  final String type = Get.arguments != null ? Get.arguments[1] : 'Add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 225),
      appBar: customAppbar('$type Patient'),
      body: GetBuilder<PatientController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        enabled: !controller.patientLoading,
                        controller: controller.nameController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Name'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        enabled: !controller.patientLoading,
                        controller: controller.addressController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Address'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                          controller.selectDate(context);
                        },
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFD9D9D9),
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'DOB: ${controller.selectedDate}'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 7,
                      child: TextFormField(
                        enabled: !controller.patientLoading,
                        controller: controller.phoneController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Phone'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x1C000000),
                              blurRadius: 8.30,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: DropdownButton(
                          underline: Container(),
                          value: controller.gender,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: controller.genders.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (controller.patientLoading) return;
                            controller.gender = newValue!;
                            controller.update();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x1C000000),
                              blurRadius: 8.30,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: DropdownButton(
                          underline: Container(),
                          value: controller.ward,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: controller.wards.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (controller.patientLoading) return;
                            controller.ward = newValue!;
                            controller.update();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x1C000000),
                        blurRadius: 8.30,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: DropdownButton(
                    underline: Container(),
                    value: controller.condition,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: controller.conditions.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (controller.patientLoading) return;
                      controller.condition = newValue!;
                      controller.update();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  enabled: !controller.patientLoading,
                  controller: controller.descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Description'),
                ),
                const SizedBox(height: 10),
                CustomButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    label: 'Image'),
                const SizedBox(height: 10),
                if (controller.imageFile != null)
                  Image.file(
                    File(controller.imageFile!.path),
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return const Center(
                          child: Text('This image type is not supported'));
                    },
                  ),
                if (type == 'Edit' && controller.imageFile == null)
                  Image.network(patient!.image!.substring(0, 4) == "http"
                      ? patient!.image!
                      : imgUrl + patient!.image!),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButton(
                        loading: controller.patientLoading,
                        onPressed: () {
                          if (type == 'Add') {
                            controller.addPatient();
                          } else {
                            controller.editPatient(patient!.id.toString());
                          }
                        },
                        label: '$type Patient'),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
