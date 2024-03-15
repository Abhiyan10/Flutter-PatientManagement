import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:group4_project/controllers/patient_controller.dart';
import 'package:group4_project/models/patient.dart';
import 'package:group4_project/routes.dart';
import 'package:group4_project/utils/base_url.dart';
import 'package:group4_project/utils/colors.dart';
import 'package:group4_project/utils/shared_prefs.dart';
import 'package:group4_project/widgets/custom_appbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:group4_project/widgets/custom_button.dart';

class AllPatientsScreen extends StatelessWidget {
  AllPatientsScreen({super.key});

  final patientController = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 225),
      appBar: customAppbar(
        'All Patients',
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Get.toNamed(GetRoutes.addPatient);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x30000000),
                      blurRadius: 7.90,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  '+ Add Patient',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        title: const Text('Logout?'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          Row(
                            children: [
                              CustomButton(
                                onPressed: () async {
                                  await SharedPrefs().removeUser();
                                  Get.toNamed(GetRoutes.splash);
                                },
                                label: 'Yes',
                                buttonType: 'secondary',
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                label: 'No',
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x30000000),
                        blurRadius: 7.90,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
      body: GetBuilder<PatientController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black26),
                ),
                child: TextFormField(
                  onChanged: (String val) {
                    controller.searchText = val;
                    controller.searchPatients(val, controller.searchCondition);
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFFFFFF),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search. . .'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black26),
                ),
                child: DropdownButton(
                  underline: Container(),
                  value: controller.searchCondition,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: controller.conditions.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(
                          color: items == 'Choose Condition'
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue == 'Choose Condition') return;
                    controller.searchCondition = newValue!;
                    controller.searchPatients(controller.searchText, newValue);
                    controller.update();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: controller.searchCondition != 'Choose Condition' ||
                    controller.searchText.isNotEmpty,
                child: InkWell(
                  onTap: () {
                    controller.searchCondition = 'Choose Condition';
                    controller.searchText = '';
                    controller.searchPatients('', '');
                    controller.update();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x30000000),
                          blurRadius: 7.90,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      'x',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: controller.patientLoading &&
                          controller.allPatients.isEmpty
                      ? const CircularProgressIndicator()
                      : Column(
                          children: controller.filteredPatients
                              .map((e) => Column(
                                    children: [
                                      Slidable(
                                        endActionPane: ActionPane(
                                          openThreshold: 0.4,
                                          extentRatio: 0.7,
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (a) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        surfaceTintColor:
                                                            Colors.white,
                                                        title: const Text(
                                                            'Delete Patient?'),
                                                        content: const Text(
                                                            'Are you sure you want to delete this patient?'),
                                                        actions: [
                                                          Row(
                                                            children: [
                                                              CustomButton(
                                                                onPressed:
                                                                    () async {
                                                                  controller
                                                                      .deletePatient(
                                                                          e.id);
                                                                },
                                                                label: 'Yes',
                                                                buttonType:
                                                                    'secondary',
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              CustomButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                label: 'No',
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 0, 0),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Delete',
                                              flex: 1,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            SlidableAction(
                                              onPressed: (a) {
                                                controller.prefillFields(e);
                                                Get.toNamed(
                                                    GetRoutes.addPatient,
                                                    arguments: [e, 'Edit']);
                                              },
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 179, 139),
                                              foregroundColor: Colors.black,
                                              icon: Icons.edit,
                                              label: 'Edit',
                                              flex: 1,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          ],
                                        ),
                                        child: PatientCard(patient: e),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class PatientCard extends StatelessWidget {
  const PatientCard({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    print(patient.image!.substring(0, 4) == "http"
        ? patient.image!
        : imgUrl + patient.image!);
    return InkWell(
      onTap: () {
        final patientController = Get.find<PatientController>();
        patientController.fetchAllPatientRecords(patient.id.toString());
        Get.toNamed(GetRoutes.singlePatient, arguments: patient);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x30000000),
              blurRadius: 7.90,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Image.network(
                patient.image!.substring(0, 4) == "http"
                    ? patient.image!
                    : imgUrl + patient.image!,
                fit: BoxFit.cover,
                height: 130,
                width: 130,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: patient.conditions!.toLowerCase() == 'normal'
                          ? Colors.green
                          : patient.conditions!.toLowerCase() == 'out of danger'
                              ? const Color.fromARGB(255, 114, 85, 0)
                              : Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      patient.conditions!,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Text(
                    patient.name!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Ward: ${patient.ward}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'DOB: ${patient.dob?.toString().split(' ')[0]}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Address: ${patient.address}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
