import 'package:flutter/material.dart';

class FontClass {
  // Define your custom font family
  static const String customFontFamily = 'Roboto';

  // Create a method to get a custom text style
  static TextStyle customTextStyle({
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  })

  {
    return TextStyle(
      fontFamily: customFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

}


// Example usage in a widget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, Custom Font!',
      style: FontClass.customTextStyle(),
    );
  }
}
