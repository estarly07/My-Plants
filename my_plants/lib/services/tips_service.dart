import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:my_plants/Utils/service.dart';
import 'package:my_plants/bloc/tips/tips_bloc.dart';
import 'package:my_plants/models/tip.dart';

class TipsService {
  static List<Tip> allTips = [];

  Future getTips(BuildContext context) async {
    final response = await get(Uri.parse("$BASE_URL$TIPS"));
    final providerTip = BlocProvider.of<TipsBloc>(context, listen: false);

    if (response.body != null && allTips.isEmpty) {
      Map<String, dynamic> map = json.decode(response.body);
      final List<Tip> tips = [];

      map.forEach((key, value) {
        tips.add(Tip.fromMap(value, key));
      });

      allTips = tips;
    }
    providerTip.add(ResponseTipsEvent(tips: allTips));
    providerTip.add(GenerateTipRandomEvent(tipRandom: tipRandom()));
  }

  Tip tipRandom() {
    final r = Random().nextInt(allTips.length);
    print("object $r");
    return allTips[r];
  }
}
