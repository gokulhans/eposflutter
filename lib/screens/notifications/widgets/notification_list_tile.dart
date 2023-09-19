import 'package:flutter/material.dart';

import '../../../components/build_container_box.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/style_manager.dart';

class NotificationListTileWidget extends StatefulWidget {
  final Size size;

  final bool indexExpand;
  final int index;
  final bool success;
  final String orderNumber;
  final String subTitle;
  final String amount;
  final String card;
  final String time;
  final int itemsCount;
  const NotificationListTileWidget(
      {super.key,
      required this.size,
      required this.index,
      required this.indexExpand,
      required this.success,
      required this.orderNumber,
      required this.subTitle,
      required this.amount,
      required this.card,
      required this.time,
      required this.itemsCount});

  @override
  State<NotificationListTileWidget> createState() =>
      _NotificationListTileWidgetState();
}

class _NotificationListTileWidgetState
    extends State<NotificationListTileWidget> {
  bool expand = false;
  @override
  void initState() {
    expand = widget.indexExpand;
    super.initState();
  }

  void _handleExpansionChanged(int tileIndex, bool newIsExpanded) {
    setState(() {
      expand = newIsExpanded;
    });

    // You can perform additional actions here when a tile is expanded or collapsed.
    if (newIsExpanded) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return BuildBoxShadowContainer(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 45),
      circleRadius: 7,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: RichText(
          text: TextSpan(
              text: "Order #${widget.orderNumber}\n",
              style: buildCustomStyle(
                FontWeightManager.semiBold,
                FontSize.s15,
                0.23,
                Colors.black,
              ),
              children: [
                TextSpan(
                  text: widget.subTitle,
                  style: buildCustomStyle(
                    FontWeightManager.regular,
                    FontSize.s10,
                    0.16,
                    Colors.black,
                  ),
                ),
              ]),
        ),
        subtitle: Theme(
          data: ThemeData(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (newIsExpanded) {
              _handleExpansionChanged(widget.index, newIsExpanded);
            },

            maintainState: true,
            childrenPadding: EdgeInsets.zero,
            tilePadding: EdgeInsets.zero,
            // key: keyTile,
            initiallyExpanded: expand,
            controlAffinity: null,
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            title: Row(
              children: [
                Text(
                  "See Detail",
                  style: buildCustomStyle(
                    FontWeightManager.regular,
                    FontSize.s10,
                    0.13,
                    Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                expand
                    ? const Icon(
                        Icons.keyboard_arrow_up,
                        color: ColorManager.textColor,
                      )
                    : const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                      )
              ],
            ),
            children: <Widget>[
              ListView.builder(
                  itemCount: widget.itemsCount,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: buildCustomStyle(FontWeightManager.regular,
                            FontSize.s16, 0.25, ColorManager.textColor),
                      ),
                      title: RichText(
                        text: TextSpan(
                          text: 'MIGHTY ZINGER BOX\n',
                          style: buildCustomStyle(FontWeightManager.regular,
                              FontSize.s16, 0.25, ColorManager.textColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: '150 g',
                              style: buildCustomStyle(
                                  FontWeightManager.medium,
                                  FontSize.s11,
                                  0.17,
                                  Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                      trailing: Text(
                        '\$25.00',
                        style: buildCustomStyle(FontWeightManager.regular,
                            FontSize.s18, 0.21, Colors.black.withOpacity(0.5)),
                      ),
                    );
                  }),
            ],
          ),
        ),
        leading: widget.success
            ? Container(
                decoration: const BoxDecoration(
                    color: ColorManager.kGreenBox, shape: BoxShape.circle),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                    color: ColorManager.kRedBox, shape: BoxShape.circle),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
        trailing: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.time,
                style: buildCustomStyle(
                  FontWeightManager.regular,
                  FontSize.s9,
                  0.13,
                  Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.amount.isEmpty ? "" : "\$ ${widget.amount}",
                      style: buildCustomStyle(
                        FontWeightManager.semiBold,
                        FontSize.s18,
                        0.27,
                        Colors.black,
                      ),
                    ),
                    widget.card.isEmpty
                        ? Container()
                        : BuildBoxShadowContainer(
                            blurRadius: 6,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 20, top: 0),
                            color: ColorManager.kBoxColorF7,
                            offsetValue: const Offset(1, 1),
                            circleRadius: 4,
                            height: widget.size.height * 0.04,
                            width: widget.size.width * 0.06,
                            // padding: const EdgeInsets.only(
                            //     left: 10, top: 5),
                            child: Text(
                              widget.card,
                              style: buildCustomStyle(
                                FontWeightManager.regular,
                                FontSize.s9,
                                0.13,
                                Colors.black,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ), //
      ),
    );
  }
}
