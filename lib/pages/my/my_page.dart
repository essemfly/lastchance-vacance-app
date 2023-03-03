import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handover_app/components/flutter_flow_icon_button.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/my/my_page_like.dart';
import 'package:handover_app/pages/my/my_page_order.dart';
import 'package:handover_app/pages/product/product_detail.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';
import 'package:provider/provider.dart';

class MyTripsWidget extends StatefulWidget {
  const MyTripsWidget({Key? key}) : super(key: key);

  @override
  _MyTripsWidgetState createState() => _MyTripsWidgetState();
}

class _MyTripsWidgetState extends State<MyTripsWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> myLikes = [];
  List<dynamic> myOrders = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final likesResponse = await ListLikeProductsCall.call();
    var myLikesRaw = likesResponse.jsonBody == null
        ? getJsonField(likesResponse.jsonBody, r'''$''')
        : [];
    final ordersResponse = await ListOrdersCall.call();
    var myOrdersRaw = ordersResponse.jsonBody == null
        ? getJsonField(ordersResponse.jsonBody, r'''$''')
        : [];

    setState(() {
      myLikes = myLikesRaw;
      myOrders = myOrdersRaw;
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
      key: scaffoldKey,
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Constants.secondaryBackground,
        automaticallyImplyLeading: false,
        leading: Align(
          alignment: AlignmentDirectional(0, 0),
          child: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back,
              color: Constants.primaryText,
              size: 30,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          '나의 활동',
          textAlign: TextAlign.center,
          style: CustomTypography.subtitle2,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Constants.secondaryBackground,
                        unselectedLabelColor: Constants.secondaryColor,
                        labelStyle: CustomTypography.subtitle2.override(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.normal,
                        ),
                        indicatorColor: Constants.primaryBackground,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            text: '양도 예약 진행 상황',
                          ),
                          Tab(
                            text: '찜한 숙소',
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            myPageLikes(context, myLikes),
                            myPageOrders(context, myOrders),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
