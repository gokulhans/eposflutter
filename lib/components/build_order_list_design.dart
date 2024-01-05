import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class BuildOrderListDesign extends StatelessWidget {
  const BuildOrderListDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              maintainState: true,
              childrenPadding: const EdgeInsets.only(
                bottom: 10,
              ),
              collapsedBackgroundColor:
                  index % 2 == 0 ? Colors.grey.withOpacity(0.1) : null,
              backgroundColor:
                  index % 2 == 0 ? Colors.grey.withOpacity(0.1) : null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              tilePadding: const EdgeInsets.only(right: 10, left: 5),
              controlAffinity: ListTileControlAffinity.leading,
              iconColor: ColorManager.textColor,
              collapsedIconColor: ColorManager.textColor,
              title: ListTile(
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
                title: Container(
                    height: 7,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 3),
                    color: ColorManager.colorPlaceholder),
              ),
              children: const <Widget>[],
            ),
          );
        });
  }
}
