import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/domain/entities/short_link.dart';
import 'package:shortly/src/domain/repositories/short_link_repository.dart';

class AddShortLinkToHistoryList
    extends UseCase<void, AddShortLinkToHistoryListParams> {
  final ShortLinkRepository _shortLinkRepository;

  AddShortLinkToHistoryList(
    this._shortLinkRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(
      AddShortLinkToHistoryListParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      await _shortLinkRepository.addShortLinkToHistoryList(params!.shortLink);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class AddShortLinkToHistoryListParams {
  final ShortLink shortLink;

  AddShortLinkToHistoryListParams(
    this.shortLink,
  );
}
