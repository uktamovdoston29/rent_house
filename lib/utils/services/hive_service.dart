import "package:hive/hive.dart";
import 'package:path_provider/path_provider.dart';
import 'package:rent_house/features/home/model/house_model.dart';

class HiveService {
  /// Box faqat favourite uylarga ishlatiladi
  static String boxName = "houses";
  static late Box<HouseModel> houseBox;

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(HouseModelAdapter());
    houseBox = await Hive.openBox<HouseModel>(boxName);
  }

  /// Favourites ro'yxatiga uy qo'shish
  static Future<void> addToFavourites(HouseModel house) async {
    if (!isFavourite(house.id)) {
      await houseBox.add(house);
    }
  }

  /// Favourites ro'yxatidan uy o'chirish (id bo'yicha)
  static Future<void> removeFromFavourites(String id) async {
    final keys = houseBox.keys.toList();
    for (final key in keys) {
      final value = houseBox.get(key);
      if (value != null && value.id == id) {
        await houseBox.delete(key);
        break;
      }
    }
  }

  /// Uy favourite ekanligini tekshirish
  static bool isFavourite(String id) {
    return houseBox.values.any((house) => house.id == id);
  }

  /// Barcha favourite uylani olish
  static List<HouseModel> getFavouriteHouses() {
    return houseBox.values.toList();
  }
}
