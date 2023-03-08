import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:handover_app/components/flutter_flow_icon_button.dart';
import 'package:handover_app/components/flutter_flow_widgets.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:handover_app/constants.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({
    Key? key,
    this.propertyRef,
  }) : super(key: key);

  final String? propertyRef;

  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic product;
  bool isLiked = false;
  List<dynamic> imageUrls = [];
  final _controller = ScreenshotController();

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    final productDetailResponse =
        await ProductDetailCall.call(productId: widget.propertyRef!);
    var productResp =
        getJsonField(productDetailResponse.jsonBody, r'''$.product''');
    var images =
        getJsonField(productDetailResponse.jsonBody, r'''$.product.images''');
    if (images == null || images.length == 0) {
      images = ["https://picsum.photos/seed/1/300"];
    }
    var userLike =
        getJsonField(productDetailResponse.jsonBody, r'''$.userLike''');
    if (userLike != null) {
      isLiked = getJsonField(userLike, r'''$.is_liked''');
    } else {
      isLiked = false;
    }

    setState(() {
      product = productResp;
      imageUrls = images;
      isLiked = isLiked;
    });
  }

  Future<void> _likeProduct() async {
    final likeProductResponse =
        await LikeProductCall.call(productId: widget.propertyRef!);
    isLiked = getJsonField(likeProductResponse.jsonBody, r'''$.is_liked''');
    setState(() {
      isLiked = isLiked;
    });
  }

  Future<void> _shareScreenshot() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    final String localPath =
        '${directory!.path}/${DateTime.now().toIso8601String()}.png';

    await _controller.captureAndSave(localPath);

    await Future.delayed(Duration(seconds: 1));

    await FlutterShare.shareFile(
        title: 'Compartilhar comprovante',
        filePath: localPath,
        fileType: 'image/png');
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            ),
          )
        : Scaffold(
            key: scaffoldKey,
            backgroundColor: Constants.secondaryBackground,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 320,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDBE2E7),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          aspectRatio: 1.0,
                                          onPageChanged: (index, reason) {
                                            setState(() {});
                                          },
                                        ),
                                        items: imageUrls.map<Widget>((url) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(url),
                                                fit: BoxFit.cover,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0.0, 1.0),
                                                  blurRadius: 6.0,
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 16, 16, 16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  color: Color(0x3A000000),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderRadius: 30,
                                                    buttonSize: 46,
                                                    icon: Icon(
                                                      Icons.arrow_back_rounded,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Text(
                                getJsonField(
                                  product,
                                  r'''$.name''',
                                ).toString(),
                                style: CustomTypography.title1,
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Text(
                                getJsonField(
                                  product,
                                  r'''$.written_addr''',
                                ).toString(),
                                style: CustomTypography.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF8B97A2),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              )),
                              ConvertDateFormat(
                                  "relative",
                                  DateTime.parse(
                                    getJsonField(product, r'''$.written_at''')
                                        .toString(),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  currencyFormat(getJsonField(
                                        product,
                                        r'''$.discounted_price''',
                                      )) +
                                      "원",
                                  textAlign: TextAlign.start,
                                  style: CustomTypography.title2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '상세 설명',
                                  style: CustomTypography.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Constants.primaryText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 24),
                                    child: Text(
                                      getJsonField(
                                        product,
                                        r'''$.description''',
                                      ).toString(),
                                      style:
                                          CustomTypography.bodyText2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryText,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x55000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 50,
                                fillColor: Constants.tertiaryColor,
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Colors.red : Colors.grey,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _likeProduct();
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 50,
                                fillColor: Constants.tertiaryColor,
                                icon: Icon(Icons.share),
                                onPressed: () {
                                  _shareScreenshot();
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await launchURL(Constants.openChatRoomUrl);
                                  },
                                  text: '양도 요청하기',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 50,
                                    color: Constants.tertiaryColor,
                                    textStyle:
                                        CustomTypography.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Constants.secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    elevation: 3,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    // Action Direct
                                    await launchURL(getJsonField(
                                      product,
                                      r'''$.outlink''',
                                    ));
                                  },
                                  text: '직접 연락하기',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 50,
                                    color: Constants.primaryColor,
                                    textStyle:
                                        CustomTypography.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    elevation: 3,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
