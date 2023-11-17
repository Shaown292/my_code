import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/app_colors.dart';

class CacheImageView extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color color;
  final String? errorImageLocal;

  const CacheImageView({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = Colors.transparent,
    this.errorImageLocal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url != null && url!.isNotEmpty ? url! : '',
      cacheKey: url != null && url!.isNotEmpty ? url! : '',
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      // placeholder
      placeholder: (context, url) {
        if (height == null && width == null) {
          return FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.5,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryColor.withOpacity(0.5),
            ),
          );
        }
        return SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryColor.withOpacity(0.5),
          ),
        );
      },
      errorWidget: (context, url, error) => Image.asset(
        errorImageLocal ?? 'assets/image/production/galary.png',
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
