import 'package:ads/bannerads.dart';
import 'package:ads/interads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();


  runApp(MaterialApp(
    home: interads(),
  ));
}

