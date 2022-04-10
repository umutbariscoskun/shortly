import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/domain/entities/short_link.dart';
import 'package:shortly/src/domain/repositories/short_link_repository.dart';
import 'package:shortly/src/domain/usecases/add_short_link_to_history_list.dart';
import 'package:shortly/src/domain/usecases/get_short_links_from_history_list.dart';
import 'package:shortly/src/domain/usecases/remove_short_link_from_history_list.dart';

class HomePresenter extends Presenter {
  late Function addShortLinkToHistoryListOnComplete;
  late Function addShortLinkToHistoryListOnError;

  late Function removeShortLinkFromHistoryListOnComplete;
  late Function removeShortLinkFromHistoryListOnError;

  late Function getShortLinksFromHistoryListOnNext;
  late Function getShortLinksFromHistoryListOnError;

  final AddShortLinkToHistoryList _addShortLinkToHistoryList;
  final RemoveShortLinkFromHistoryList _removeShortLinkFromHistoryList;
  final GetShortLinksFromHistoryList _getShortLinksFromHistoryList;

  HomePresenter(ShortLinkRepository _shortLinkRepository)
      : _addShortLinkToHistoryList =
            AddShortLinkToHistoryList(_shortLinkRepository),
        _removeShortLinkFromHistoryList =
            RemoveShortLinkFromHistoryList(_shortLinkRepository),
        _getShortLinksFromHistoryList =
            GetShortLinksFromHistoryList(_shortLinkRepository);

  @override
  void dispose() {
    _addShortLinkToHistoryList.dispose();
    _removeShortLinkFromHistoryList.dispose();
    _getShortLinksFromHistoryList.dispose();
  }

  void addShortLinkToHistoryList(String url) {
    _addShortLinkToHistoryList.execute(
      _AddShortLinkToHistoryListObserver(this),
      AddShortLinkToHistoryListParams(url),
    );
  }

  void removeShortLinkFromHistoryList(String shortLinkId) {
    _removeShortLinkFromHistoryList.execute(
      _RemoveShortLinkFromHistoryListObserver(this),
      RemoveShortLinkFromHistoryListParams(shortLinkId),
    );
  }

  void getShortLinksFromHistoryList() {
    _getShortLinksFromHistoryList
        .execute(_GetShortLinksFromHistoryListObserver(this));
  }
}

class _AddShortLinkToHistoryListObserver extends Observer<void> {
  final HomePresenter _presenter;

  _AddShortLinkToHistoryListObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.addShortLinkToHistoryListOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addShortLinkToHistoryListOnError(e);
  }

  @override
  void onNext(_) {}
}

class _RemoveShortLinkFromHistoryListObserver extends Observer<void> {
  final HomePresenter _presenter;

  _RemoveShortLinkFromHistoryListObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.removeShortLinkFromHistoryListOnComplete();
  }

  @override
  void onError(e) {
    _presenter.removeShortLinkFromHistoryListOnError(e);
  }

  @override
  void onNext(_) {}
}

class _GetShortLinksFromHistoryListObserver extends Observer<List<ShortLink>> {
  final HomePresenter _presenter;

  _GetShortLinksFromHistoryListObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getShortLinksFromHistoryListOnError(e);
  }

  @override
  void onNext(List<ShortLink>? response) {
    _presenter.getShortLinksFromHistoryListOnNext(response);
  }
}
