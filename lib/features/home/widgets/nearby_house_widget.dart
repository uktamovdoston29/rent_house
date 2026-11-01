import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_house/core/color/app_colors.dart';
import 'package:rent_house/core/gen/assets.gen.dart';
import 'package:rent_house/features/details/screens/detailscreen.dart';
import 'package:rent_house/features/home/model/house_model.dart';

class NearbyHouses extends StatelessWidget {
  const NearbyHouses({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('houses').snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snap.hasData) {
          List<HouseModel> data = [];
          data =
              snap.data?.docs.map((e) => HouseModel.fromDocument(e)).toList() ??
              [];
          return SizedBox(
            width: double.infinity,
            height: 180,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                mainAxisExtent: 251,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(house: data[index]),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            data[index].image,
                            width: 80,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SvgPicture.asset(
                                      Assets.icons.destination,
                                      width: 16,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      data[index].locationName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontSize: 10,

                                        color: AppColors.secondarygrey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${data[index].price}/oy",
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 13,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        data[index].rating.toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snap.hasError) {
          return Center(child: Text(snap.error.toString()));
        } else {
          return SizedBox();
        }
      },
    );
  }
}