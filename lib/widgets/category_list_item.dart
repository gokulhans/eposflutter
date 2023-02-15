import 'package:flutter/material.dart';
import 'package:pos_machine/resources/asset_manager.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/style_manager.dart';
import '../responsive.dart';

class CategoryListItem extends StatefulWidget {
  const CategoryListItem({super.key});

  @override
  State<CategoryListItem> createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  final TextEditingController _searchTextController = TextEditingController();
  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint(size.width.toString());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Search Category',
                  style: ResponsiveWidget.isMobile(context)
                      ? buildCustomStyle(FontWeightManager.semiBold,
                          FontSize.s12, 0.30, ColorManager.textColor)
                      : buildCustomStyle(FontWeightManager.semiBold,
                          FontSize.s20, 0.30, ColorManager.textColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _searchTextController,
                    cursorColor: ColorManager.kPrimaryColor,
                    decoration: decoration.copyWith(
                      prefixIcon: WebsafeSvg.asset(
                        ImageAssets.categorySearchIcon,
                        fit: BoxFit.none,
                      ),
                      suffixIcon: WebsafeSvg.asset(
                        ImageAssets.barcodeIcon,
                        fit: BoxFit.none,
                      ),
                      hintText: 'Search category or product',
                      hintStyle: buildCustomStyle(FontWeightManager.regular,
                          FontSize.s10, 0.13, ColorManager.textColor1),
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 130,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: ColorManager.textColor1,
                        radius: 50,
                        child: Container(
                          height: 95,
                          width: 95,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: WebsafeSvg.asset(
                            ImageAssets.allCategoryIcon,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'All',
                        style: buildCustomStyle(FontWeightManager.regular,
                            FontSize.s11, 0.17, Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: ColorManager.kPrimaryColor,
                        radius: 50,
                        child: CircleAvatar(
                          radius: 47,
                          foregroundColor: Colors.white,
                          foregroundImage: AssetImage(
                            ImageAssets.foodImage,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Food',
                        style: buildCustomStyle(FontWeightManager.semiBold,
                            FontSize.s11, 0.17, Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: ColorManager.textColor1,
                        radius: 50,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.white,
                          foregroundImage: AssetImage(
                            ImageAssets.drinkImage,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Drink',
                        style: buildCustomStyle(FontWeightManager.regular,
                            FontSize.s11, 0.17, Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: ColorManager.textColor1,
                        radius: 50,
                        child: CircleAvatar(
                          radius: 47,
                          foregroundColor: Colors.white,
                          foregroundImage: AssetImage(
                            ImageAssets.snackImage,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Snack',
                        style: buildCustomStyle(FontWeightManager.regular,
                            FontSize.s11, 0.17, Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: ColorManager.textColor1,
                        radius: 50,
                        child: CircleAvatar(
                          radius: 47,
                          foregroundColor: Colors.white,
                          foregroundImage: AssetImage(
                            ImageAssets.icecreamImage,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Ice Cream',
                        style: buildCustomStyle(FontWeightManager.regular,
                            FontSize.s11, 0.17, Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: ColorManager.textColor1,
                        radius: 50,
                        child: CircleAvatar(
                          radius: 47,
                          foregroundColor: Colors.white,
                          foregroundImage: AssetImage(
                            ImageAssets.sweetsImage,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Sweets',
                        style: buildCustomStyle(FontWeightManager.regular,
                            FontSize.s11, 0.17, Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Divider(
              color: ColorManager.boxShadowColor,
            ),
            const SizedBox(
              width: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Food \t',
                style: buildCustomStyle(FontWeightManager.semiBold,
                    FontSize.s15, 0.23, Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: '(44) items',
                    style: buildCustomStyle(FontWeightManager.regular,
                        FontSize.s10, 0.12, Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveWidget.isDesktop(context)
                        ? MediaQuery.of(context).orientation ==
                                    Orientation.portrait ||
                                size.width < 930
                            ? 3
                            : size.width < 1200
                                ? 4
                                : 5
                        : MediaQuery.of(context).orientation ==
                                    Orientation.portrait ||
                                size.width < 930
                            ? 3
                            : 4,
                    childAspectRatio: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 0.5
                        : size.width < 1200
                            ? 0.6
                            : 0.7,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
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
                          child: Image.asset(ImageAssets.mightyZinkerBoxImage),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'MIGHTY ZINGER\n ',
                            style: buildCustomStyle(FontWeightManager.medium,
                                FontSize.s11, 0.13, Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: '150 g\n',
                                style: buildCustomStyle(
                                    FontWeightManager.medium,
                                    FontSize.s10,
                                    0.12,
                                    Colors.black.withOpacity(0.5)),
                              ),
                              TextSpan(
                                text: '\$3.50',
                                style: buildCustomStyle(
                                    FontWeightManager.semiBold,
                                    FontSize.s12,
                                    0.12,
                                    Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
