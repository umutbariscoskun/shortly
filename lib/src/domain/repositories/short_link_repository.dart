import 'package:shortly/src/domain/entities/short_link.dart';

abstract class ShortCodeRepository {
  Future<void> addShortLinkToHistoryList(ShortLink shortLink);
  Future<void> removeShortLinkFromHistory(String shortLinkId);
  Stream<List<ShortLink>> getShortLinksFromHistory();
}
