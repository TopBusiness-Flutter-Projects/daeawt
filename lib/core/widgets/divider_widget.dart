import 'package:flutter/material.dart';

class DividerCustomWidget extends StatelessWidget {
  const DividerCustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    SizedBox(
      width: MediaQuery.of(context).size.width * 0.13,
      child: const Divider(
        color: Colors.grey,
      ),
    );
  }
}
