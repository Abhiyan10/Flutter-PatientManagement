import 'package:flutter/material.dart';
import 'package:group4_project/utils/colors.dart';

customAppbar(String title, {String? subTitle = '', List<Widget>? actions}) {
  return AppBar(
    centerTitle: false,
    backgroundColor: const Color.fromARGB(255, 255, 247, 225),
    elevation: 0,
    surfaceTintColor: Colors.white,
    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      if (subTitle != '')
        Text(
          subTitle!,
          style: const TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal),
        ),
    ]),
    actions: actions,
  );
}
