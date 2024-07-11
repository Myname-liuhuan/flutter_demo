import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'image_tile_provider.dart';  // Adjust the import according to your file structure

class ImageTile extends StatelessWidget {
  final VoidCallback onTap; // Click event callback

  ImageTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageTileProvider>(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: provider.width,
        height: provider.height,
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
            image: NetworkImage(provider.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
