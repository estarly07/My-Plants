import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EdittextCustom extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextInputType type;
  final Function callback;
  final bool onlyNumbers;
  const EdittextCustom({
    Key? key,
    required this.icon,
    required this.type,
    required this.hint,
    required this.callback,
    this.onlyNumbers = false,
  }) : super(key: key);
/* obscureText: true, */
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: TextFormField(
        autocorrect: false,
        maxLines: 1,
        onChanged: (v) => callback(v),
        style: TextStyle(color: Colors.white),
        keyboardType: type,
        validator: (value) =>
            (value != null && value != "") ? null : "Datos incorrectos",
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey[350]),
            hintText: hint,
            suffixIcon: Icon(
              icon,
              color: Color(0xff008F39),
            ),
            border: InputBorder.none),
        inputFormatters: <TextInputFormatter>[
          ((onlyNumbers)
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter)
        ],
/*         validator: (value) {
          if (value == null || value.isEmpty) {
            return "Debes llenar el campo de texto";
          }
          return null;
        }, */
      ),
    );
  }
}
