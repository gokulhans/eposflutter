import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/style_manager.dart';

class CategoryListItemWidget extends StatefulWidget {
  final String imageUrlPath;
  final double price;
  final String title;
  final String weight;
  final bool isSelected;
  const CategoryListItemWidget(
      {super.key,
      required this.imageUrlPath,
      required this.price,
      required this.title,
      required this.weight,
      required this.isSelected});

  @override
  State<CategoryListItemWidget> createState() => _CategoryListItemWidgetState();
}

class _CategoryListItemWidgetState extends State<CategoryListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.isSelected
              ? Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManager.kPrimaryColor, width: 3),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: const [
                            BoxShadow(
                              color: ColorManager.boxShadowColor,
                              blurRadius: 6,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white),
                      child: Image.asset(widget.imageUrlPath),
                    ),
                    Container(
                      height: 20,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: ColorManager.kPrimaryColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(8)),
                      ),
                      child: const Icon(
                        Icons.done,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
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
                  child: Image.asset(widget.imageUrlPath),
                ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '${widget.title}\n ',
              style: buildCustomStyle(
                  FontWeightManager.medium, FontSize.s11, 0.13, Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: '${widget.weight} g\n',
                  style: buildCustomStyle(FontWeightManager.medium,
                      FontSize.s10, 0.12, Colors.black.withOpacity(0.5)),
                ),
                TextSpan(
                  text: '\$${widget.price}',
                  style: buildCustomStyle(FontWeightManager.semiBold,
                      FontSize.s12, 0.12, Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
