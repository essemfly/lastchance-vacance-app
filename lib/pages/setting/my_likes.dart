import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';

class MyLikesWidget extends StatefulWidget {
  const MyLikesWidget({Key? key}) : super(key: key);

  @override
  _MyLikesWidgetState createState() => _MyLikesWidgetState();
}

class _MyLikesWidgetState extends State<MyLikesWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<dynamic> myLikes = [];
  bool _isEventLogged = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isEventLogged) {
      logPageView('My Likes Page');
      _isEventLogged = true;
    }
  }

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
      appBar: AppBar(
        leading: IconButton(
          color: Constants.black600,
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Constants.secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          '내가 좋아한 바캉스',
          style: CustomTypography.subtitle2,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
          child: myLikes.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "좋아한 게시물이 없습니다",
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
                )),
    );
  }
}
