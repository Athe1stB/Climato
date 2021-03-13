import 'package:flutter/material.dart';
import 'utlities/constants.dart';

class newCustomWidget extends StatelessWidget {
  final IconData iconData;
  final String stringValue;
  final String parameter;

  newCustomWidget({this.iconData, this.stringValue, this.parameter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 26, top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(flex: 1, child: Icon(iconData)),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parameter,
                  style: elementgray,
                ),
                Text(
                  stringValue,
                  style: elementwhite,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
