import 'package:flutter/cupertino.dart';

class BackgrounScreenCustom extends StatelessWidget {
  const BackgrounScreenCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Opacity(
      opacity: 0.15,
      child: Image(
        image: AssetImage("assets/images/fondo.png"),
        fit: BoxFit.cover,
      ),
    );
  }
}
