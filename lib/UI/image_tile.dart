import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final VoidCallback onTap; // 点击事件回调

  ImageTile({
    required this.imageUrl,
    this.width = 100.0,
    this.height = 100.0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
