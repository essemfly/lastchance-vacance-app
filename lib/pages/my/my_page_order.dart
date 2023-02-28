import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handover_app/constants.dart';

import '../product/product_detail.dart';

Widget myPageOrders(BuildContext context) {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: Constants.primaryBackground,
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsWidget(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Constants.secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x20000000),
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2669&q=80',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Text(
                              'Inspector Name',
                              style: CustomTypography.subtitle1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                            child: Text(
                              'Title',
                              style: CustomTypography.bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      color: Constants.primaryColor,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsWidget(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Constants.secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x20000000),
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1554774853-719586f82d77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTJ8fHNlcnZpY2UlMjB3b3JrZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Text(
                              'Inspector Name',
                              style: CustomTypography.subtitle1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                            child: Text(
                              'Title',
                              style: CustomTypography.bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.motion_photos_off,
                      color: Constants.secondaryText,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsWidget(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Constants.secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x20000000),
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1529701870190-9ae4010fd124?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTZ8fHNlcnZpY2UlMjB3b3JrZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Text(
                              'Inspector Name',
                              style: CustomTypography.subtitle1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                            child: Text(
                              'Title',
                              style: CustomTypography.bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      color: Constants.primaryColor,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
