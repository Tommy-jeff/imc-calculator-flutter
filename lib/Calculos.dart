
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Calculos{

  static double calculoImc(int  altura, int peso){
    double calc = peso/(altura * altura);
    log("calculo result = $calc");
    return calc;
  }

}