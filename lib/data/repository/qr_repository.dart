import 'dart:convert';
import 'dart:typed_data';

import 'package:qr_flutter/qr_flutter.dart';

class QRRepository {
  Future<String> generateQRCode(String data) async {
    final qrImage = QrImage(
      data: data,
      version: QrVersions.auto,
      size: 200.0,
    );

    
    final ByteData byteData = await qrImage.toByteData(format: QrImageFormat.png);
    final buffer = byteData.buffer.asUint8List();

    
    final base64String = base64Encode(buffer);

    return base64String;
  }
}