
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rent_house/core/color/app_colors.dart';
import 'package:rent_house/core/gen/assets.gen.dart';
import 'package:rent_house/features/mainscreen/cubit/main_cubit.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<MainCubit>().screens[context.watch<MainCubit>().currentIndex],
      bottomNavigationBar: Material(
        elevation: 5.0,
        shadowColor: AppColors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(39),
            topRight: Radius.circular(39),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(39),
            topRight: Radius.circular(39),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              context.read<MainCubit>().changeIndex(index);
            },
            currentIndex: context.watch<MainCubit>().currentIndex,
            elevation: 5.0,
            fixedColor: AppColors.primary,
            backgroundColor: AppColors.white,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                 Assets.icons.home,
                  colorFilter: ColorFilter.mode(
                    context.watch<MainCubit>().currentIndex == 0
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.icons.discovery,
                  colorFilter: ColorFilter.mode(
                    context.watch<MainCubit>().currentIndex == 1
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                 Assets.icons.heart,
                  colorFilter: ColorFilter.mode(
                    context.watch<MainCubit>().currentIndex == 2
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
               Assets.icons.table,
                  colorFilter: ColorFilter.mode(
                    context.watch<MainCubit>().currentIndex == 3
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'My Booking',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
               Assets.icons.profile,
                  colorFilter: ColorFilter.mode(
                    context.watch<MainCubit>().currentIndex == 4
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
