import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Tip/bloc/tips_bloc.dart';
import 'package:my_plants/Tip/ui/widgets/slider.dart';

class TipScreen extends StatelessWidget {
  const TipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<TipsBloc, TipsState>(
      builder: (context, state) => SliderItem(
        tips: state.tips,
      ),
    ));
  }
}
