import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedImageNetwork({required String url, double? height, double? width, BoxFit? fit}) {
  return CachedNetworkImage(imageUrl: url, fit: fit ?? BoxFit.cover, height: height, width: width, placeholder: (context, url) => SizedBox(height: height, width: width));
}
