import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCacheImageNetwork extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const CustomCacheImageNetwork({
    Key? key,
    required this.url,
    this.width = 40,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isNotEmpty && url.contains('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        width: width,
        height: height,
        errorWidget: (_, url, error) => _ImagePlaceHolder(
          width: width,
          height: height,
        ),
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return _ImagePlaceHolder(
      width: width,
      height: height,
    );
  }
}

class _ImagePlaceHolder extends StatelessWidget {
  final double? width;
  final double? height;

  const _ImagePlaceHolder({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.all(16),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/image_place_holder.svg',
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[350],
        ),
      ),
    );
  }
}
