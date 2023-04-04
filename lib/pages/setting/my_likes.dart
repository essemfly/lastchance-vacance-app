import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handover_app/components/flutter_flow_icon_button.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
import 'package:handover_app/pages/product/product_detail.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';
import 'package:provider/provider.dart';

class MyLikesWidget extends StatefulWidget {
  const MyLikesWidget({Key? key}) : super(key: key);

  @override
  _MyLikesWidgetState createState() => _MyLikesWidgetState();
}

class _MyLikesWidgetState extends State<MyLikesWidget> {
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
    return SafeArea(
        child: myLikes.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "좋아요를 누른 게시물이 없습니다",
                  style: CustomTypography.bodyText1,
                  textAlign: TextAlign.left,
                ),
              )
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
              ));
  }
}
