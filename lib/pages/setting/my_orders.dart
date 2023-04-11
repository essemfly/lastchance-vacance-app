import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';

class MyOrdersWidget extends StatefulWidget {
  const MyOrdersWidget({Key? key}) : super(key: key);

  @override
  _MyOrdersWidgetState createState() => _MyOrdersWidgetState();
}

class _MyOrdersWidgetState extends State<MyOrdersWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<dynamic> myOrders = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final ordersResponse = await ListOrdersCall.call();
    var orders = ordersResponse.jsonBody != null
        ? getJsonField(ordersResponse.jsonBody, r'''$''')
        : [];
    setState(() {
      myOrders = orders;
    });
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Constants.black600,
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Constants.secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          '내가 구매요청한 바캉스',
          style: CustomTypography.subtitle2,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
          child: myOrders.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "구매 요청한 게시물이 없습니다",
                    style: CustomTypography.bodyText1,
                    textAlign: TextAlign.left,
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: myOrders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HomePageProductCardWidget(
                            product: myOrders[index],
                          );
                        },
                      ),
                    )
                  ],
                )),
    );
  }
}
