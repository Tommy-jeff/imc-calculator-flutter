
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Calculos{

  static double calculoImc(String altura, String peso){
    String formatedValues(String value){
      String formated = value.replaceAll(',', '.');
      return formated;
    }

    double alturaCalc = double.parse(formatedValues(altura));
    double pesoCalc = double.parse(formatedValues(peso));

    double calc = pesoCalc / (alturaCalc * alturaCalc) ;
    return calc;
  }


}