import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:tin_book/common/utils/utils.dart';

import '../../utils/get_path/get_base_path.dart';

class Server {
  static final Server _singleton = Server._internal();

  factory Server() {
    return _singleton;
  }

  Server._internal();

  HttpServer? _server;

  Future start() async {
    var handler = const shelf.Pipeline()
        .addMiddleware(shelf.logRequests())
        .addHandler(_handleRequests);

    _server = await io.serve(handler, 'localhost', 0);

    logPrint(
      "Server: Serving at http://${_server?.address.host}:${_server?.port}'",
      type: LoggerType.info,
    );
  }

  int get port {
    return _server!.port;
  }

  Future stop() async {
    await _server?.close(force: true);
    logPrint('Server: Server stopped');
  }

  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  File? _tempFile;

  set tempFile(File file) {
    _tempFile = file;
  }

  Future<shelf.Response> _handleRequests(shelf.Request request) async {
    final uriPath = request.requestedUri.path;
    logPrint('Server: Request for $uriPath');

    if (Uri.decodeComponent(uriPath) == _tempFile?.path) {
      return shelf.Response.ok(
        _tempFile?.openRead(),
        headers: {
          'Content-Type': 'application/epub+zip',
          'Access-Control-Allow-Origin': '*',
        },
      );
    }

    if (uriPath.startsWith('/book/')) {
      return _handleBookRequest(request);
    } else if (uriPath.startsWith('/js/')) {
      String content = await _loadAsset('assets/js/${path.basename(uriPath)}');
      return shelf.Response.ok(
        content,
        headers: {'Content-Type': 'application/javascript'},
      );
    } else if (uriPath.startsWith('/fonts/')) {
      Directory fontDir = getFontDir();
      final file = File(
          '${fontDir.path}/${path.basename(Uri.decodeComponent(uriPath))}');
      if (!file.existsSync()) {
        return shelf.Response.notFound('Font not found');
      }
      return shelf.Response.ok(
        file.openRead(),
        headers: {
          'Content-Type': 'font/opentype',
          'Access-Control-Allow-Origin': '*',
          'cache-control': 'public, max-age=31536000',
        },
      );
    } else if (uriPath.startsWith('/foliate-js/')) {
      if (uriPath.endsWith('.epub')) {
        final file =
            await rootBundle.load('assets/foliate-js/${uriPath.substring(12)}');
        return shelf.Response.ok(
          file.buffer.asUint8List(),
          headers: {
            'Content-Type': 'application/epub+zip',
            'Access-Control-Allow-Origin': '*', // Add this line
          },
        );
      }
      String content =
          await _loadAsset('assets/foliate-js/${uriPath.substring(12)}');
      String contentType =
          uriPath.endsWith('.html') ? 'text/html' : 'application/javascript';
      return shelf.Response.ok(
        content,
        headers: {
          'Content-Type': contentType,
        },
      );
    } else {
      return shelf.Response.ok(
        'Request for "${request.url}"',
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      );
    }
  }

  shelf.Response _handleBookRequest(shelf.Request request) {
    final bookPath = Uri.decodeComponent(request.url.path.substring(5));
    final file = File(bookPath);
    logPrint('Server: Request for book: $bookPath');
    if (!file.existsSync()) {
      return shelf.Response.notFound('Book not found');
    }
    final headers = {
      'Content-Type': 'application/epub+zip',
      'Access-Control-Allow-Origin': '*',
    };
    return shelf.Response.ok(file.openRead(), headers: headers);
  }
}
