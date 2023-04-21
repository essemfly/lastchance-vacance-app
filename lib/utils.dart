import 'package:flutter/material.dart';
import 'package:handover_app/constants.dart';
import 'package:json_path/json_path.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:amplitude_flutter/amplitude.dart';

dynamic getJsonField(
  dynamic response,
  String jsonPath, [
  bool isForList = false,
]) {
  final field = JsonPath(jsonPath).read(response);
  if (field.isEmpty) {
    return null;
  }
  if (field.length > 1) {
    return field.map((f) => f.value).toList();
  }
  final value = field.first.value;
  return isForList && value is! Iterable ? [value] : value;
}

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

String dateTimeFormat(String format, DateTime? dateTime, {String? locale}) {
  if (dateTime == null) {
    return '';
  }
  if (format == 'relative') {
    return timeago.format(dateTime, locale: locale);
  }
  return DateFormat(format).format(dateTime);
}

Future launchURL(String url) async {
  var uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } catch (e) {
    throw 'Could not launch $uri: $e';
  }
}

extension FFStringExt on String {
  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;
}

Widget ConvertDateFormat(String format, DateTime? dateTime) {
  if (dateTime == null) {
    return Text('');
  }
  if (format == 'relative') {
    return Text(timeago.format(dateTime, locale: "ko_KR"));
  }
  return Text(
    DateFormat(format).format(dateTime),
    style: CustomTypography.bodyText1,
  );
}

String currencyFormat(int price) {
  final formatCurrency = NumberFormat.simpleCurrency(
    locale: 'ko_KR',
    name: '',
    decimalDigits: 0,
  );

  return formatCurrency.format(price);
}

Future<void> logPageView(String pageName) async {
  final Amplitude amplitude = Amplitude.getInstance();
  amplitude.logEvent('page_view', eventProperties: {'page_name': pageName});
}
