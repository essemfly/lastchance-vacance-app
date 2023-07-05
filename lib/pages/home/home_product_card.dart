import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:handover_app/pages/product/product_detail.dart';
import 'package:handover_app/utils.dart';

class HomePageProductCardWidget extends StatelessWidget {
  final dynamic product;

  const HomePageProductCardWidget({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    var defaultImage = getJsonField(
      product,
      r'''$.default_image''',
    );

    if (defaultImage == null || defaultImage == "") {
      defaultImage = Constants.defaultImageUrl;
    }

    var statusRaw = getJsonField(
      product,
      r'''$.status''',
    );
    String status = "판매중";
    Color statusColor = Constants.primaryColor;
    if (statusRaw == "SALE") {
      statusRaw = '판매중';
    }
    if (statusRaw == "SOLDOUT") {
      statusRaw = '판매완료';
      statusColor = Constants.redApple;
    }
    if (statusRaw == "UNKNOWN") {
      statusRaw = '삭제됨';
      statusColor = Constants.secondaryColor;
    }

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Constants.secondaryBackground,
          boxShadow: const [
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
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
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
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          statusRaw,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
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
                      '${currencyFormat(getJsonField(
                            product,
                            r'''$.discounted_price''',
                          ))}원',
                      style: CustomTypography.title3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
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
