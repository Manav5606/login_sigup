import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DynamicLinkHelper {
  static Future<String> generateLinkForPayment(String transactionID) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://trusterapps.page.link/paymentReturnUrl?TransactionId=$transactionID"),
      uriPrefix: "https://trusterapps.page.link",
      androidParameters: AndroidParameters(
        packageName: packageInfo.packageName,
      ),
      iosParameters: IOSParameters(
        bundleId: packageInfo.packageName,
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.unguessable,
    );
    // print(dynamicLink.toString());
    print(dynamicLink.shortUrl.toString());
    return dynamicLink.shortUrl.toString();
  }
  static Future<String> generateLinkForQR(String transactionID) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://trusterapps.page.link/qrLink?TransactionId=$transactionID"),
      uriPrefix: "https://trusterapps.page.link",
      androidParameters: AndroidParameters(
        packageName: packageInfo.packageName,
      ),
      iosParameters: IOSParameters(
        bundleId: packageInfo.packageName,
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.unguessable,
    );
    // print(dynamicLink.toString());
    print(dynamicLink.shortUrl.toString());
    return dynamicLink.shortUrl.toString();
  }
}
