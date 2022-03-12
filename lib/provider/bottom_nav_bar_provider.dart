import 'package:flutter/material.dart';

class BNBProvider extends ChangeNotifier{
  int bnbIndex = 0;

  void navigate({required int index}){
    bnbIndex = index;
    notifyListeners();
  }

}