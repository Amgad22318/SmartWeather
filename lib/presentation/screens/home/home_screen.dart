import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza_75/presentation/views/home/home_sliver_header.dart';
import 'package:weather_app_algoriza_75/presentation/views/home/hours_temp_item.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
            pinned: true,
            delegate: HomeSliverHeader(
              minExtent: 25.h,
              maxExtent: 45.h,
            )),
        SliverToBoxAdapter(
          child: Container(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            height: 20.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp), color: Colors.red),
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: List.generate(
                        20,
                        (index) => HoursTempItem(
                            time: 'time',
                            temp: 'temp',
                            icon: 'icon',
                            state: 'state')),
                  ),
                  Row(
                    children: List.generate(
                        20,
                        (index) => Row(
                              children: [DefaultText(text: 'sss')],
                            )),
                  ),
                ],
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
