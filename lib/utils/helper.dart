import 'package:imgprc/utils/enums.dart';

class Helper {
  static String getFilterName(FilterType type) {
    switch (type) {
      case FilterType.Normal:
        return "Normal";
        break;
      case FilterType.Grey:
        return "Grey";
        break;
      case FilterType.Negative:
        return "Negative";
        break;
      case FilterType.RedGreenBlue:
        return "RGB";
        break;
      case FilterType.Sepia:
        return "Sepia";
        break;
      case FilterType.Mirror:
        return "Mirror";
        break;
      case FilterType.Laplace:
        return "Laplace";
        break;

      case FilterType.GaussianBlue:
        return "Gaussin Blur";
        break;
      case FilterType.MedianBlur:
        return "Median Blur";
        break;
      default:
        return "";
    }
  }
}
