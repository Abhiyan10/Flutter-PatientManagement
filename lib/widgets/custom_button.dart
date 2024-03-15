import 'package:group4_project/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.fontSize = 20,
      this.loading = false,
      this.buttonType = 'primary'})
      : super(key: key);

  final Function onPressed;
  final String label;
  final double fontSize;
  final bool loading;
  final String buttonType;

  @override
  Widget build(BuildContext context) {
    bool isPrimary = buttonType == 'primary';

    return InkWell(
      onTap: () {
        if (!loading) {
          onPressed();
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
            color: isPrimary ? AppColors.secondaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(13.0),
            border: Border.all(
                color: isPrimary
                    ? Colors.transparent
                    : const Color.fromARGB(255, 185, 137, 3))),
        child: loading
            ? CircularProgressIndicator(
                color: isPrimary
                    ? Colors.white
                    : const Color.fromARGB(255, 185, 137, 3),
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  color: isPrimary
                      ? const Color(0xffffffff)
                      : const Color.fromARGB(255, 185, 137, 3),
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
