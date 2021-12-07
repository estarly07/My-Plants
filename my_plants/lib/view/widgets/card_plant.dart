import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CardPlant extends StatelessWidget {
  const CardPlant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        Column(
          children: [
            Expanded(child: Container()),
            Stack(
              children: [
                Container(
                  height: size.height * 0.22,
                  margin: EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                _ButtonLike()
              ],
            ),
          ],
        ),
        _PlantInfo(
          name: "UWU",
          type: "Cactus",
          image: "",
        ),
      ],
    );
  }
}

class _ButtonLike extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: GestureDetector(
          onTap: () => print("object"),
          child: const Icon(
            Icons.favorite_border,
            color: Colors.grey,
            size: 25,
          )),
    );
  }
}

class _PlantInfo extends StatelessWidget {
  final String name;
  final String type;
  final String image;

  const _PlantInfo({
    required this.name,
    required this.type,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          _PlantImage(
            image: image,
          ),
          _PlantDescription(
            name: name,
            type: type,
          )
        ],
      ),
    );
  }
}

class _PlantDescription extends StatelessWidget {
  final String name;
  final String type;

  const _PlantDescription({
    required this.name,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Container(
                constraints: const BoxConstraints(maxHeight: 13),
                child: Text(
                  type,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              )
            ],
          ),
          Container(width: 25, height: 25, color: Colors.blue)
        ],
      ),
    );
  }
}

class _PlantImage extends StatelessWidget {
  final String image;
  const _PlantImage({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: const Image(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/c2.png"),
            )));
  }
}
