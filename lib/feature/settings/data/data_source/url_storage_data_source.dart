import 'package:easacc_task/core/helpers/cache/cache_helper.dart';

abstract class UrlStorageDataSource {
  Future<bool> saveUrl(String url);

  String? getUrl();

  Future<bool> clearUrl();
}

class UrlStorageDataSourceImp implements UrlStorageDataSource {
  @override
  Future<bool> saveUrl(String url) async {
    return await CacheHelper.save(CacheKeys.webviewUrl, url);
  }

  @override
  String? getUrl() {
    return CacheHelper.get(CacheKeys.webviewUrl) as String?;
  }

  @override
  Future<bool> clearUrl() async {
    return await CacheHelper.remove(CacheKeys.webviewUrl);
  }
}
