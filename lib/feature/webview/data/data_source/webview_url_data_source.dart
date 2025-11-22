import 'package:easacc_task/core/helpers/cache/cache_helper.dart';

abstract class WebViewUrlDataSource {
  String? getSavedUrl();
}

class WebViewUrlDataSourceImp implements WebViewUrlDataSource {
  @override
  String? getSavedUrl() {
    return CacheHelper.get(CacheKeys.webviewUrl) as String?;
  }
}
