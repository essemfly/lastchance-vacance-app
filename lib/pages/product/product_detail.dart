import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:handover_app/components/flutter_flow_icon_button.dart';
import 'package:handover_app/components/flutter_flow_widgets.dart';
import 'package:handover_app/utils.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/product/order_request.dart';
import 'package:handover_app/repository/api_calls.dart';

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
  bool isDirectProduct = false;
  bool isLiked = false;
  List<dynamic> imageUrls = [];
  bool _isEventLogged = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isEventLogged) {
      logPageView('Product Detail Page');
      _isEventLogged = true;
    }
  }

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

    var uploadType =
        getJsonField(productDetailResponse.jsonBody, r'''$.upload_type''');
    if (uploadType == "DIRECT") {
      isDirectProduct = true;
    } else {
      isDirectProduct = false;
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
      isDirectProduct = isDirectProduct;
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

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: Constants.primaryColor,
          ),
        ),
      );
    }

    return Scaffold(
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 320,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBE2E7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0, 0),
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
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(url),
                                          fit: BoxFit.cover,
                                        ),
                                        boxShadow: const [
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
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
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: const Color(0x3A000000),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              buttonSize: 46,
                                              icon: const Icon(
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
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
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
                            color: const Color(0xFF8B97A2),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            "${currencyFormat(getJsonField(
                                  product,
                                  r'''$.discounted_price''',
                                ))}원",
                            textAlign: TextAlign.start,
                            style: CustomTypography.title2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                              child: Text(
                                getJsonField(
                                  product,
                                  r'''$.description''',
                                ).toString(),
                                style: CustomTypography.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: const Color(0xFF8B97A2),
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
            decoration: const BoxDecoration(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 30),
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
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                          onPressed: () {
                            _likeProduct();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              logPageView("Order Direct Page");
                              launchURL(getJsonField(
                                product,
                                r'''$.outlink''',
                              ));
                            },
                            text: '직접 연락하기',
                            options: FFButtonOptions(
                              width: 130,
                              height: 50,
                              color: Constants.tertiaryColor,
                              textStyle: CustomTypography.subtitle2.override(
                                fontFamily: 'Lexend Deca',
                                color: Constants.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              elevation: 3,
                              borderSide: const BorderSide(
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
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: FFButtonWidget(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderRequestWidget(
                                      propertyRef: getJsonField(
                                        product,
                                        r'''$.id''',
                                      ),
                                    ),
                                  ),
                                );
                              },
                              text: '구매 요청하기',
                              options: FFButtonOptions(
                                width: 130,
                                height: 50,
                                color: Constants.primaryColor,
                                textStyle: CustomTypography.subtitle2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                elevation: 3,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              )),
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
