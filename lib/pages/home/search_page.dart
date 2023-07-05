import 'package:flutter/material.dart';
import 'package:handover_app/components/flutter_flow_widgets.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/home/home_product_card.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  final FocusNode _focusNode = FocusNode();

  static const pageSize = 30;
  int totalNumProducts = 0;
  bool _isEventLogged = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isEventLogged) {
      logPageView('Search Page');
      _isEventLogged = true;
    }
  }

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
      final totalItems =
          getJsonField(newItemsResponse.jsonBody, r'''$.totalCnt''');
      final newItems = totalItems > 0
          ? getJsonField(
              newItemsResponse.jsonBody,
              r'''$.products''',
            ).toList()
          : [];

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

  Future<void> _fetchNewKeyword() async {
    _pagingController.refresh();
    _fetchPage(0);
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
          focusNode: _focusNode,
          onFieldSubmitted: (value) {
            _fetchNewKeyword();
          },
          decoration: InputDecoration(
            labelStyle: CustomTypography.bodyText1.override(
              fontFamily: 'Urbanist',
              color: Constants.grayIcon,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0x00000000),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(
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
                _fetchNewKeyword();
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
                borderSide: const BorderSide(
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
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
      ),
    );
  }
}
