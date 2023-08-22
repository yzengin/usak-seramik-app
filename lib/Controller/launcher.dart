// ignore_for_file: deprecated_member_use
import 'package:url_launcher/url_launcher.dart';

void launchMapsUrl(double latitude, double longitude) async {
  final url = 'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void launchMail(String mail) async {
  final Uri emailLaunchUri = Uri(scheme: 'mailto', path: mail, query: encodeQueryParameters(<String, String>{'subject': 'Uşak Seramik'}));
  launchUrl(emailLaunchUri);
}

void launchPhone(String phone) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phone);
  await launchUrl(launchUri);
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
}
