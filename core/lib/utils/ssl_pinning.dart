import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class SSLPinning {
  static Future<IOClient> get sslPinningContext async {
    final sslCert = await rootBundle.load('certificates/certificates.cer');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback = (cert, host, port) => false;

    return IOClient(client);
  }
}
