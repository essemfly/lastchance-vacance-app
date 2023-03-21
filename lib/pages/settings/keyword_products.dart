import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';

class KeywordProducts extends StatefulWidget {
  const KeywordProducts({super.key});

  @override
  _KeywordProductsState createState() => _KeywordProductsState();
}

class _KeywordProductsState extends State<KeywordProducts> {
  late List<dynamic> myKeywordProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final pdsResponse = await ListKeywordProductsCall.call();
    var products = pdsResponse.jsonBody != null
        ? getJsonField(pdsResponse.jsonBody, r'''$''')
        : [];
    setState(() {
      myKeywordProducts = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: myKeywordProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return HomePageProductCardWidget(
            product: myKeywordProducts[index],
          );
        },
      ),
    );
  }
}
