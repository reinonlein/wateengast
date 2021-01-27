import 'dart:math';

import 'package:meta/meta.dart';

class CarPost {
  @required
  final int id;
  @required
  final String model;
  @required
  final int power;
  @required
  final int topSpeed;
  @required
  final bool isElectro;

  CarPost({this.id, this.model, this.power, this.topSpeed, this.isElectro});

  CarPost.random()
      : this.id = null,
        this.model = 'BMW ${1 + Random().nextInt(6)}',
        this.power = 100 + 50 * Random().nextInt(5),
        this.topSpeed = 200 + 20 * Random().nextInt(3),
        this.isElectro = Random().nextBool();

  CarPost.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        model = map['model'],
        power = map['power'],
        topSpeed = map['top_speed'],
        isElectro = map['is_electro'] == 1;

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['model'] = model;
    map['power'] = power;
    map['top_speed'] = topSpeed;
    map['is_electro'] = isElectro ? 1 : 0;
    return map;
  }
}
