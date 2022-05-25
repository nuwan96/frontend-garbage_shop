import 'dart:io';
import 'package:flutter/material.dart';

class FertilizerListTileWidget extends StatefulWidget {
  final double price;
  final String name;
  final File imageUrl;
  const FertilizerListTileWidget(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.price})
      : super(key: key);
  @override
  _FertilizerListTileWidgetState createState() =>
      _FertilizerListTileWidgetState();
}

class _FertilizerListTileWidgetState extends State<FertilizerListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(62.5),
                child: Container(
                  width: ((MediaQuery.of(context).size.width) / 4 - 20),
                  height: ((MediaQuery.of(context).size.width) / 4 - 20),
                  decoration: const BoxDecoration(
                      color: Color(0XFFF4F0E3),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 6.0)
                      ]),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(
                      widget.imageUrl,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 16,
            ),
            child: Text(
              widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.0,
                color: Color(0XFF303030),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Text(
          "${widget.price}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10.0,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        )
      ],
    );
  }
}
