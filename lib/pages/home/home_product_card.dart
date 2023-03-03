import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/product/product_detail.dart';
import 'package:handover_app/utils.dart';

class HomePageProductCardWidget extends StatelessWidget {
  final dynamic product;

  HomePageProductCardWidget({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    var defaultImage = getJsonField(
      product,
      r'''$.default_image''',
    );

    if (defaultImage == null || defaultImage == "") {
      defaultImage = 'https://picsum.photos/seed/1/300';
    }
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Constants.secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x32000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsWidget(
                  propertyRef: getJsonField(
                    product,
                    r'''$.id''',
                  ),
                ),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Hero(
                tag: getJsonField(
                  product,
                  r'''$.id''',
                ),
                transitionOnUserGestures: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: defaultImage,
                    width: double.infinity,
                    height: 190,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        getJsonField(
                          product,
                          r'''$.name''',
                        ).toString().maybeHandleOverflow(
                              maxChars: 36,
                              replacement: '…',
                            ),
                        style: CustomTypography.title3,
                      ),
                    ),
                    Text(
                      currencyFormat(getJsonField(
                            product,
                            r'''$.discounted_price''',
                          )) +
                          '원',
                      style: CustomTypography.title3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        getJsonField(
                          product,
                          r'''$.written_addr''',
                        ).toString().maybeHandleOverflow(
                              maxChars: 90,
                              replacement: '…',
                            ),
                        style: CustomTypography.bodyText1,
                      ),
                    ),
                    ConvertDateFormat(
                        "relative",
                        DateTime.parse(
                          getJsonField(
                            product,
                            r'''$.written_at''',
                          ).toString(),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
