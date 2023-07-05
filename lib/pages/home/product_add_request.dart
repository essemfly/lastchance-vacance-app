import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductAddWidget extends StatefulWidget {
  const ProductAddWidget({super.key});

  @override
  _ProductAddWidgetState createState() => _ProductAddWidgetState();
}

class _ProductAddWidgetState extends State<ProductAddWidget> {
  bool _isEventLogged = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isEventLogged) {
      logPageView('Product Add Page');
      _isEventLogged = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '바캉스 등록 요청하기',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
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
                child: const Text('등록 요청하기'),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
