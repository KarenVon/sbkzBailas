import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String sImgURL;
  final String sName;
  final Function(int index) onShortClick;
  final int index;

  RoomCard(
      {Key? key,
      required this.sImgURL,
      required this.sName,
      required this.onShortClick,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onShortClick(index);
      },
      /*child: Card(
        color: Colors.white,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox (child: Image.network(sImgURL),
              width: 200 ,
              height: 100 ,
            ),
            Text(sName)
          ],
        ),
      ),*/

      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 6,
        child: GridTile(
          footer: GridTileBar(
            title: Text(
              sName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline,
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)]),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: (Image.network(
                sImgURL,
                fit: BoxFit.cover)),
            ),
            
          ),
        ),
      ),
    );
  }
}
