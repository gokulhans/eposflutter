import 'package:flutter/material.dart';

import '../resources/asset_manager.dart';
import '../resources/color_manager.dart';

class BuildProfilePicture extends StatelessWidget {
  const BuildProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 39,
      backgroundColor: ColorManager.kPrimaryColor,
      child: CircleAvatar(
        radius: 37,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 32,
          backgroundImage: AssetImage(
            ImageAssets.profileAvatarIcon,
          ),
        ),
      ),
    );
  }
}
