import 'package:easacc_task/feature/webview/data/data_source/webview_url_data_source.dart';

abstract class WebViewRepository {
  String? getSavedUrl();
}

class WebViewRepositoryImp implements WebViewRepository {
  WebViewRepositoryImp(this._dataSource);

  final WebViewUrlDataSource _dataSource;

  @override
  String? getSavedUrl() {
    return _dataSource.getSavedUrl();
  }
}
