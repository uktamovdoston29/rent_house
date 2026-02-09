// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/calender.svg
  String get calender => 'assets/icons/calender.svg';

  /// File path: assets/icons/call.svg
  String get call => 'assets/icons/call.svg';

  /// File path: assets/icons/camera.svg
  String get camera => 'assets/icons/camera.svg';

  /// File path: assets/icons/chat.svg
  String get chat => 'assets/icons/chat.svg';

  /// File path: assets/icons/comment.svg
  String get comment => 'assets/icons/comment.svg';

  /// File path: assets/icons/destination.svg
  String get destination => 'assets/icons/destination.svg';

  /// File path: assets/icons/discovery.svg
  String get discovery => 'assets/icons/discovery.svg';

  /// File path: assets/icons/down.svg
  String get down => 'assets/icons/down.svg';

  /// File path: assets/icons/facebook.svg
  String get facebook => 'assets/icons/facebook.svg';

  /// File path: assets/icons/filter.svg
  String get filter => 'assets/icons/filter.svg';

  /// File path: assets/icons/google.svg
  String get google => 'assets/icons/google.svg';

  /// File path: assets/icons/heart.svg
  String get heart => 'assets/icons/heart.svg';

  /// File path: assets/icons/hide.svg
  String get hide => 'assets/icons/hide.svg';

  /// File path: assets/icons/home.svg
  String get home => 'assets/icons/home.svg';

  /// File path: assets/icons/index.svg
  String get index => 'assets/icons/index.svg';

  /// File path: assets/icons/main_home.svg
  String get mainHome => 'assets/icons/main_home.svg';

  /// File path: assets/icons/message.svg
  String get message => 'assets/icons/message.svg';

  /// File path: assets/icons/more.svg
  String get more => 'assets/icons/more.svg';

  /// File path: assets/icons/notification.svg
  String get notification => 'assets/icons/notification.svg';

  /// File path: assets/icons/notification_part.svg
  String get notificationPart => 'assets/icons/notification_part.svg';

  /// File path: assets/icons/profile.svg
  String get profile => 'assets/icons/profile.svg';

  /// File path: assets/icons/right.svg
  String get right => 'assets/icons/right.svg';

  /// File path: assets/icons/search.svg
  String get search => 'assets/icons/search.svg';

  /// File path: assets/icons/share.svg
  String get share => 'assets/icons/share.svg';

  /// File path: assets/icons/star.svg
  String get star => 'assets/icons/star.svg';

  /// File path: assets/icons/table.svg
  String get table => 'assets/icons/table.svg';

  /// File path: assets/icons/turn_left.svg
  String get turnLeft => 'assets/icons/turn_left.svg';

  /// List of all assets
  List<String> get values => [
    calender,
    call,
    camera,
    chat,
    comment,
    destination,
    discovery,
    down,
    facebook,
    filter,
    google,
    heart,
    hide,
    home,
    index,
    mainHome,
    message,
    more,
    notification,
    notificationPart,
    profile,
    right,
    search,
    share,
    star,
    table,
    turnLeft,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ads.png
  AssetGenImage get ads => const AssetGenImage('assets/images/ads.png');

  /// File path: assets/images/first.png
  AssetGenImage get first => const AssetGenImage('assets/images/first.png');

  /// File path: assets/images/main_logo.png
  AssetGenImage get mainLogo =>
      const AssetGenImage('assets/images/main_logo.png');

  /// File path: assets/images/permission.png
  AssetGenImage get permission =>
      const AssetGenImage('assets/images/permission.png');

  /// File path: assets/images/second.png
  AssetGenImage get second => const AssetGenImage('assets/images/second.png');

  /// File path: assets/images/success.png
  AssetGenImage get success => const AssetGenImage('assets/images/success.png');

  /// File path: assets/images/third.png
  AssetGenImage get third => const AssetGenImage('assets/images/third.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    ads,
    first,
    mainLogo,
    permission,
    second,
    success,
    third,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
