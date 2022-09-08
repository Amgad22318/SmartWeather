import 'package:flutter/material.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_text.dart';

class HoursTempItem extends StatelessWidget {
  final String time;
  final String temp;
  final String icon;
  final String state;
  const HoursTempItem({
    Key? key,
    required this.time,
    required this.temp,
    required this.icon,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultText(text: time),
        DefaultText(text: state),
        DefaultText(text: time),
      ],
    );
  }
}
