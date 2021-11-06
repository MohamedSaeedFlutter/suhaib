import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareLogic{
  static void onShare(
      BuildContext context ,{String text , List<String> filePaths})
  async {
    if (filePaths != null) {
      await Share.shareFiles(filePaths,
        text: text,
        subject: "موسوعة صهيب الرقمية",
      );
    } else {
      await Share.share(text,
        subject: "موسوعة صهيب الرقمية",
      );
    }
  }

}