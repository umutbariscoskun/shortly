import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/app/pages/home/home_presenter.dart';
import 'package:shortly/src/data/exceptions/duplicate_link_exception.dart';
import 'package:shortly/src/domain/entities/short_link.dart';
import 'package:shortly/src/domain/repositories/short_link_repository.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController(ShortLinkRepository _shortLinkRepository)
      : _presenter = HomePresenter(_shortLinkRepository);

  final TextEditingController editingController = TextEditingController();

  List<ShortLink>? shortLinks;
  List<String> fullLinks = [];
  String? url;
  bool isAddButtonPressed = false;
  bool isItemCopiedToClipboard = false;
  ShortLink? cachedShortlink;

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
      isAddButtonPressed = false;
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

  void onShortenItButtonPressed() {
    isAddButtonPressed = true;
    if (!fullLinks.contains(url!)) fullLinks.add(url!);

    addShortLinkToHistoryList();
    editingController.clear();
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

  void copyItemToClipboard(ShortLink shortLink) async {
    await Clipboard.setData(ClipboardData(text: shortLink.fullShortLink));
    final ClipboardData? _data = await Clipboard.getData('text/plain');
    ScaffoldMessenger.of(getContext()).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));

    shortLinks!.forEach(
      (element) {
        element.id == shortLink.id
            ? element.isCopied = true
            : element.isCopied = false;
      },
    );

    refreshUI();
  }
}
