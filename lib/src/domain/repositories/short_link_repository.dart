import 'package:shortly/src/domain/entities/short_link.dart';

abstract class ShortLinkRepository {
  Future<void> addShortLinkToHistoryList(String url);
  Future<void> removeShortLinkFromHistory(String shortLinkId);
  Stream<List<ShortLink>> getShortLinksFromHistory();
}
