import 'package:get/get.dart';
import 'package:group4_project/screens/app/add_patient.dart';
import 'package:group4_project/screens/app/add_patient_records.dart';
import 'package:group4_project/screens/app/all_patients_screen.dart';
import 'package:group4_project/screens/app/single_patient.dart';
import 'package:group4_project/screens/auth/login_screen.dart';
import 'package:group4_project/screens/auth/splash_screen.dart';

class GetRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String allPatients = '/allPatients';
  static const String singlePatient = '/singlePatient';
  static const String addPatient = '/addPatient';
  static const String addPatientRecords = '/addPatientRecords';

  static List<GetPage> routes = [
    GetPage(
      name: GetRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: GetRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: GetRoutes.allPatients,
      page: () => AllPatientsScreen(),
    ),
    GetPage(
      name: GetRoutes.singlePatient,
      page: () => SinglePatient(),
    ),
    GetPage(
      name: GetRoutes.addPatient,
      page: () => AddPatient(),
    ),
    GetPage(
      name: GetRoutes.addPatientRecords,
      page: () => AddPatientRecords(),
    ),
  ];
}
