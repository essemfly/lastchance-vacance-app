import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KeywordManager extends StatefulWidget {
  const KeywordManager({super.key});

  @override
  _KeywordManagerState createState() => _KeywordManagerState();
}

class _KeywordManagerState extends State<KeywordManager> {
  final TextEditingController textEditingController = TextEditingController();
  late List<dynamic> myKeywords = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final keywordsResponse = await ListKeywordsCall.call();
    var keywords = keywordsResponse.jsonBody != null
        ? getJsonField(keywordsResponse.jsonBody, r'''$''').toList()
        : [];
    setState(() {
      myKeywords = keywords;
    });
  }

  Future<void> _addKeyword(String keyword) async {
    if (keyword.isEmpty || keyword == "") {
      Fluttertoast.showToast(
          msg: "키워드가 비어있습니다",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Constants.primaryColor,
          textColor: Constants.primaryBtnText,
          fontSize: 16.0);
      return;
    }

    if (myKeywords.length >= 5) {
      Fluttertoast.showToast(
          msg: "키워드는 최대 5개까지 등록할 수 있습니다",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Constants.primaryColor,
          textColor: Constants.primaryBtnText,
          fontSize: 16.0);
      return;
    }

    final addKeywordResponse = await InsertKeywordCall.call(keyword: keyword);
    if (addKeywordResponse.statusCode == 200) {
      _fetchData();
    }
  }

  Future<void> _removeKeyword(String keywordID) async {
    final removeKeywordResponse =
        await RemoveKeywordCall.call(keywordId: keywordID);
    if (removeKeywordResponse.statusCode == 200) {
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (value) {
                    if (value != "") {
                      String text = textEditingController.text;
                      _addKeyword(text);
                      textEditingController.text = "";
                    }
                  },
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: '알림 받을 키워드를 입력하세요',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    String text = textEditingController.text;
                    _addKeyword(text);
                    textEditingController.text = "";
                  },
                  child: Text('추가'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                  )),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("등록한 키워드 ${myKeywords.length}/5",
              textAlign: TextAlign.left, style: CustomTypography.subtitle2),
        ),
        SafeArea(
            child: myKeywords.length == 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "등록된 키워드가 없습니다",
                      style: CustomTypography.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                  )
                : Container(
                    height: 150,
                    child: ListView.builder(
                      itemCount: myKeywords.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                            ),
                            onPressed: () {
                              _removeKeyword(
                                  getJsonField(myKeywords[index], r'''$.id'''));
                            },
                            child: Row(
                              children: [
                                Text(getJsonField(
                                    myKeywords[index], r'''$.keyword''')),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      _removeKeyword(getJsonField(
                                          myKeywords[index], r'''$.id'''));
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
      ],
    );
  }
}
