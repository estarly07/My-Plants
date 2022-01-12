import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_plants/Game/bloc/game_bloc.dart';

class Hearts extends StatelessWidget {
  const Hearts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = BlocProvider.of<GameBloc>(context);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.height * 0.025),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FadeInLeft(
              delay: Duration(milliseconds: 50),
              child: _heart(provider.state.fails >= 1, size.width * 0.12)),
          FadeInLeft(
              delay: Duration(milliseconds: 100),
              child: _heart(provider.state.fails >= 2, size.width * 0.12)),
          FadeInLeft(
              delay: Duration(milliseconds: 150),
              child: _heart(provider.state.fails >= 3, size.width * 0.12)),
        ],
      ),
    );
  }

  Widget _heart(bool lose, double size) => Lottie.asset(
        "assets/animations/unlove.json",
        height: size * 2,
        width: size * 2,
        repeat: false,
        animate: lose,
      );
}
