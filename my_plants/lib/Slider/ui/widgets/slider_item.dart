import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Slider/bloc/slider_bloc.dart';
import 'package:my_plants/Slider/model/slider.dart';
import 'package:my_plants/Slider/ui/widgets/widgets.dart';
import 'package:my_plants/Utils/services/services.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _Slide([
      SliderModel(
        image: "assets/images/uno.jpg",
        title: "Nunca más se te moriran tus plantas",
        description:
            "Te recordaremos cuando tienes que volver a regar tu plant",
      ),
      SliderModel(
        image: "assets/images/dos.jpg",
        title: "Tendrás consejos para el cuidado\n 👊",
        description:
            "My plants te aconsejara para que cuides mejor tus plantas",
      ),
      SliderModel(
        image: "assets/images/tres.jpg",
        title: "Investigación\n 🕵️",
        description:
            "Sabrás que tipo de plantas puedes tener en casa y sus cuidados",
      ),
      SliderModel(
        image: "assets/images/logo.png",
        title: "Disfruta\n 😎 ",
        description:
            "Relajate que My Plants siempre te ayudará a cuidar tus plantas",
      ),
    ]));
  }
}

class _Slide extends StatefulWidget {
  List<SliderModel> sliders;

  _Slide(this.sliders);
  @override
  State<_Slide> createState() => _SlideState();
}

class _SlideState extends State<_Slide> {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    final provider = BlocProvider.of<SliderBloc>(context, listen: false);
    pageController.addListener(() {
      provider.add(ChangeSliderPageEvent(pageController.page!));
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SliderBloc, SliderState>(
      builder: (context, state) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: size.height * 0.35,
                child: CustomPaint(
                  painter: Header(const Color(0xffEEEEEE)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: size.height * 0.25,
                child: CustomPaint(
                  painter: Header(Colors.green.shade100),
                ),
              ),
            ),
            Container(
              child: PageView(
                  controller: pageController,
                  children: widget.sliders.map((e) => Slider(e)).toList()),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Dots(widget.sliders.length),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (state.currentPage !=
                                (widget.sliders.length - 1)) {
                              pageController.nextPage(
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.easeIn);
                            } else {
                              Preferences().firstTime();
                              Navigator.pushReplacementNamed(context, "home");
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: size.width * 0.1),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 12,
                                    spreadRadius: -7,
                                    color: Colors.black54,
                                    offset: Offset(5, 5))
                              ],
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.3)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Siguinte",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: size.width * 0.1,
                                  child: FloatingActionButton(
                                    onPressed: null,
                                    backgroundColor: Colors.green[400],
                                    child:
                                        Icon(Icons.arrow_forward_ios_outlined),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class Slider extends StatelessWidget {
  SliderModel _slider;
  Slider(this._slider);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(size.width * 0.5),
                          bottomRight: Radius.circular(size.width * 0.5),
                        ),
                        child: Container(
                            height: size.height * 0.7,
                            width: size.width * 0.8,
                            child: Image.asset(
                              _slider.image,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Column(
                        children: [
                          Text(
                            _slider.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.04),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                                vertical: size.height * 0.02),
                            child: Text(_slider.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: size.height * 0.02)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
