import 'dart:io';

import 'package:ads/bannerads.dart';
import 'package:ads/rewardads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class interads extends StatefulWidget {
  const interads({Key? key}) : super(key: key);

  @override
  State<interads> createState() => _interadsState();
}

class _interadsState extends State<interads> {
  int maxFailedLoadAttempts = 3;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();

  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd(int i) {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
if(i==1){
  
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return bannerad();
    },));
}
else if(i==2){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return rewardad();
    },));
      }
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        if(i==1){

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return bannerad();
          },));
          _createInterstitialAd();
        }
        else if(i==2){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return rewardad();
          },));
        }
        ad.dispose();

      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("InterstialAd"),),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            _showInterstitialAd(1);

          }, child: Text("BannerAd")),
          ElevatedButton(onPressed: () {
            _showInterstitialAd(2);
          }, child:  Text("Rewardad"))
        ],
      ),

    );
  }
}
