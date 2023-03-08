import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';

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
          child: Text("등록한 키워드",
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
                    height: 200,
                    child: ListView.builder(
                      itemCount: myKeywords.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.primaryColor,
                          ),
                          onPressed: () {
                            _removeKeyword(
                                getJsonField(myKeywords[index], r'''$.id'''));
                          },
                          child: Text(getJsonField(
                              myKeywords[index], r'''$.keyword''')),
                        );
                      },
                    ),
                  )),
      ],
    );
  }
}
