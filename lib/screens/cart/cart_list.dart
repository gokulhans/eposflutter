import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';
import '../../responsive.dart';

import 'widgets/pending_order_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin:
              const EdgeInsets.only(left: 10, top: 20, bottom: 0, right: 10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(
                  color: ColorManager.boxShadowColor,
                  blurRadius: 6,
                  offset: Offset(1, 1),
                ),
              ],
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
            child: ListView(
              children: [
                Text(
                  'Pending Orders',
                  style: ResponsiveWidget.isMobile(context)
                      ? buildCustomStyle(FontWeightManager.semiBold,
                          FontSize.s12, 0.30, ColorManager.textColor)
                      : buildCustomStyle(FontWeightManager.semiBold,
                          FontSize.s20, 0.30, ColorManager.textColor),
                ),
                const Row(
                  children: [PendingOrderWidget(), PendingOrderWidget()],
                ),
              ],
            ),
          )),
    );
  }
}
