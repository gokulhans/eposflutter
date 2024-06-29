import 'package:flutter/material.dart';
import 'package:pos_machine/components/build_title.dart';
import 'package:pos_machine/models/category_list.dart';
import 'package:pos_machine/providers/category_providers.dart';
import 'package:provider/provider.dart';
import 'package:pos_machine/providers/auth_model.dart';
import '../../../../components/build_container_box.dart';
import '../../../../components/build_round_button.dart';
import '../../../../components/build_text_fields.dart';
import '../../../../providers/grid_provider.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/style_manager.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddProductPropertiesScreen extends StatefulWidget {
  final Function(int) navigateToScreen;
  const AddProductPropertiesScreen({super.key, required this.navigateToScreen});

  @override
  _AddProductPropertiesScreenState createState() =>
      _AddProductPropertiesScreenState();
}

class _AddProductPropertiesScreenState
    extends State<AddProductPropertiesScreen> {
  Map<String, dynamic> apiBodyData = {};
  Map<String, List<String>> productPropData = {};
  Map<String, String> productPropStockApplicable = {};
  Map<String, int> productPropIds = {};
  Map<String, bool> stockApplicableMap = {};
  String? selectedProperty;

  @override
  void initState() {
    super.initState();
    // Fetch product properties when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? accessToken =
          Provider.of<AuthModel>(context, listen: false).token;

      int? categoryId = Provider.of<CategoryProvider>(context, listen: false)
          .getPropCategoryId;
      debugPrint("category id $categoryId");
      if (categoryId != null) {
        debugPrint("category id $categoryId");
        Provider.of<CategoryProvider>(context, listen: false).fetchPropValues(
            categoryId: categoryId, accessToken: accessToken ?? "");
      } else {
        debugPrint("Category ID is null");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    GridSelectionProvider gridSelectionProvider =
        Provider.of<GridSelectionProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.8,
            width: double.infinity,
            child: BuildBoxShadowContainer(
              circleRadius: 7,
              blurRadius: 6,
              padding: const EdgeInsets.only(
                  left: 10.0, right: 20, top: 30, bottom: 10),
              offsetValue: const Offset(1, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display product properties
                  Consumer<CategoryProvider>(
                    builder: (context, categoryProvider, child) {
                      if (categoryProvider.propValues == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (categoryProvider.propValues!.isEmpty) {
                        return const Center(child: Text("No properties found"));
                      } else {
                        return Flexible(
                          child: ListView.builder(
                            itemCount: categoryProvider.propValues!.length,
                            itemBuilder: (context, index) {
                              final property =
                                  categoryProvider.propValues![index];
                              final masterValue = property['master_value'];
                              final propsCode = property['props_code'];
                              debugPrint(propsCode);
                              if (masterValue == "NULL") {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BuildTextTile(
                                      title: propsCode,
                                      isStarRed: true,
                                      isTextField: true,
                                      textStyle: buildCustomStyle(
                                        FontWeightManager.regular,
                                        FontSize.s14,
                                        0.27,
                                        Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    BuildBoxShadowContainer(
                                      circleRadius: 7,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 2),
                                      padding: const EdgeInsets.only(left: 15),
                                      height: size.height * .07,
                                      width: size.width / 3,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          setState(() {
                                            apiBodyData['$propsCode'] = value;
                                            productPropData[propsCode] = [
                                              value
                                            ];
                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        cursorColor: ColorManager.kPrimaryColor,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Enter $propsCode',
                                          hintStyle: buildCustomStyle(
                                            FontWeightManager.medium,
                                            FontSize.s12,
                                            0.27,
                                            ColorManager.textColor
                                                .withOpacity(.5),
                                          ),
                                        ),
                                        style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s12,
                                          0.27,
                                          ColorManager.textColor
                                              .withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .15,
                                      child: CheckboxListTile(
                                        title: Text("Stock Applicable"),
                                        value: stockApplicableMap[propsCode] ??
                                            false,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            stockApplicableMap[propsCode] =
                                                value!;
                                            productPropStockApplicable[
                                                propsCode] = value ? "Y" : "N";
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                final items =
                                    List<String>.from(masterValue.split(','));
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    BuildTextTile(
                                      title: propsCode,
                                      isStarRed: true,
                                      isTextField: true,
                                      textStyle: buildCustomStyle(
                                        FontWeightManager.regular,
                                        FontSize.s14,
                                        0.27,
                                        Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    BuildBoxShadowContainer(
                                      circleRadius: 7,
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      padding: const EdgeInsets.only(left: 15),
                                      width: size.width / 3,
                                      child: MultiSelectDialogField(
                                        items: items
                                            .map((item) =>
                                                MultiSelectItem<String>(
                                                    item, item))
                                            .toList(),
                                        title: Text("Choose $propsCode"),
                                        selectedColor:
                                            ColorManager.kPrimaryColor,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                            color: Colors
                                                .transparent, // Transparent border
                                          ),
                                        ),
                                        buttonIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey,
                                        ),
                                        buttonText: Text(
                                          "Choose $propsCode",
                                          // "",
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 16,
                                          ),
                                        ),
                                        onConfirm: (results) {
                                          setState(() {
                                            selectedProperty =
                                                results.join(', ');
                                            apiBodyData['$propsCode'] = results;
                                            productPropData[propsCode] =
                                                List<String>.from(results);
                                          });
                                        },
                                        chipDisplay: MultiSelectChipDisplay(
                                          onTap: (value) {
                                            setState(() {
                                              apiBodyData['$propsCode']
                                                  .remove(value);
                                              productPropData[propsCode]
                                                  ?.remove(value);
                                              if (apiBodyData['$propsCode']
                                                  .isEmpty) {
                                                apiBodyData
                                                    .remove('$propsCode');
                                                productPropData
                                                    .remove(propsCode);
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * .15,
                                      child: CheckboxListTile(
                                        title: Text("Stock Applicable"),
                                        value: stockApplicableMap[propsCode] ??
                                            false,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            stockApplicableMap[propsCode] =
                                                value!;
                                            productPropStockApplicable[
                                                propsCode] = value ? "Y" : "N";
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomRoundButton(
                          title: "Prev",
                          boxColor: Colors.white,
                          textColor: ColorManager.kPrimaryColor,
                          fct: () async {
                            widget.navigateToScreen(2);
                          },
                          height: 50,
                          width: size.width * 0.19,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomRoundButton(
                          title: "Next",
                          boxColor: Colors.white,
                          textColor: ColorManager.kPrimaryColor,
                          fct: () async {
                            Map<String, dynamic> originalObject = apiBodyData;
                            // Map<String, dynamic> originalObject = {
                            //   'PRODUCT_COLOR': 'cream',
                            //   'SHIRT_SIZE_UK': 36,
                            //   'SHOE_SIZE_UK': 7,
                            //   'MANUFACTURER': 'hgfjfjhf',
                            // };

                            debugPrint("apiBodyData.toString()");
                            debugPrint(apiBodyData.toString());
                            int? productId = gridSelectionProvider.getProductId;
                            if (productId == null) {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    showCloseIcon: true,
                                    dismissDirection: DismissDirection.up,
                                    closeIconColor: Colors.white,
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 0,
                                    margin: EdgeInsets.only(
                                        top: 50,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                1.9,
                                        right: 10),
                                    backgroundColor: ColorManager.kPrimaryColor
                                        .withOpacity(0.6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    content: Text(
                                      'Failed',
                                      style: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s12,
                                          0.12,
                                          Colors.white),
                                    )));
                            } else {
                              String? accessToken =
                                  Provider.of<AuthModel>(context, listen: false)
                                      .token;
                              debugPrint(
                                  "accessToken From AuthModel $accessToken");
                              gridSelectionProvider
                                  .addProductPropsAPI(
                                productId: "$productId",
                                accessToken: accessToken ?? "",
                                productPropIds: productPropIds.values
                                    .map((id) => id.toString())
                                    .toList(),
                                productPropCodes: productPropData.keys.toList(),
                                productPropData: productPropData,
                                productPropStockApplicable:
                                    productPropStockApplicable,
                                // productId: "$productId",
                                // accessToken: accessToken ?? "",
                                // productPropIds: ["1", "2"],
                                // productPropCodes: [
                                //   "MANUFACTURER",
                                //   "PRODUCT_COLOR"
                                // ],
                                // productPropData: {
                                //   'MANUFACTURER': ['USHA'],
                                //   "PRODUCT_COLOR": ["blue", "black"]
                                // },
                                // productPropStockApplicable: {
                                //   "MANUFACTURER": "Y",
                                //   "PRODUCT_COLOR": "N"
                                // },
                              )
                                  .then(
                                (value) {
                                  if (value["status"] == "success") {
                                    widget.navigateToScreen(3);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          showCloseIcon: true,
                                          dismissDirection: DismissDirection.up,
                                          closeIconColor: Colors.white,
                                          duration: const Duration(seconds: 2),
                                          behavior: SnackBarBehavior.floating,
                                          elevation: 0,
                                          margin: EdgeInsets.only(
                                              top: 50,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.9,
                                              right: 10),
                                          backgroundColor: ColorManager
                                              .kPrimaryColor
                                              .withOpacity(0.6),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          content: Text(
                                            'Failed to add properties',
                                            style: buildCustomStyle(
                                                FontWeightManager.medium,
                                                FontSize.s12,
                                                0.12,
                                                Colors.white),
                                          ),
                                        ),
                                      );
                                  }
                                },
                              );
                            }
                          },
                          height: 50,
                          width: size.width * 0.19,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
