import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/setting/my_likes.dart';
import 'package:handover_app/pages/setting/my_orders.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsPageWidget extends StatefulWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  _SettingsPageWidgetState createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late dynamic user = {};
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  bool _isEventLogged = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isEventLogged) {
      logPageView('Settings Page');
      _isEventLogged = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final userResponse = await UserDeviceCall.get();
    var localUser = userResponse.jsonBody != null
        ? getJsonField(userResponse.jsonBody, r'''$''')
        : [];
    setState(() {
      user = localUser;
      _addressController.text = getJsonField(user, r'''$.address''');
      _mobileController.text = getJsonField(user, r'''$.mobile''');
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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _mobileController,
                    decoration: InputDecoration(
                      labelText: '전화번호',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await UserDeviceCall.update(
                        address: _addressController.text,
                        mobile: _mobileController.text,
                      );
                      Fluttertoast.showToast(
                          msg: "저장되었습니다",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Constants.primaryColor,
                          textColor: Constants.primaryBtnText,
                          fontSize: 16.0);
                    },
                    child: Text('저장'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                    )),
              ),
            ],
          ),
          Text(
            '구매 성사시에, 안내 및 양도 관련 문자를 드립니다',
            style: CustomTypography.subtitle2.override(
              fontFamily: 'Urbanist',
              color: Constants.grayIcon,
              fontWeight: FontWeight.w300,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: '주소',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await UserDeviceCall.update(
                        address: _addressController.text,
                        mobile: _mobileController.text,
                      );
                      Fluttertoast.showToast(
                          msg: "저장되었습니다",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Constants.primaryColor,
                          textColor: Constants.primaryBtnText,
                          fontSize: 16.0);
                    },
                    child: Text('저장'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                    )),
              ),
            ],
          ),
          Text(
            '다른 분들의 양도 대행으로 부가수익을 얻을 수 있습니다',
            textAlign: TextAlign.left,
            style: CustomTypography.subtitle2.override(
              fontFamily: 'Urbanist',
              color: Constants.grayIcon,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 20.0),
          ListTile(
            title: Text('내가 좋아한 바캉스'),
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
            title: Text('내가 구매요청한 바캉스'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyOrdersWidget(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('오픈 채팅방 가기'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () async {
              await launchURL(Constants.openChatRoomUrl);
            },
          ),
        ],
      ),
    );
  }
}
