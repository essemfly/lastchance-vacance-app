import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductAddWidget extends StatefulWidget {
  @override
  _ProductAddWidgetState createState() => _ProductAddWidgetState();
}

class _ProductAddWidgetState extends State<ProductAddWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '바캉스 등록 요청하기',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
            child: Text("상품 등록을 요청주시면 관리자가 확인 후 등록해드립니다."),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Constants.primaryColor,
                  ),
                ),
                onPressed: () async {
                  Uri url = Uri.parse(Constants.addProductUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text('등록 요청하기'),
              ),
            ],
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}