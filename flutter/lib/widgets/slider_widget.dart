import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final SliderWidgetModel card;

  SliderWidget({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(card.assetName);
  }
}

class SliderWidgetModel {
  final String assetName;
  SliderWidgetModel(this.assetName);
}

List<SliderWidgetModel> getSliderWidgets() {
  List<SliderWidgetModel> creditCards = [
    SliderWidgetModel("assets/header1.png"),
    SliderWidgetModel("assets/header2.png"),
    SliderWidgetModel("assets/header3.png"),
  ];
  return creditCards;
}
