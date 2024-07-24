import 'package:ak_password_manager/utilities/adhelper.dart';
import 'package:flutter/material.dart';

class ShowRewardedAds extends StatefulWidget {
  const ShowRewardedAds({Key? key}) : super(key: key);

  @override
  _ShowRewardedAdsState createState() => _ShowRewardedAdsState();
}

class _ShowRewardedAdsState extends State<ShowRewardedAds> {
  @override
  Widget build(BuildContext context) {
    AdHelper().loadRewardAd(context);
    return const Scaffold();
  }
}
