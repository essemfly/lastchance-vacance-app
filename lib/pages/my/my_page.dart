import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handover_app/components/flutter_flow_icon_button.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
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
  late List<dynamic> myLikes = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final likesResponse = await ListLikeProductsCall.call();
    var likes = likesResponse.jsonBody != null
        ? getJsonField(likesResponse.jsonBody, r'''$''')
        : [];
    setState(() {
      myLikes = likes;
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
      backgroundColor: Constants.primaryBackground,
      appBar: AppBar(
        backgroundColor: Constants.secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          '내가 좋아한 바캉스',
          textAlign: TextAlign.center,
          style: CustomTypography.subtitle2,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
          child: myLikes.length == 0
              ? Text("좋아요를 누른 게시물이 없습니다", style: CustomTypography.title3)
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: myLikes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HomePageProductCardWidget(
                            product: myLikes[index],
                          );
                        },
                      ),
                    )
                  ],
                )),
    );
  }
}
