import 'package:rent_house/core/gen/assets.gen.dart';

abstract class OnboardState {}

class OnboardSuccessState extends OnboardState {
  static List<Map<String, dynamic>> source = [
    {
      "title": "Find the perfect place for your future house",
      "description":
          "find the best place for your dream house with your family and loved ones",
      "image": Assets.images.first,
    },
    {
      "title": "Fast sell your property in just one click",
      "description":
          "Simplify the property sales process with just your smartphone",
      "image": Assets.images.second,
    },
    {
      "title": "find your dream home with us",
      "description":
          "Just search and select your favorite property you want to locate",
      "image": Assets.images.third,
    },
  ];
  int currentindex = 0;
  OnboardSuccessState({this.currentindex=0});
}
