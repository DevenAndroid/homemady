
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

Future<String?> getDeepLinkUrl({required Map<String, dynamic> parameters}) async {
  final item = BranchContentMetaData();
  for (var element in parameters.entries) {
    item.addCustomMetadata(element.key, element.value);
  }
  final sharingStoreId = await generateLink(
      BranchUniversalObject(
          canonicalIdentifier: 'flutter/branch',
          contentMetadata: item,
          publiclyIndex: true,
          locallyIndex: true,
          expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch),
      BranchLinkProperties(
          channel: 'facebook', feature: 'sharing', stage: 'new share', campaign: 'campaign', tags: ['one', 'two', 'three']));
  return sharingStoreId;
}



Future<String?> generateLink(BranchUniversalObject buo, BranchLinkProperties lp) async {
  BranchResponse response = await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
  if (response.success) {
    return response.result;
  }
  return null;
}