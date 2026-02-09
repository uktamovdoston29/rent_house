import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';
import 'package:rent_house/core/gen/assets.gen.dart';
import 'package:rent_house/features/home/cubit/cubit/home_cubit.dart';
import 'package:rent_house/features/home/cubit/cubit/home_state.dart';
import 'package:rent_house/features/home/widgets/nearby_house_widget.dart';
import 'package:rent_house/features/home/widgets/recommended_house.dart';
import 'package:rent_house/features/home/widgets/text_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Location",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: SvgPicture.asset(Assets.icons.down),
                    color: AppColors.primary,
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.destination,
                    color: AppColors.primary,
                  ),
                  Text(
                    "Yogyakarta, Ind",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.secondarygrey,
                  child: SvgPicture.asset(Assets.icons.notification),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.secondarygrey,
                  child: SvgPicture.asset(Assets.icons.comment),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 32),
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.icons.search),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Property",
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SvgPicture.asset(Assets.icons.filter),
                  ],
                ),
              ),
              SizedBox(height: 22),
              Container(
                height: 110,
                width: double.infinity,
                child: Assets.images.ads.image(),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    "Recommended",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See all",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeErrorState) {
                    return Row(
                      children: [
                        SizedBox(width: 300,child: Text(state.error, maxLines: 3,)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
                      ],
                    );
                  } else if (state is HomeSuccessState) {
                    return Column(
                      children: [
                        RecommendedHouses(data: state.houses),
                        SizedBox(height: 24),
                        TextsWidget(text: 'Nearby'),
                        SizedBox(height: 16),
                        NearbyHouses(),
                        SizedBox(height: 30),
                      ],
                    );
                  } else if (state is HomeLoadingState) {
                    return SizedBox(
                      width: double.infinity,
                      height: 165,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Shimmer.fromColors(
                              baseColor: AppColors.secondarygrey,
                              highlightColor: AppColors.white,
                              child: Container(
                                width: 225,
                                height: 165,
                                decoration: BoxDecoration(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
