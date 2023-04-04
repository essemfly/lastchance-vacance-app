import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handover_app/components/flutter_flow_icon_button.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
import 'package:handover_app/pages/product/product_detail.dart';
import 'package:handover_app/pages/setting/my_likes.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';
import 'package:provider/provider.dart';

class SettingsPageWidget extends StatefulWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  _SettingsPageWidgetState createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
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
          '나의 바캉스',
          textAlign: TextAlign.center,
          style: CustomTypography.subtitle2,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Mobile',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
          ),
          ListTile(
            title: Text('My Likes'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyLikesWidget(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('My Orders'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyLikesWidget(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
