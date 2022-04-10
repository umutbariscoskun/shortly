import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/app/pages/home/home_presenter.dart';
import 'package:shortly/src/domain/entities/short_link.dart';
import 'package:shortly/src/domain/repositories/short_link_repository.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController(ShortLinkRepository _shortLinkRepository)
      : _presenter = HomePresenter(_shortLinkRepository);

  List<ShortLink>? shortLinks;
  String? url;

  @override
  void onInitState() {
    _presenter.getShortLinksFromHistoryList();
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.getShortLinksFromHistoryListOnNext =
        (List<ShortLink>? response) {
      shortLinks = response;
      if (shortLinks != null) print(shortLinks!.first.fullShortLink);
      refreshUI();
    };
    _presenter.getShortLinksFromHistoryListOnError = (e) {};

    _presenter.addShortLinkToHistoryListOnComplete = () {};
    _presenter.addShortLinkToHistoryListOnError = (e) {};

    _presenter.removeShortLinkFromHistoryListOnComplete = () {};
    _presenter.removeShortLinkFromHistoryListOnError = (e) {};
  }

  void addShortLinkToHistoryList() {
    _presenter.addShortLinkToHistoryList(url!);
    refreshUI();
  }

  void removeShortLinkFromHistory(String shortLinkId) {
    _presenter.removeShortLinkFromHistoryList(shortLinkId);
    refreshUI();
  }

  void onUrlTextFormFieldChanged(String value) {
    url = value;
    refreshUI();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
