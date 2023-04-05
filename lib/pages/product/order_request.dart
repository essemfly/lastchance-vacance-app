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

    if (product == null) {
      return Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: Constants.primaryColor,
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Constants.secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            '바캉스 거래 요청',
            style: CustomTypography.subtitle2,
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
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
            SizedBox(height: 30),
            Text(
              '구매요청 정보 입력',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: mobileController,
              decoration: InputDecoration(
                labelText: '연락받으실 전화번호',
                hintText: '010-1234-1234',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: rewardController,
              decoration: InputDecoration(
                labelText: '사례금',
                hintText: '얼마까지 가능하신가요?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FFButtonWidget(
                onPressed: () async {
                  await CreateOrderCall.call(productid: widget.propertyRef!);
                  await launchURL(getJsonField(
                    product,
                    r'''$.outlink''',
                  ));
                },
                text: '구매 요청',
                options: FFButtonOptions(
                  width: 130,
                  height: 50,
                  color: Constants.primaryColor,
                  textStyle: CustomTypography.subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: Constants.secondaryBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  elevation: 3,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            // Spacer(),
            // Container(
            //   width: double.infinity,
            //   child: E
            // ),
          ],
        )));
  }
}
