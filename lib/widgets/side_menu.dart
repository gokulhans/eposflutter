import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pos_machine/resources/asset_manager.dart';
import 'package:pos_machine/responsive.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../controllers/sidebar_controller.dart';
import '../providers/cart.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/style_manager.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideBarController sideBarController = Get.put(SideBarController());
    // Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(child: WebsafeSvg.asset(ImageAssets.posLogo)),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Smart',
                style: buildCustomStyle(FontWeightManager.semiBold,
                    FontSize.s18, 0.27, ColorManager.textColor),
                children: <TextSpan>[
                  TextSpan(
                    text: 'POS',
                    style: buildCustomStyle(FontWeightManager.semiBold,
                        FontSize.s18, 0.27, ColorManager.kPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // SizedBox(
          //   height: 300,
          //   child: Row(
          //     children: [
          //       NavigationRail(destinations: [
          //         NavigationRailDestination(
          //             icon: WebsafeSvg.asset(
          //               ImageAssets.homeIcon,
          //             ),
          //             label: Text(
          //               "Home",
          //               style: TextStyle(color: Colors.black),
          //             )),
          //         NavigationRailDestination(
          //             icon: WebsafeSvg.asset(
          //               ImageAssets.homeIcon,
          //             ),
          //             label: Text("Home")),
          //         NavigationRailDestination(
          //             icon: WebsafeSvg.asset(
          //               ImageAssets.homeIcon,
          //             ),
          //             label: Text("Home")),
          //         NavigationRailDestination(
          //             icon: WebsafeSvg.asset(
          //               ImageAssets.homeIcon,
          //             ),
          //             label: Text("Home")),
          //       ], selectedIndex: 0)
          //     ],
          //   ),
          // ),
          // RoundButtonWithIcon(
          //   title: 'Home',
          //   fct: () {},
          //   size: size,
          //   iconPath: ImageAssets.homeIcon,
          // ),
          Obx(
            () => DrawerListTile(
              iconPath: ImageAssets.homeIcon,
              title: 'Home',
              onTap: () {
                debugPrint(" 'Home',${sideBarController.index.value}");
                sideBarController.index.value = 0;
              },
              selected: sideBarController.index.value == 0,
            ),
          ),
          Obx(
            () => DrawerListTile(
              iconPath: ImageAssets.dashBoardIcon,
              title: 'Dashboard',
              onTap: () {
                debugPrint(" 'Dashboard',${sideBarController.index.value}");
                sideBarController.index.value = 1;
              },
              selected: sideBarController.index.value == 1,
            ),
          ),
          Obx(
            () => DrawerListTile(
              iconPath: ImageAssets.saleIcon,
              title: 'Sales',
              onTap: () {
                debugPrint(" 'Sales',${sideBarController.index.value}");
                sideBarController.index.value = 2;
              },
              selected: sideBarController.index.value == 2,
            ),
          ),
          Obx(
            () => DrawerListTile(
              iconPath: ImageAssets.cartIcon,
              title: 'Cart',
              items: Provider.of<Cart>(context, listen: true).getCartItems,
              onTap: () {
                sideBarController.index.value = 3;
                debugPrint(" 'Cart',${sideBarController.index.value}");
              },
              selected: sideBarController.index.value == 3,
            ),
          ),
          Obx(
            () => DrawerListTile(
              iconPath: ImageAssets.transactionIcon,
              title: 'Transaction',
              onTap: () {
                sideBarController.index.value = 4;
                debugPrint(" 'Transaction',${sideBarController.index.value}");
              },
              selected: sideBarController.index.value == 4,
            ),
          ),
          Obx(
            () => DrawerListTile(
              iconPath: ImageAssets.customerIcon,
              title: 'Customers',
              onTap: () {
                sideBarController.index.value = 5;
                debugPrint(" 'Customers',${sideBarController.index.value}");
              },
              selected: sideBarController.index.value == 5 ||
                  sideBarController.index.value == 9,
            ),
          ),

          Obx(
            () => DrawerListTile(
              iconPath: ImageAssets.cardIcon,
              title: 'Loyalty Card',
              onTap: () {
                sideBarController.index.value = 6;
                debugPrint(" 'Loyality Card',${sideBarController.index.value}");
              },
              selected: sideBarController.index.value == 6,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Text(
              'Other',
              style: buildCustomStyle(FontWeightManager.medium, FontSize.s13,
                  0.16, ColorManager.textColor),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => DrawerListTile(
              iconPath: ImageAssets.notificationIcon,
              title: 'Notifications',
              items: 3,
              onTap: () {
                sideBarController.index.value = 7;
                debugPrint(" 'Notifications',${sideBarController.index.value}");
              },
              selected: sideBarController.index.value == 7,
            ),
          ),

          Obx(
            () => DrawerListTile(
              iconPath: ImageAssets.supportIcon,
              title: 'Support',
              onTap: () {
                sideBarController.index.value = 8;
                debugPrint(" 'Support',${sideBarController.index.value}");
              },
              selected: sideBarController.index.value == 8,
            ),
          ),
          DrawerListTile(
            iconPath: ImageAssets.logoutIcon,
            title: 'Logout',
            onTap: () {
              debugPrint(" 'Logout',${sideBarController.index.value}");
            },
            selected: false,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 170,
            width: 180,
            margin: ResponsiveWidget.isTablet(context)
                ? const EdgeInsets.only(
                    left: 20, top: 20, bottom: 10, right: 10)
                : const EdgeInsets.only(left: 30, top: 20, bottom: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                    color: ColorManager.boxShadowColor,
                    blurRadius: 6,
                    offset: Offset(1, 1),
                  ),
                ],
                color: Colors.white),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage(ImageAssets.profilePhotoIcon),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Ajay Antony',
                  style: buildCustomStyle(FontWeightManager.semiBold,
                      FontSize.s14, 0.21, ColorManager.textColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    sideBarController.index.value = 10;
                  },
                  child: Container(
                      height: 30,
                      width: 130,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorManager.containerShadowColor1,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Open profile',
                        style: buildCustomStyle(FontWeightManager.medium,
                            FontSize.s12, 0.16, ColorManager.textColor),
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: Text(
              '2022 SmartPOP App',
              style: buildCustomStyle(FontWeightManager.medium, FontSize.s12,
                  0.16, ColorManager.textColor),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final int? items;
  final bool selected;
  final VoidCallback onTap;
  const DrawerListTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.selected,
    required this.onTap,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return selected
        ? Stack(
            children: [
              Positioned.fill(
                  child: Container(
                alignment: Alignment.center,
                width: 200,
                height: MediaQuery.of(context).size.height * .055,
                margin: ResponsiveWidget.isTablet(context)
                    ? const EdgeInsets.only(left: 10, bottom: 5)
                    : const EdgeInsets.only(left: 20, bottom: 5),
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: ColorManager.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              )),
              ListTile(
                selected: selected,
                contentPadding: ResponsiveWidget.isTablet(context)
                    ? const EdgeInsets.only(left: 15, right: 10)
                    : const EdgeInsets.only(left: 45, right: 15),
                horizontalTitleGap: 0.0,
                visualDensity: const VisualDensity(vertical: -4, horizontal: 0),
                minVerticalPadding: 0,
                onTap: onTap,
                leading: WebsafeSvg.asset(iconPath, color: Colors.white),
                trailing: items != null
                    ? buildNotification(
                        item: items ?? 0,
                        selected: selected,
                      )
                    : const SizedBox(
                        height: 5,
                        width: 5,
                      ),
                title: Text(
                  title,
                  style: buildCustomStyle(FontWeightManager.medium,
                      FontSize.s14, 0.21, ColorManager.textColor),
                ),
              ),
            ],
          )
        :
        //     Container(
        //   alignment: Alignment.center,
        //   // width: 200,
        //   // height: MediaQuery.of(context).size.height * .055,
        //   // margin: ResponsiveWidget.isTablet(context)
        //   //     ? const EdgeInsets.only(left: 10, bottom: 5)
        //   //     : const EdgeInsets.only(left: 20, bottom: 5),
        // //  margin: const EdgeInsets.only(left: 20),
        //   decoration: BoxDecoration(
        //     color: selected ? ColorManager.kPrimaryColor : Colors.transparent,
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child:
        ListTile(
            selected: selected,
            contentPadding: ResponsiveWidget.isTablet(context)
                ? const EdgeInsets.only(left: 15, right: 10)
                : const EdgeInsets.only(left: 45, right: 15),
            horizontalTitleGap: 0.0,
            visualDensity: const VisualDensity(vertical: -4, horizontal: 0),
            minVerticalPadding: 0,
            onTap: onTap,
            leading: WebsafeSvg.asset(iconPath,
                color: ColorManager.kPrimaryColor
                // color: selected ? Colors.white : ColorManager.kPrimaryColor
                ),
            trailing: items != null
                ? buildNotification(
                    item: items ?? 0,
                    selected: selected,
                  )
                : const SizedBox(
                    height: 5,
                    width: 5,
                  ),
            title: Text(
              title,
              style: buildCustomStyle(FontWeightManager.medium, FontSize.s14,
                  0.21, ColorManager.textColor),
            ),
          );
  }
}

Widget buildNotification({
  required int item,
  required bool selected,
}) {
  return Stack(
    children: [
      Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : ColorManager.kPrimaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text('$item',
            style: TextStyle(
              color: selected ? Colors.black : Colors.white,
              fontWeight: FontWeightManager.regular,
              fontFamily: FontConstants.fontFamily,
              fontSize: FontSize.s10,
              letterSpacing: 0.16,
            )),
      ),
    ],
  );
}
