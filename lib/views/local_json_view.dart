import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_api/models/car_model.dart';

class LocalJsonView extends StatefulWidget {
  const LocalJsonView({Key? key}) : super(key: key);

  @override
  State<LocalJsonView> createState() => _LocalJsonViewState();
}

class _LocalJsonViewState extends State<LocalJsonView> {
  // late List<dynamic>? _cars;

  Future<List<Car>> getCarsJson() async {
    await Future.delayed(Duration(seconds: 3));
    String cars = await DefaultAssetBundle.of(context)
        .loadString('assets/data/cars.json');

    var jsonObject = jsonDecode(cars);

    // _cars.add(jsonDecode(cars));
    // _cars = jsonDecode(cars);

    List<Car> carList =
        (jsonObject as List).map((e) => Car.fromJson(e)).toList();

    return carList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Json'),
      ),
      body: FutureBuilder<List<Car>>(
        builder: (builder, snapshot) {
          if (snapshot.hasData) {
            List<Car> cars = snapshot.data!;
            return ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  Car car = cars[index];
                  return ListTile(
                    title: Text(car.brand),
                    subtitle: Text('Cars : ${car.sort.length}'),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        future: getCarsJson(),
      ),
    );
  }
}
