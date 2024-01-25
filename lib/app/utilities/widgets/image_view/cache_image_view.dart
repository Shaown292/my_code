import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/image_path.dart';

import '../../../data/constants/app_colors.dart';

class CacheImageView extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color color;
  final String? errorImageLocal;
  final BoxShape? boxShape;

  const CacheImageView({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = Colors.transparent,
    this.errorImageLocal,
    super.key, this.boxShape,
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
          shape: boxShape ?? BoxShape.circle ,
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
      errorWidget: (context, url, error) => Container(
        height: 20,
        width: 20,
        decoration:  BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(errorImageLocal ?? ImagePath.dp,)
          )
        ),

      ),
    );
  }
}
