import 'package:cached_network_image/cached_network_image.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';

class PhotoBox extends StatelessWidget {
  final String photoUrl;

  const PhotoBox({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: photoUrl.isNotEmpty ? '$baseUrlImg/$photoUrl' : '',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
