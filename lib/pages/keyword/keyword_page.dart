import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/keyword/keyword_manager.dart';
import 'package:handover_app/pages/keyword/keyword_products.dart';
import 'package:handover_app/utils.dart';
import 'package:flutter/material.dart';

class KeywordsPageWidget extends StatefulWidget {
  const KeywordsPageWidget({Key? key}) : super(key: key);

  @override
  _KeywordsPageWidgetState createState() => _KeywordsPageWidgetState();
}

class _KeywordsPageWidgetState extends State<KeywordsPageWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isEventLogged = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isEventLogged) {
      logPageView('Keyword Page');
      _isEventLogged = true;
    }
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
            '알림 키워드 설정',
            style: CustomTypography.subtitle2,
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KeywordManager(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("알림 받은 상품",
                    textAlign: TextAlign.left,
                    style: CustomTypography.subtitle2),
              ),
              const KeywordProducts(),
            ],
          ),
        ));
  }
}
