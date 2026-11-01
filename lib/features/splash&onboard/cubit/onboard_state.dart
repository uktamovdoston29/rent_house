import 'package:rent_house/core/gen/assets.gen.dart';

abstract class OnboardState {}

class OnboardSuccessState extends OnboardState {
  static List<Map<String, dynamic>> source = [
    {
      "title": "House Rent — kelajakdagi uyingizni toping",
      "description":
          "Oilangiz va yaqinlaringiz bilan yashash uchun eng qulay ijara uylarini toping",
      "image": Assets.images.first,
    },
    {
      "title": "Mulkingizni bir bosishda soting",
      "description":
          "Uy sotish jarayonini faqat smartfoningiz orqali soddalashtiring",
      "image": Assets.images.second,
    },
    {
      "title": "Orzuingizdagi uyni biz bilan toping",
      "description":
          "Sevimli mulkingizni qidiring va joylashuvini tanlang",
      "image": Assets.images.third,
    },
  ];
  int currentindex = 0;
  OnboardSuccessState({this.currentindex=0});
}
