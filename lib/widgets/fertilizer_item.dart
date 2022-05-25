import 'dart:io';
import 'package:flutter/material.dart';

class FertilzerItem extends StatelessWidget {
  final String name;
  final String type;
  final double unitPrice;
  final File image;
  const FertilzerItem({
    Key? key,
    required this.name,
    required this.type,
    required this.unitPrice,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Image.file(
            image,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Text(
            unitPrice.toString(),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          title: Text(
            name,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
