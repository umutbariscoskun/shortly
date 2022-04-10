import 'package:shortly/src/domain/entities/short_link.dart';
import 'package:shortly/src/domain/repositories/short_link_repository.dart';

class DataShortLinkRepository implements ShortLinkRepository {
  static final _instance = DataShortLinkRepository._internal();
  DataShortLinkRepository._internal();
  factory DataShortLinkRepository() => _instance;

  @override
  Future<void> addShortLinkToHistoryList(ShortLink shortLink) {
    // TODO: implement addShortLinkToHistoryList
    throw UnimplementedError();
  }

  @override
  Stream<List<ShortLink>> getShortLinksFromHistory() {
    // TODO: implement getShortLinksFromHistory
    throw UnimplementedError();
  }

  @override
  Future<void> removeShortLinkFromHistory(String shortLinkId) {
    // TODO: implement removeShortLinkFromHistory
    throw UnimplementedError();
  }
}
