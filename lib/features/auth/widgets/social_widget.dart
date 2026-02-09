import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rent_house/core/color/app_colors.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key, required this.path, required this.onTap});

  final String path;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: AppColors.secondarygrey,
        child: SvgPicture.asset(path),
      ),
    );
  }
}
