import 'package:flutter/material.dart';

// import 'package:wheather_app/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String buttonText;
  final void Function()? onButtonTap;
  final Color? borderColor;
  final double height;
  final double borderRadius;
  final double fontSize;
  final IconData? prefixIcon;
  final double width;
  final double iconSize;

  const CustomButton({
    super.key,
    required this.buttonColor,
    required this.buttonText,
    this.onButtonTap,
    required this.textColor,
    this.borderColor,
    this.height = 50,
    this.borderRadius = 10,
    this.fontSize = 17,
    this.prefixIcon,
    this.width = double.infinity,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onButtonTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor ?? buttonColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, size: iconSize, color: textColor),
              SizedBox(width: 6),
            ],
            Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                fontFamily: 'DM Sans',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomButton extends StatelessWidget {
//   final Color buttonColor;
//   final Color textColor;
//   final String buttonText;
//   final void Function()? onButtonTap;
//   final Color? borderColor;
//   final double height;
//   final double borderRadius;
//   final double fontSize;

//   const CustomButton({
//     super.key,
//     required this.buttonColor,
//     required this.buttonText,
//     this.onButtonTap,
//     required this.textColor,
//     this.borderColor,
//     this.height = 50,
//     this.borderRadius = 10,
//     this.fontSize = 17,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onButtonTap,
//       child: Container(
//         height: height,
//         width: double.infinity,
//         // padding: EdgeInsets.symmetric(horizontal: 30),
//         decoration: BoxDecoration(
//           color: buttonColor,
//           borderRadius: BorderRadius.circular(borderRadius),
//           border: Border.all(color: borderColor ?? AppColors.pureWhite),
//         ),
//         child: Center(
//           child: Text(
//             buttonText,
//             style: TextStyle(
//               color: textColor,
//               fontWeight: FontWeight.bold,
//               fontSize: fontSize,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
