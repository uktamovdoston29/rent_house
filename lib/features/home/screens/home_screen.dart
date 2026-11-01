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
import 'package:rent_house/utils/services/location_service.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationService _locationService = LocationService();
  String _shortName = 'Joylashuv';
  String _address = 'Manzil aniqlanmoqda...';
  bool _isLocating = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserLocation();
    });
  }

  Future<void> _loadUserLocation() async {
    setState(() {
      _isLocating = true;
      _address = 'Manzil aniqlanmoqda...';
    });

    try {
      final place = await _locationService.resolveCurrentPlace();
      if (!mounted) return;
      setState(() {
        _shortName = place.shortName;
        _address = place.address;
        _isLocating = false;
      });
    } catch (error) {
      if (!mounted) return;
      final message = error.toString();
      setState(() {
        _isLocating = false;
        if (message.contains('permission-denied-forever')) {
          _shortName = 'Ruxsat yo‘q';
          _address = 'Sozlamalardan joylashuv ruxsatini yoqing';
        } else if (message.contains('permission-denied')) {
          _shortName = 'Ruxsat yo‘q';
          _address = 'Joylashuv ruxsatini bering';
        } else if (message.contains('location-disabled')) {
          _shortName = 'GPS o‘chiq';
          _address = 'Qurilmada joylashuv xizmatini yoqing';
        } else {
          _shortName = 'Joylashuv';
          _address = 'Manzilni aniqlab bo‘lmadi';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 82,
        titleSpacing: 24,
        title: InkWell(
          onTap: _loadUserLocation,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Joylashuv',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.destination,
                    colorFilter: ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _isLocating
                        ? Text(
                            'Aniqlanmoqda...',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            _shortName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
                ],
              ),
              Text(
                _address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.secondarygrey,
                  child: SvgPicture.asset(Assets.icons.notification),
                ),
                const SizedBox(width: 8),
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
              const SizedBox(height: 32),
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Uy qidirish',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(Assets.icons.filter),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 110,
                width: double.infinity,
                child: Assets.images.ads.image(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Tavsiya etilgan',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Barchasi',
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
                        SizedBox(
                          width: 300,
                          child: Text(state.error, maxLines: 3),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<HomeCubit>().getHouses();
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    );
                  } else if (state is HomeSuccessState) {
                    return Column(
                      children: [
                        RecommendedHouses(data: state.houses),
                        const SizedBox(height: 24),
                        const TextsWidget(text: 'Yaqin-atrofda'),
                        const SizedBox(height: 16),
                        const NearbyHouses(),
                        const SizedBox(height: 30),
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
                                decoration: const BoxDecoration(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
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
