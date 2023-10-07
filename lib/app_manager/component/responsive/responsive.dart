



import 'package:flutter/cupertino.dart';

class Responsive {


  // ypu can change width and height according to your UI need.

  static double smallScreenWidth=600;
  static double smallScreenHeight=600;

  static Size size(BuildContext context)=>MediaQuery.of(context).size;

  static bool isSmallScreen(BuildContext context)=>size(context).width<smallScreenWidth;
  static bool isSmallHeight(BuildContext context,{
    double? compareTo
  })=>size(context).height<(compareTo??smallScreenHeight);


  static double widthPercent(BuildContext context,{
    double? percentage=100
  })=>((size(context).width*(percentage??100))/100);

  static double heightPercent(BuildContext context,{
    double? percentage=100
  })=>((size(context).height*(percentage??100))/100);




}