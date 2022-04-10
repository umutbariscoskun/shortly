import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/domain/repositories/short_link_repository.dart';

class RemoveShortLinkFromHistoryList
    extends UseCase<void, RemoveShortLinkFromHistoryListParams> {
  final ShortLinkRepository _shortLinkRepository;

  RemoveShortLinkFromHistoryList(
    this._shortLinkRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    StreamController<void> controller = StreamController();

    try {
      await _shortLinkRepository
          .removeShortLinkFromHistory(params!.shortLinkId);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return controller.stream;
  }
}

class RemoveShortLinkFromHistoryListParams {
  final String shortLinkId;

  RemoveShortLinkFromHistoryListParams(this.shortLinkId);
}
