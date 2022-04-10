import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/domain/entities/short_link.dart';
import 'package:shortly/src/domain/repositories/short_link_repository.dart';

class GetShortLinksFromHistoryList extends UseCase<List<ShortLink>, void> {
  final ShortLinkRepository _shortLinkRepository;
  final StreamController<List<ShortLink>> _controller;

  GetShortLinksFromHistoryList(
    this._shortLinkRepository,
  ) : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<ShortLink>?>> buildUseCaseStream(void params) async {
    try {
      _shortLinkRepository
          .getShortLinksFromHistory()
          .listen((List<ShortLink> contacts) {
        if (!_controller.isClosed) _controller.add(contacts);
      });
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      _controller.addError(error, stackTrace);
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
