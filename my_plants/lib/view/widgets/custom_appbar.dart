import 'package:flutter/cupertino.dart';

class CustomAppbar extends StatelessWidget {
  final List<IconData> icons;

  const CustomAppbar({
    required this.icons,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icons[0],
            size: 30,
          ),
          icons.length > 1
              ? Icon(
                  icons[1],
                  size: 30,
                )
              : Container(),
        ],
      ),
    );
  }
}
