import 'package:handover_app/components/flutter_flow_widgets.dart';
import 'package:handover_app/constants.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
import 'package:handover_app/pages/home/search_properties_widget.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../utils.dart';

class HomePageMAINWidget extends StatefulWidget {
  const HomePageMAINWidget({Key? key}) : super(key: key);

  @override
  _HomePageMAINWidgetState createState() => _HomePageMAINWidgetState();
}

class _HomePageMAINWidgetState extends State<HomePageMAINWidget> {
  Completer<ApiCallResponse>? _apiRequestCompleter;
  TextEditingController? textController;
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0);

  int pageNum = 0;
  final int pageSize = 30;
  int totalNumProducts = 1795;
  String searchQuery = '';

  @override
  void initState() {
    textController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItemsResponse = await ProductsListCall.call(
          page: pageKey, size: pageSize, search: searchQuery);
      final newItems = getJsonField(
        newItemsResponse.jsonBody,
        r'''$.products''',
      ).toList();

      final totalItems = getJsonField(newItemsResponse, r'''$.totalCnt''');
      setState(() {
        totalNumProducts = totalItems;
      });

      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    textController?.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: GlobalKey<ScaffoldState>(),
      backgroundColor: Constants.primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: Constants.dark600,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x39000000),
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 50, 24, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Last Chance Vacance',
                            style: CustomTypography.title1.override(
                              fontFamily: 'Urbanist',
                              color: Constants.tertiaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                          child: Text(
                            '다른 사람들이 못가게 된 \n호텔, 펜션, 리조트 등의 숙박권을  양도받아\n바캉스를 떠나요',
                            style: CustomTypography.subtitle2.override(
                              fontFamily: 'Urbanist',
                              color: Constants.grayIcon,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Constants.primaryBackground,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                              child: TextFormField(
                                controller: textController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: '지역, 호텔, 리조트 명',
                                  labelStyle:
                                      CustomTypography.bodyText1.override(
                                    fontFamily: 'Urbanist',
                                    color: Constants.grayIcon,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_sharp,
                                    color: Constants.grayIcon,
                                  ),
                                ),
                                style: CustomTypography.bodyText1.override(
                                  fontFamily: 'Urbanist',
                                  color: Color(0xFF5E616A),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SearchPropertiesWidget(
                                      searchTerm: textController!.text,
                                    ),
                                  ),
                                );
                              },
                              text: '검색',
                              options: FFButtonOptions(
                                width: 100,
                                height: 40,
                                color: Constants.primaryColor,
                                textStyle: CustomTypography.subtitle2.override(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                ),
                                elevation: 2,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                            child: Text(
                              '현재 $totalNumProducts개의 게시물이 양도받을 주인을 기다리고 있습니다.',
                              textAlign: TextAlign.center,
                              style: CustomTypography.bodyText2.override(
                                fontFamily: 'Urbanist',
                                color: Constants.secondaryColor,
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              child: RefreshIndicator(
                onRefresh: () => Future.sync(() => _pagingController.refresh()),
                child: PagedListView(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<dynamic>(
                      itemBuilder: (context, item, index) =>
                          HomePageProductCardWidget(
                        product: item,
                      ),
                    )),
              ),
            )
            //   child: FutureBuilder<ApiCallResponse>(
            //     future: (_apiRequestCompleter ??= Completer<ApiCallResponse>()
            //           ..complete(ProductsListCall.call()))
            //         .future,
            //     builder: (context, snapshot) {
            //       // Customize what your widget looks like when it's loading.
            //       if (!snapshot.hasData) {
            //         return Center(
            //           child: SizedBox(
            //             width: 50,
            //             height: 50,
            //             child: CircularProgressIndicator(
            //               color: Constants.primaryColor,
            //             ),
            //           ),
            //         );
            //       }
            //       final listViewProductsListResponse = snapshot.data!;
            //       return Builder(
            //         builder: (context) {
            //           final productsList = getJsonField(
            //             listViewProductsListResponse.jsonBody,
            //             r'''$.products''',
            //           ).toList();

            //           return RefreshIndicator(
            //             onRefresh: () async {
            //               setState(() => _apiRequestCompleter = null);
            //               await waitForApiRequestCompleter();
            //             },
            //             child: ListView.builder(
            //               padding: EdgeInsets.zero,
            //               primary: false,
            //               shrinkWrap: true,
            //               scrollDirection: Axis.vertical,
            //               itemCount: productsList.length,
            //               itemBuilder: (context, productsListIndex) {
            //                 final productsListItem =
            //                     productsList[productsListIndex];
            //                 var defaultImage = getJsonField(
            //                   productsListItem,
            //                   r'''$.default_image''',
            //                 );

            //                 if (defaultImage == null || defaultImage == "") {
            //                   defaultImage = 'https://picsum.photos/seed/1/300';
            //                 }
            //                 return HomePageProductCardWidget(
            //                   product: productsListItem,
            //                 );
            //               },
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future waitForApiRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
