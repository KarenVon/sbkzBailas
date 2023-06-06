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

      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 6,
        child: GridTile(
          footer: GridTileBar(backgroundColor: Colors.white,
            title: Text(
              sName,
              style: const TextStyle(
                  color: Colors.black38,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  //decoration: TextDecoration.underline,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 4)]
     ),
            ),
        ),
          child: Padding( //Column
            /*mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,*/
            //children[
            padding: const EdgeInsets.only(bottom: 10),
            child:
           ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: (Image.network(
                sImgURL,
                fit: BoxFit.cover,)),
            ),
          ),
        ),
      ),
    );
  }
}
