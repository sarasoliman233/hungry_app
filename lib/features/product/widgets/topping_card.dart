import 'package:flutter/material.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({super.key, required this.image, required this.title, required this.onAdd});

  final String image;
  final String title;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Top image
        ClipRRect(
          borderRadius:  BorderRadius.circular(20),
          child: Container(
            height: 75,
            width: 100,
            color: Color(0xff3C2F2F),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(children: [],)
                )
              ],
            ),
          )
        ),
        
        Positioned(
            top: -35,
            right: -5,
            left: -5,
            child: SizedBox(
              height: 70,
              child: Card(
                color: Colors.white,

                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Image.network(image,fit: BoxFit.contain),
                ),
              ),
            )),

        Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all( 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),),

                  GestureDetector(
                    onTap: onAdd,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.add,color: Colors.white,size: 12,),
                    ),
                  )
                ],
              ),
            ),)

        // Bottom section

      ],
    );
  }
}
