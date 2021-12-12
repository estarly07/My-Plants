import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:my_plants/view/widgets/title_page.dart';
import 'package:my_plants/view/widgets/widgets.dart';

class DetailPlant extends StatelessWidget {
  const DetailPlant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [TitlePage(), DetailsPlant(), InfoPlant()],
          ),
        ),
      ),
    );
  }
}

class InfoPlant extends StatelessWidget {
  const InfoPlant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "data",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "Cupidatat nulla ad dolore duis tempor incididunt veniam culpa est occaecat. In sunt eiusmod esse ut quis sit veniam occaecat est dolor ex. Cillum minim culpa eu irure nostrud velit adipisicing. Ut amet incididunt occaecat officia. Pariatur nulla et consectetur amet magna qui excepteur.",
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}

class DetailsPlant extends StatelessWidget {
  const DetailsPlant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.55,
      child: Row(
        children: [
          Container(
            width: size.width * 0.3,
          ),
          BackgroundDetailPlant()
        ],
      ),
    );
  }
}
