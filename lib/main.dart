import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MaterialApp(
    home: Bmicalcy(),
  ));
}

class Bmicalcy extends StatelessWidget {
  final Bmicontroller controller = Get.put(Bmicontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("calcy")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Weight (kg)",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: controller.weight,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    hintText: "55",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Height (cm)",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: controller.height,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    hintText: "170",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Age",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    hintText: "20",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      controller.calculate();
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 200,
                            child: Center(
                              child: Column(children: [
                                GetBuilder<Bmicontroller>(
                                  // init: Bmicontroller(),
                                  builder: (controller) {
                                    return Column(
                                      children: [
                                        Text("Your BMI is..."),
                                        Text(
                                          "${controller.bmi}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                        Text(
                                          "${controller.bmiresult}",
                                          style: TextStyle(fontSize: 35,
                                              color: controller.color,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ]),
                            ),
                          );
                        },
                      );
                    },
                    child: Center(child: Text("Calculate"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Bmicontroller extends GetxController {
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  String bmiresult = "";
  var color;
  var bmi;

  void calculate() {
    if (height != null && weight != null) {
      bmi = (double.parse(weight.text) /
              (pow(double.parse(height.text), 2)) *
              10000)
          .roundToDouble();
      print("=============${bmi}");
      if (bmi < 18.5) {
        bmiresult = "Under Weight";
        color = Color(0x64A1CDFF);
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        bmiresult = "Normal";
        color = Color(0xFF67CD64);
      } else if (bmi >= 25 && bmi <= 29.9) {
        bmiresult = "Over weight";
        color = Color(0xFFD2A730);
      } else if (bmi >= 30 && bmi <= 34.9) {
        bmiresult = "Obesity (Class I)";
        color = Color(0xFFCC6F23);
      } else if (bmi >= 35 && bmi <= 39.9) {
        bmiresult = "Obesity (Class II)";
        color = Color(0xFFEF0909);
      } else if (bmi >= 40) {
        bmiresult = "Extreme Obesity";
        color = Color(0xFF5D0505);
      }
    }
    update();
  }
}
