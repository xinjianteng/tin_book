import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// 缓存图片
Widget netImageCached(String? path, {
  double width = 48,
  double height = 48,
  double radius = 0,
  EdgeInsetsGeometry? margin,
}) {
  return CachedNetworkImage(
    imageUrl: path ?? "",
    imageBuilder: (context, imageProvider) =>
        Container(
          height: height,
          width: width,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
            ),
          ),
        ),
    placeholder: (context, url) {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          value: null,
        ),
      );
    },
    errorWidget: (context, url, error) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error),
            SizedBox(height: 4),
            Text('加载图片出错'),
          ],
        ),
      );
    },
  );
}



Widget netImageCircleCached(String url, {
  double radius = 50,
  EdgeInsetsGeometry? margin,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) =>
        CircleAvatar(
          backgroundColor: Colors.amber,
          radius: radius.r,
        ),
    imageBuilder: (context, image) =>
        CircleAvatar(
          backgroundImage: image,
          radius: radius.r,
        ),
  );
}


//
// Color getDominantColorFromImage(Uint8List imageData) {
//   final image = img.decodeImage(imageData)!;
//   final width = image.width;
//   final height = image.height;
//   int rSum = 0, gSum = 0, bSum = 0;
//
//   for (var x = 0; x < width; x++) {
//     for (var y = 0; y < height; y++) {
//       final pixel = image.getPixel(x, y);
//       rSum += img.getRed(pixel);
//       gSum += img.getGreen(pixel);
//       bSum += img.getBlue(pixel);
//     }
//   }
//
//   final totalPixels = width * height;
//   final averageR = rSum ~/ totalPixels;
//   final averageG = gSum ~/ totalPixels;
//   final averageB = bSum ~/ totalPixels;
//
//   return Color.fromRGBO(averageR, averageG, averageB, 1.0);
// }
//
// // 使用示例
// Future<Color> fetchDominantColor(String imageUrl) async {
//   final response = await http.get(Uri.parse(imageUrl));
//   if (response.statusCode == 200) {
//     return getDominantColorFromImage(response.bodyBytes);
//   } else {
//     throw Exception('Failed to load image');
//   }
// }