import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'house_model.g.dart';

@HiveType(typeId: 0)
class HouseModel {
  @HiveField(1)
  final String id;
  
  @HiveField(2)
  final String image;

  @HiveField(3)
  final double latitude;

  @HiveField(4)
  final double longitude;

  @HiveField(5)
  final String locationName;

  @HiveField(6)
  final String name;

  @HiveField(7)
  final int price;

  @HiveField(8)
  final double rating;

  const HouseModel({
    required this.id,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.locationName,
    required this.name,
    required this.price,
    required this.rating,
  });

  factory HouseModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final geo = data['location'] as GeoPoint;

    return HouseModel(
      id: doc.id,
      image: data['image'] as String? ?? '',
      latitude: geo.latitude,
      longitude: geo.longitude,
      locationName: data['location_name'] as String? ?? '',
      name: data['name'] as String? ?? '',
      price: (data['price'] as num?)?.toInt() ?? 0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'location': GeoPoint(latitude, longitude),
      'location_name': locationName,
      'name': name,
      'price': price,
      'rating': rating,
    };
  }
}
