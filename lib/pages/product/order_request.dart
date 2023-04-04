import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:handover_app/components/flutter_flow_icon_button.dart';
import 'package:handover_app/components/flutter_flow_widgets.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:handover_app/constants.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';

class OrderRequestWidget extends StatefulWidget {
  const OrderRequestWidget({
    Key? key,
    this.propertyRef,
  }) : super(key: key);

  final String? propertyRef;

  @override
  _OrderRequestWidgetState createState() => _OrderRequestWidgetState();
}

class _OrderRequestWidgetState extends State<OrderRequestWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic product;
  late TextEditingController mobileController;
  late TextEditingController rewardController;

  @override
  void initState() {
    _fetchData();
    mobileController = TextEditingController();
    rewardController = TextEditingController();
    super.initState();
  }

  Future<void> _fetchData() async {
    final productDetailResponse =
        await ProductDetailCall.call(productId: widget.propertyRef!);
    var productResp =
        getJsonField(productDetailResponse.jsonBody, r'''$.product''');
    var images =
        getJsonField(productDetailResponse.jsonBody, r'''$.product.images''');
    if (images == null || images.length == 0) {
      images = ["https://picsum.photos/seed/1/300"];
    }

    setState(() {
      product = productResp;
    });
  }

  @override
  Widget build(BuildContext context) {
    var defaultImage = getJsonField(
      product,
      r'''$.default_image''',
    );

    if (defaultImage == null || defaultImage == "") {
      defaultImage = Constants.defaultImageUrl;
    }

    return product == null
        ? Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            ),
          )
        : Scaffold(
            key: scaffoldKey,
            backgroundColor: Constants.secondaryBackground,
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    defaultImage,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  getJsonField(
                    product,
                    r'''$.name''',
                  ),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  currencyFormat(getJsonField(
                        product,
                        r'''$.discounted_price''',
                      )) +
                      '원',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your details:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter your mobile number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: rewardController,
                  decoration: InputDecoration(
                    labelText: 'Reward Points',
                    hintText: 'Enter your reward points',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            )));
  }
}
