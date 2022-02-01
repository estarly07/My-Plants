import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/User/bloc/user_bloc.dart';
import 'package:my_plants/Utils/services/services.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer? _timer;
  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    startTimer();
    return Scaffold(
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state.user != null) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, "home");
        });
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: size.height * 0.35),
              child: Center(
                child: FadeInUp(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: size.height * 0.2,
                          margin: EdgeInsets.only(bottom: size.height * 0.01),
                          child: Center(
                              child: Image(
                                  image:
                                      AssetImage("assets/images/logo.png")))),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.01),
                        child: Text(
                          "My Plants",
                          style: TextStyle(
                              fontFamily: "Mouse",
                              letterSpacing: 3,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600],
                              fontSize: size.height * 0.04),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FadeInUp(
              delay: Duration(milliseconds: 500),
              child: Container(
                margin: EdgeInsets.only(
                    bottom: size.height * 0.04, top: size.height * 0.04),
                child: Text(
                  "Estarly",
                  style: TextStyle(
                      fontFamily: "Hanoman",
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.025),
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }

  void startTimer() {
    const oneDecimal = Duration(seconds: 3);
    _timer = Timer.periodic(oneDecimal, (Timer timer) => nextScreen());
  }

  nextScreen() async {
    _timer!.cancel();
    final id = Preferences().id;
    print(id);
    if (id != 0) {
      BlocProvider.of<UserBloc>(context, listen: false).add(SearchEvent());
    } else {
      Navigator.pushReplacementNamed(context, "login");
    }
  }
}
