
import 'package:flutter/material.dart';
import 'package:rent_house/core/gen/assets.gen.dart';
import 'package:rent_house/features/auth/widgets/social_widget.dart';

class OnlinePlatformsWidget extends StatelessWidget {
  const OnlinePlatformsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialWidget(
          path: Assets.icons.facebook,
          onTap: () {},
        ),
        SizedBox(width: 16),
        SocialWidget(path: Assets.icons.google, onTap: () {}),
      ],
    );
  }
}
