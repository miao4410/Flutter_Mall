import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'GlobalAppColors.dart';

///  Name:
///  Created by fitem on 2021/5/26 .
class GlobeAppText {
  /// 12sp的灰色50字体
  static final TextStyle gray50Text12 = TextStyle(
    fontSize: 12.sp,
    color: GlobeAppColors.primaryTextGary50,
  );

  /// 12sp的红色字体
  static final TextStyle blueText12 = TextStyle(
    fontSize: 12.sp,
    color: GlobeAppColors.primaryTextBlue,
    decoration: TextDecoration.none,
  );

  /// 14sp的灰色 90%字体
  static final TextStyle gray90Text14 = TextStyle(
    fontSize: 14.sp,
    color: GlobeAppColors.primaryTextGary90,
  );

}