import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:my_plants/Slider/bloc/slider_bloc.dart';
import 'package:my_plants/Slider/model/slider.dart';
import 'package:my_plants/Slider/ui/widgets/widgets.dart';
import 'package:my_plants/Tip/model/tip.dart';
import 'package:url_launcher/url_launcher.dart';

class SliderItem extends StatelessWidget {
  final List<Tip> tips;
  const SliderItem({Key? key, required this.tips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _Slide(tips
          .map(
            (e) => SliderModel(
              image: e.picture,
              title: e.url,
              description: e.tip,
            ),
          )
          .toList()),
    );
  }
}

_launchURL(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    _showToast(context);
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Added to favorite'),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
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
            Image.asset(
              "assets/images/slider_background.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black54.withOpacity(0.5),
            ),
            Container(
              child: PageView(
                  controller: pageController,
                  children: widget.sliders.map((e) => Slider(e)).toList()),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Dots(widget.sliders.length),
                      ),
                    ),
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
    return ElasticIn(
      child: GestureDetector(
        onTap: () => _launchURL(context, _slider.title),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Align(
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.6,
                    padding: EdgeInsets.all(size.width * 0.1),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              spreadRadius: -5,
                              blurRadius: 15)
                        ],
                        borderRadius: BorderRadius.circular(size.width * 0.05)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Consejo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.03),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              child: SvgPicture.asset(
                            _slider.image,
                            width: size.width * 0.3,
                            height: size.width * 0.3,
                          )),
                        ),
                        Container(
                          child: Text(_slider.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: size.height * 0.02)),
                        ),
                        Lottie.asset("assets/animations/tap.json",
                            width: size.width * 0.1)
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
