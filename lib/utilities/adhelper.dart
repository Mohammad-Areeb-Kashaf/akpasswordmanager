import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  bool isRewardedAdReady = false;
  late RewardedAd _rewardedAd;

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9491478013048351/9451058031';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9491478013048351/6935934702';
    } else {
      throw UnsupportedError('unsupported Platform');
    }
  }

  loadRewardAd(BuildContext context) {
    RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: const AdRequest(keywords: ['games']),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _rewardedAd = ad;
            isRewardedAdReady = true;
            print('ad loaded');
            showRewardedAd(context);
          },
          onAdFailedToLoad: (rewardedAd) {
            isRewardedAdReady = false;
            Navigator.pop(context);
          },
        ));
  }

  showRewardedAd(BuildContext context) {
    _rewardedAd.show(
      onUserEarnedReward: (ad, item) {},
    );
    print('ad showed');
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {},
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          Navigator.pop(context);
        },
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          Navigator.pop(context);
        },
        onAdImpression: (RewardedAd ad) {});
  }
}
