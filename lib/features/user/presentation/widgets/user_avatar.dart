import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/packages/core/ui/widgets/shimmer_widget.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.url,
    this.size = 50,
    this.tag,
  });
  final String url;
  final double size;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'user_avatar_$tag',
      child: url.isEmpty
          ? CircleAvatar(
              radius: size / 2,
              backgroundColor: Colors.white,
            )
          : CachedNetworkImage(
              imageUrl: url,
              imageBuilder: (context, imageProvider) => Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              placeholder: (context, url) => ClipOval(
                child: ShimmerWidget(
                  width: size,
                  height: size,
                ),
              ),
            ),
    );
  }
}
