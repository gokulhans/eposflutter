import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_machine/components/build_container_box.dart';
import 'package:pos_machine/components/build_round_button.dart';
import 'package:pos_machine/providers/customer_provider.dart';
import 'package:provider/provider.dart';

import '../../controllers/sidebar_controller.dart';
import '../../models/customer_list.dart';
import '../../providers/auth_model.dart';
import '../../resources/asset_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  bool isInitLoading = false;
  List<CustomerListModelData>? customerList = [];
  List<CustomerListModelData> filteredCustomers = [];
  final searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCustomersDetails();
  }

  void getCustomersDetails() async {
    try {
      setState(() {
        isInitLoading = true;
      });
      String? accessToken =
          Provider.of<AuthModel>(context, listen: false).token;
      debugPrint("accessToken From AuthModel $accessToken");
      CustomerProvider()
          .listCustomer(accessToken ?? "", context)
          .then((response) {
        if (response["status"] == "success") {
          CustomerListModel customerListModel =
              CustomerListModel.fromJson(response);

          setState(() {
            customerList = customerListModel.data;
            filteredCustomers = customerListModel.data ?? [];
          });
        } else {}
      });
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      setState(() {
        isInitLoading = false;
      });
    }
  }

  void searchCustomers() {
    String query = searchTextController.text.toLowerCase();
    // Filter customers based on the search query
    setState(() {
      filteredCustomers = customerList!
          .where((customer) =>
              customer.name!.toLowerCase().contains(query) ||
              customer.email!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    SideBarController sideBarController = Get.put(SideBarController());

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
            margin:
                const EdgeInsets.only(left: 10, top: 20, bottom: 0, right: 10),
            padding:
                const EdgeInsets.only(left: 10, top: 20, bottom: 0, right: 10),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customers',
                    style: buildCustomStyle(FontWeightManager.semiBold,
                        FontSize.s20, 0.30, ColorManager.textColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: size.height * 0.8,
                    child: BuildBoxShadowContainer(
                      circleRadius: 7,
                      margin: const EdgeInsets.only(bottom: 10),
                      blurRadius: 6,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20,
                        top: 30,
                      ),
                      offsetValue: const Offset(1, 1),
                      child: Column(
                        // shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: size.height * 0.07,
                                width: size.width * 0.4,
                                child: TextField(
                                  onChanged: (query) {
                                    searchCustomers();
                                  },
                                  controller: searchTextController,
                                  cursorColor: ColorManager.kPrimaryColor,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search Customers.....",
                                      hintStyle: buildCustomStyle(
                                          FontWeightManager.medium,
                                          FontSize.s12,
                                          0.18,
                                          ColorManager.textColor),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: 35,
                                      ),
                                      prefixIconColor: Colors.black),
                                ),
                              ),
                              CustomRoundButtonWithIcon(
                                title: "Add New Customer",
                                fct: () {
                                  sideBarController.index.value = 9;
                                },
                                height: 50,
                                width: size.width * 0.19,
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                fontSize: FontSize.s12,
                                size: size,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(thickness: 2),
                          isInitLoading || customerList == null
                              ? SizedBox(
                                  height: size.height * 0.6,
                                )
                              : SizedBox(
                                  height: size.height * 0.6,
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: customerList == null
                                          ? 0
                                          : filteredCustomers.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: index % 2 == 0
                                                ? ColorManager
                                                    .containerShadowColorForList
                                                : null,
                                          ),
                                          child: ListTile(
                                            minLeadingWidth: 0,
                                            minVerticalPadding: 0,
                                            contentPadding: EdgeInsets.zero,
                                            visualDensity: const VisualDensity(
                                                horizontal: 0, vertical: 0),
                                            leading: ClipRRect(
                                              borderRadius: const BorderRadius
                                                  .all(
                                                  Radius.elliptical(21, 21)),
                                              child: Image.asset(
                                                ImageAssets.profileAvatarIcon,
                                              ),
                                            ),
                                            title: RichText(
                                              text: TextSpan(
                                                text:
                                                    '${customerList == null ? "" : filteredCustomers[index].name}\n',
                                                style: buildCustomStyle(
                                                    FontWeightManager.medium,
                                                    FontSize.s15,
                                                    0.23,
                                                    ColorManager.textColor),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${customerList == null ? "" : filteredCustomers[index].email}',
                                                    style: buildCustomStyle(
                                                        FontWeightManager
                                                            .medium,
                                                        FontSize.s12,
                                                        0.18,
                                                        Colors.black
                                                            .withOpacity(0.5)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: Text(
                                              customerList == null
                                                  ? ""
                                                  : "${filteredCustomers[index].createdAt!.day}/${filteredCustomers[index].createdAt!.month}/${filteredCustomers[index].createdAt!.year}",
                                              style: buildCustomStyle(
                                                  FontWeightManager.medium,
                                                  FontSize.s15,
                                                  0.21,
                                                  ColorManager.textColor),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
