import 'package:flutter/widgets.dart';
import 'package:project_1/core/utils/function/custom_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomer({
  required BuildContext context,
  required String? url,
  String? errMessage,
}) async {
  if (url != null) {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      customSnackBar(context, errMessage!);
    }
  }
}
