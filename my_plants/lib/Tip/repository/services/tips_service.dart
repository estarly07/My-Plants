import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_plants/Tip/model/tip.dart';
import 'package:my_plants/Utils/values/service.dart';

class TipsService {
  static List<Tip> allTips = [];

  Future<List<Tip>> getTips() async {
    final response = await get(Uri.parse("$BASE_URL$TIPS"));

    if (allTips.isEmpty) {
      Map<String, dynamic> map = json.decode(response.body);
      final List<Tip> tips = [];

      map.forEach((key, value) {
        tips.add(Tip.fromMap(value, key));
      });

      allTips = tips;
    }
    return allTips;
  }
}
