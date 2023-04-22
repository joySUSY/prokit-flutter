import 'package:flutter/material.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:prokit_flutter/main/utils/sticky_header/sticky_headers/widget.dart';
import 'package:prokit_flutter/main/utils/AppConstant.dart';

class SimpleHeaders extends StatelessWidget {
  static String tag = '/SimpleHeaders';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, 'Headers and Content'),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return StickyHeader(
              header: Container(
                height: 50.0,
                color: Colors.blueGrey[700],
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Header #$index',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              content: Container(
                child: Image.network('$BaseUrl/images/food/food_ic_popular2.jpg', fit: BoxFit.cover, width: double.infinity, height: 200.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
