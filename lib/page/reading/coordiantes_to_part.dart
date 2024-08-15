
// 此Dart函数`coordinatesToPart`通过输入x和y坐标（假设在0-1范围内），
// 将坐标平面划分为9个等分区域，并返回0-8的区域编号。
// 函数依据x和y的大小与0.33、0.66的比较结果来确定并返回对应的区域编号。

int coordinatesToPart(double x, double y) {
  if (x < 0.33) {
    if (y < 0.33) {
      return 0;
    } else if (y < 0.66) {
      return 3;
    } else {
      return 6;
    }
  } else if (x < 0.66) {
    if (y < 0.33) {
      return 1;
    } else if (y < 0.66) {
      return 4;
    } else {
      return 7;
    }
  } else {
    if (y < 0.33) {
      return 2;
    } else if (y < 0.66) {
      return 5;
    } else {
      return 8;
    }
  }
}
