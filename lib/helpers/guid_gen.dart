// import 'dart:math';
//
// class GUIDGen {
//   static int generate() {
//     Random random = Random(DateTime.now().millisecond);
//
//     const String hexDigits = '0123456789';
//     final List<String> uuid = List.filled(10, '', growable: true);
//
//     for (int i = 0; i < 10; i++) {
//       final int hexPos = random.nextInt(10);
//       uuid[i] = (hexDigits.substring(hexPos, hexPos + 1));
//     }
//
//     final StringBuffer buffer = StringBuffer();
//     buffer.writeAll(uuid);
//     return int.parse(buffer.toString());
//   }
// }

import 'dart:math';

class GUIDGen {
  static int generate() {
    Random random = Random(DateTime.now().millisecond);

    final int maxInt32 = pow(2, 31).toInt(); // Maximum value of a 32-bit integer

    int id = random.nextInt(maxInt32);
    return id;
  }
}