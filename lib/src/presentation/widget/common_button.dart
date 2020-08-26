
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final Color buttonColor;
  final double elevation;
  final double width;
  final double height;
  final double fontSize;
  final Color titleColor;
  final FontWeight fontWeight;
  final bool hasForwardIcon;
  final bool replaceWithIndicator;
  final bool isEnabled;
  final TextAlign textAlign;
  final EdgeInsets margin;

  const CommonButton(
      {Key key,
      @required this.title,
      this.onTap,
      this.textStyle,
      this.buttonColor,
      this.titleColor,
      this.elevation,
      this.width,
      this.height,
      this.fontWeight,
      this.fontSize,
      this.textAlign,
      this.hasForwardIcon = false,
      this.replaceWithIndicator = false,
      this.margin,
      this.isEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonTheme(
        minWidth: width ?? MediaQuery.of(context).size.width * 0.6,
       
        height: height ?? 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
        child: MaterialButton(
         color:  buttonColor ?? Colors.white,
          onPressed: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: Text(title,
              style: TextStyle(
                color: titleColor ?? Colors.white,
              )),
        ),
      ),
    );
  }
}
