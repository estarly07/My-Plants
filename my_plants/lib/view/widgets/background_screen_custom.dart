import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgrounScreenCustom extends StatelessWidget {
  const BackgrounScreenCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.15,
      child: SvgPicture.asset(
        "assets/images/svg/fondo.svg",
        fit: BoxFit.cover,
      ),
    );
  }
}
