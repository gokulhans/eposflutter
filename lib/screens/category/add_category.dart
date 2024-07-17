import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_machine/providers/category_providers.dart';
import 'package:pos_machine/resources/asset_manager.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../components/build_container_box.dart';
import '../../components/build_round_button.dart';
import '../../controllers/sidebar_controller.dart';
import '../../models/category_list.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  int _currentPage = 1;
  int _itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    SideBarController sideBarController = Get.put(SideBarController());
    final categoryProvider = Provider.of<CategoryProvider>(context);
    // final searchTextController = TextEditingController();

    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 0, right: 10),
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
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Category  ",
                  style: buildCustomStyle(FontWeightManager.semiBold,
                      FontSize.s20, 0.30, ColorManager.textColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 180,
                      child: TextField(
                        cursorWidth: 1,
                        cursorColor: ColorManager.kPrimaryColor,
                        onChanged: (query) {
                          debugPrint(query);
                          final filteredCategories = categoryProvider
                              .searchCategoryPageCategories(query);

                          categoryProvider.updateCategoryPageFilteredCategories(
                              filteredCategories);
                          setState(() {
                            _currentPage = 1; // Reset to first page on search
                          });
                        },
                        decoration: decoration.copyWith(
                          prefixIcon: WebsafeSvg.asset(
                            ImageAssets.categorySearchIcon,
                            fit: BoxFit.none,
                          ),
                          labelStyle: buildCustomStyle(
                              FontWeightManager.regular,
                              FontSize.s10,
                              0.10,
                              ColorManager.textColor),
                          hintText: 'Search category',
                          hintStyle: buildCustomStyle(FontWeightManager.regular,
                              FontSize.s10, 0.13, ColorManager.textColor1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomRoundButton(
                      title: "Create New Category",
                      fct: () {
                        sideBarController.index.value = 16;
                      },
                      fontSize: 12,
                      height: 45,
                      width: 200,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BuildBoxShadowContainer(
                  circleRadius: 7,
                  offsetValue: const Offset(1, 1),
                  child: Consumer<CategoryProvider>(
                    builder: (context, categoryProvider, child) {
                      final List<Category> categories =
                          categoryProvider.filteredcategory ?? [];
                      final int totalPages =
                          (categories.length / _itemsPerPage).ceil();
                      final List<Category> paginatedCategories = categories
                          .skip((_currentPage - 1) * _itemsPerPage)
                          .take(_itemsPerPage)
                          .toList();

                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Table(
                                border: TableBorder.symmetric(
                                    outside: const BorderSide(
                                        color: ColorManager.tableBOrderColor,
                                        width: 0.3),
                                    inside: const BorderSide(
                                        color: ColorManager.tableBOrderColor,
                                        width: 0.8)),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(3),
                                  3: FlexColumnWidth(2),
                                },
                                children: [
                                  _buildTableHeader(),
                                  ...paginatedCategories
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int index = entry.key +
                                        ((_currentPage - 1) * _itemsPerPage);
                                    Category category = entry.value;
                                    return _buildTableRow(index, category,
                                        sideBarController, categoryProvider);
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildPaginationControls(totalPages),
                        ],
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    ));
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(color: ColorManager.tableBGColor),
      children: ["No", "Category Name", "Slug", "Action"]
          .map((title) => TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                      title,
                      style: buildCustomStyle(
                        FontWeightManager.medium,
                        FontSize.s12,
                        0.18,
                        ColorManager.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  TableRow _buildTableRow(int index, Category category,
      SideBarController sideBarController, CategoryProvider categoryProvider) {
    return TableRow(
      children: [
        _buildTableCell("${index + 1}"),
        _buildTableCell(category.categoryName ?? ""),
        _buildTableCell(category.categorySlug ?? ""),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  Icons.visibility,
                  ColorManager.kPrimaryColor.withOpacity(0.9),
                  Colors.white,
                  () async {
                    await categoryProvider.viewCategoryApi(
                        categoryId: category.categoryId ?? 1);
                    sideBarController.index.value = 27;
                  },
                ),
                _buildActionButton(
                  Icons.edit,
                  ColorManager.kPrimaryColor.withOpacity(0.9),
                  Colors.white,
                  () async {
                    await categoryProvider.setEditCategoryId(
                        categoryId: category.categoryId ?? 1);
                    await categoryProvider.viewCategoryApi(
                        categoryId: category.categoryId ?? 1);
                    sideBarController.index.value = 34;
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            text,
            style: buildCustomStyle(
              FontWeightManager.medium,
              FontSize.s9,
              0.13,
              Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, Color bgColor, Color iconColor, VoidCallback onPressed) {
    return BuildBoxShadowContainer(
      margin: const EdgeInsets.only(left: 5, right: 5),
      color: bgColor,
      circleRadius: 5,
      child: IconButton(
        icon: Icon(
          icon,
          size: 18,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildPaginationControls(int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed:
              _currentPage > 1 ? () => setState(() => _currentPage--) : null,
        ),
        Text('Page $_currentPage of $totalPages'),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: _currentPage < totalPages
              ? () => setState(() => _currentPage++)
              : null,
        ),
      ],
    );
  }
}
