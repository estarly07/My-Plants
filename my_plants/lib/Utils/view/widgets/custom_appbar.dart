import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_plants/Utils/values/global.dart';

class CustomAppbar extends StatelessWidget {
  final List<String> icons;

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
          ...icons
              .map((e) => GestureDetector(
                    onTap: () {
                      switch (e) {
                        case "assets/images/svg/ic_menu.svg":
                          Scaffold.of(context).openDrawer();

                          break;
                        case "assets/images/svg/ic_search.svg":
                          Navigator.pushNamed(context, "search");

                          break;
                        default:
                          Navigator.pop(context);
                          break;
                      }
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          e,
                          color: Colors.black,
                        )),
                  ))
              .toList()
        ],
      ),
    );
  }
}
