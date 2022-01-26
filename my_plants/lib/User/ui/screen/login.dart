import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/User/bloc/user_bloc.dart';
import 'package:my_plants/User/ui/widget/widgets.dart';
import 'package:my_plants/Utils/view/widgets/background_screen_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool login = true;
  void nextView() {
    print("object");
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BlocProvider.of<UserBloc>(context, listen: false).emit(UserInitial());
    return WillPopScope(
      onWillPop: () async {
        if (!login) {
          nextView();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                child: BackgrounScreenCustom()),
            Align(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Image.asset(
                        "assets/images/logo.png",
                        width: size.width * 0.8,
                        height: size.width * 0.8,
                      )),
                      Container(
                          height: size.height * 0.7,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: CustomPaint(
                                  painter: DecorationPainter(),
                                ),
                              ),
                              (login)
                                  ? Login(
                                      callback: nextView,
                                    )
                                  : Register(
                                      callback: nextView,
                                    )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showToast(BuildContext context, String text) {
  /*  SchedulerBinding.instance!.addPostFrameCallback((_) { */
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  /* }); */
}

class Register extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  bool noFirstTime = false;
  final Function callback;
  static String pass = "";
  static String user = "";
  static String age = "";
  Register({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (noFirstTime) {
        noFirstTime = false;
        print("hola");
        if (state.user != null) {
          print("hola");
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, "slider");
          });
        } else {
          print("object");
          /* _showToast(context, "Datos incorrectos"); */
        }
      }

      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElasticInDown(
              delay: Duration(milliseconds: 200),
              child: Text("Hola",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.1,
                    color: Colors.white,
                  )),
            ),
            ElasticInLeft(
              delay: Duration(milliseconds: 700),
              child: TextCustom(
                size: size,
                text: "Ingresa los datos",
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1, vertical: size.height * 0.07),
              child: Column(
                children: [
                  FadeIn(
                    child: EdittextCustom(
                      icon: Icons.person,
                      callback: (String user) {
                        Register.user = user;
                      },
                      hint: "Ingresa tu Usuario",
                      type: TextInputType.text,
                    ),
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 1000),
                  ),
                  FadeIn(
                    child: EdittextCustom(
                      callback: (String pass) {
                        Register.pass = pass;
                      },
                      icon: Icons.password,
                      hint: "Contraseña",
                      type: TextInputType.visiblePassword,
                    ),
                    duration: Duration(milliseconds: 700),
                    delay: Duration(milliseconds: 1000),
                  ),
                  FadeIn(
                    child: EdittextCustom(
                      icon: Icons.calendar_today,
                      hint: "Edad",
                      callback: (String age) {
                        Register.age = age;
                      },
                      type: TextInputType.phone,
                      onlyNumbers: true,
                    ),
                    duration: Duration(milliseconds: 1000),
                    delay: Duration(milliseconds: 1000),
                  ),
                  FadeIn(
                    child: GestureDetector(
                      onTap: () {
                        print("object1");

                        if (validate()) {
                          noFirstTime = true;
                          BlocProvider.of<UserBloc>(context, listen: false)
                              .add(RegisterEvent(age, user, pass));
                        } else {
                          print("Error");
                          /*  _showToast(context, "Llena todos los campos"); */
                        }
                      },
                      child: ButtomCustom(
                          width: size.width * 0.5,
                          height: size.height * 0.07,
                          text: "Ingresar"),
                    ),
                    duration: Duration(milliseconds: 700),
                    delay: Duration(milliseconds: 1000),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  bool validate() => age.trim() != "" && user.trim() != "" && pass.trim() != "";
}

class Login extends StatelessWidget {
  static String pass = "";
  static String user = "";
  bool noFirstTime = false;

  final Function callback;
  Login({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (noFirstTime) {
        noFirstTime = false;
        print("hola Login ${state.user}");
        if (state.user != null) {
          print("hola");
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, "slider");
          });
          return Container();
        } else {
          print("object");
          /* _showToast(context, "Datos incorrectos"); */
        }
      }

      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElasticInDown(
              delay: Duration(milliseconds: 200),
              child: Text("Bienvenido",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.1,
                    color: Colors.white,
                  )),
            ),
            ElasticInLeft(
              delay: Duration(milliseconds: 700),
              child: TextCustom(
                size: size,
                text: "Inicia sesión con tu cuenta.",
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1, vertical: size.height * 0.05),
              child: Column(
                children: [
                  FadeIn(
                    child: EdittextCustom(
                      callback: (String user) {
                        print(user);
                        Login.user = user;
                      },
                      icon: Icons.person,
                      hint: "Ingresa tu Usuario",
                      type: TextInputType.text,
                    ),
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 1000),
                  ),
                  FadeIn(
                    child: EdittextCustom(
                      callback: (String pass) {
                        Login.pass = pass;
                      },
                      icon: Icons.password,
                      hint: "Contraseña",
                      type: TextInputType.visiblePassword,
                    ),
                    duration: Duration(milliseconds: 700),
                    delay: Duration(milliseconds: 1000),
                  ),
                  FadeIn(
                    child: GestureDetector(
                      onTap: () {
                        print("object1");

                        if (validate()) {
                          noFirstTime = true;
                          BlocProvider.of<UserBloc>(context, listen: false)
                              .add(LoginEvent(user, pass));
                        } else {
                          print("Error");
                          /*  _showToast(context, "Llena todos los campos"); */
                        }
                      },
                      child: ButtomCustom(
                          width: size.width * 0.5,
                          height: size.height * 0.07,
                          text: "Ingresar"),
                    ),
                    duration: Duration(milliseconds: 700),
                    delay: Duration(milliseconds: 1000),
                  )
                ],
              ),
            ),
            ElasticInUp(
              delay: Duration(milliseconds: 700),
              child: TextCustom(
                size: size,
                text: "No tienes cuenta.",
              ),
            ),
            ElasticInUp(
              delay: Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: () => callback(),
                child: TextCustom(
                  size: size,
                  tap: true,
                  text: "Registrate!!.",
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  bool validate() => user.trim() != "" && pass.trim() != "";
}
