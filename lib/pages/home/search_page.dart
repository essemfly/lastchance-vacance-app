import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handover_app/components/flutter_flow_icon_button.dart';
import 'package:handover_app/components/flutter_flow_widgets.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
import 'package:handover_app/pages/product/product_detail.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:handover_app/repository/api_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({
    Key? key,
    this.searchTerm,
  }) : super(key: key);

  final String? searchTerm;

  @override
  _SearchPageWidgetState createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  TextEditingController? textController;
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  static const pageSize = 30;
  int totalNumProducts = 0;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.searchTerm);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItemsResponse = await ProductsListCall.call(
          page: pageKey, size: pageSize, search: textController?.text ?? "");
      final newItems = getJsonField(
        newItemsResponse.jsonBody,
        r'''$.products''',
      ).toList();

      final totalItems =
          getJsonField(newItemsResponse.jsonBody, r'''$.totalCnt''');
      setState(() {
        totalNumProducts = totalItems;
      });

      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + pageSize;
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
      key: scaffoldKey,
      backgroundColor: Constants.primaryBackground,
      appBar: AppBar(
        backgroundColor: Constants.dark600,
        automaticallyImplyLeading: true,
        title: TextFormField(
          controller: textController,
          obscureText: false,
          decoration: InputDecoration(
            labelStyle: CustomTypography.bodyText1.override(
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
            color: Constants.tertiaryColor,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FFButtonWidget(
              onPressed: () {
                _fetchPage(2);
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
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
            child: RefreshIndicator(
              onRefresh: () async => _pagingController.refresh(),
              child: PagedListView(
                scrollDirection: Axis.vertical,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: (context, item, index) =>
                      HomePageProductCardWidget(
                    product: item,
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
