import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rent_house/core/color/app_colors.dart';
import 'package:rent_house/core/gen/assets.gen.dart';
import 'package:rent_house/features/details/screens/detailscreen.dart';
import 'package:rent_house/features/home/model/house_model.dart';
import 'package:rent_house/utils/services/hive_service.dart';

class RecommendedHouses extends StatefulWidget {
  const RecommendedHouses({super.key, required this.data});

  final List<HouseModel> data;

  @override
  State<RecommendedHouses> createState() => _RecommendedHousesState();
}

class _RecommendedHousesState extends State<RecommendedHouses> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 165,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          final house = widget.data[index];
          final isFavourite = HiveService.isFavourite(house.id);

          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => DetailScreen(house: house)),
                );
              },
              child: Container(
                width: 225,
                height: 165,
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        house.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Text('No image'),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: '\$${house.price}',
                            style:  TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '/month',
                                style: TextStyle(
                                  color: AppColors.secondaryblack,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 24,
                      left: 16,
                      right: 16,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  house.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    SvgPicture.asset(Assets.icons.destination),
                                    const SizedBox(width: 4),
                                    Text(
                                      house.locationName,
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (HiveService.isFavourite(house.id)) {
                                await HiveService.removeFromFavourites(
                                  house.id,
                                );
                              } else {
                                await HiveService.addToFavourites(house);
                              }
                              setState(() {});
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(
                                isFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavourite
                                    ? Colors.red
                                    : AppColors.grey,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
