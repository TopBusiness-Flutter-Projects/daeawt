import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';

class ScanListItem extends StatelessWidget {
  const ScanListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
      child: Card(
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImageAssests.homeItem),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "sat, 01 jun 2023",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text("عيد ميلاد",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  Text("شبين الكوم , المنوفية",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400)),

                  SizedBox(
                    height: 45,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 50.0),
                  //   child: Container(
                  //     padding: EdgeInsets.all(10),
                  //     decoration: BoxDecoration(
                  //       color: Colors.green,
                  //       borderRadius: BorderRadius.circular(10)
                  //     ),
                  //       child: Text("approved")),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
