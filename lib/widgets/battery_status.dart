import 'package:flutter/material.dart';

class BatteryStatus extends StatelessWidget {
  final BoxConstraints constraints;

  const BatteryStatus({Key? key, required this.constraints}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            '220 mi',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            '62 %',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
          Spacer(),
          Text(
            'Charging'.toUpperCase(),
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                ),
          ),
          Text(
            '18 min remaining',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.1,
          ),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.headline6!.copyWith(  
                  color: Colors.white,
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '22 mi/hr',
                ),
                Text(
                  '232 v',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
