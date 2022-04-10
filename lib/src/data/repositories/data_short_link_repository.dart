import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shortly/src/data/constants.dart';
import 'package:shortly/src/data/exceptions/duplicate_link_exception.dart';
import 'package:shortly/src/domain/entities/short_link.dart';
import 'package:shortly/src/domain/repositories/short_link_repository.dart';
import 'package:http/http.dart' as http;

class DataShortLinkRepository implements ShortLinkRepository {
  static final _instance = DataShortLinkRepository._internal();
  DataShortLinkRepository._internal();
  factory DataShortLinkRepository() => _instance;

  StreamController<List<ShortLink>> _streamController =
      StreamController.broadcast();

  List<ShortLink> _shortLinks = [];

  var header = {
    "Access-Control_Allow_Origin": "*",
    "Content-Type": "application/json",
  };

  @override
  Future<void> addShortLinkToHistoryList(String path) async {
    try {
      List<String> shortLinkIds = [];

      Response response;
      var url = Uri.parse(baseUrl + path);

      response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<ShortLink> shortLinks = [];

        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = [map['result']];

        for (int i = 0; i < _shortLinks.length; i++) {
          shortLinkIds.add(_shortLinks[i].id);
        }

        if (data.isNotEmpty) {
          data.map((shortLink) {
            ShortLink addedLink = ShortLink.fromJson(shortLink);
            if (!shortLinkIds.contains(addedLink.id)) {
              shortLinks.add(addedLink);
            }
          }).toList();

          _shortLinks.addAll(shortLinks);

          _streamController.add(_shortLinks);
        } else {
          throw Exception(response.statusCode);
        }
      }
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Stream<List<ShortLink>> getShortLinksFromHistory() {
    _streamController.add(_shortLinks);

    return _streamController.stream;
  }

  @override
  Future<void> removeShortLinkFromHistory(String shortLinkId) async {
    int index =
        _shortLinks.indexWhere((shortLink) => shortLink.id == shortLinkId);
    _shortLinks.removeAt(index);
    _streamController.add(_shortLinks);
  }
}
