import 'package:easacc_task/core/error_handling/failures/failure.dart';
import 'package:easacc_task/core/helpers/result/result.dart';
import 'package:easacc_task/feature/settings/data/data_source/device_scanner_data_source.dart';
import 'package:easacc_task/feature/settings/data/data_source/url_storage_data_source.dart';
import 'package:easacc_task/feature/settings/data/model/scanned_device_model.dart';

abstract class SettingsRepository {
  FutureResult<bool> saveUrl(String url);

  String? getUrl();

  FutureResult<bool> clearUrl();

  FutureResult<List<ScannedDeviceModel>> scanBluetoothDevices();

  FutureResult<List<ScannedDeviceModel>> scanWifiNetworks();

  Future<bool> requestBluetoothPermissions();

  Future<bool> requestLocationPermissions();

  void stopBluetoothScan();
}

class SettingsRepositoryImp implements SettingsRepository {
  SettingsRepositoryImp(this._urlStorageDataSource, this._deviceScannerDataSource);

  final UrlStorageDataSource _urlStorageDataSource;
  final DeviceScannerDataSource _deviceScannerDataSource;

  @override
  FutureResult<bool> saveUrl(String url) async {
    try {
      final result = await _urlStorageDataSource.saveUrl(url);
      return Result.success(result);
    } catch (e) {
      return Result.failure(
        ServerFailure(error: e, message: 'Failed to save URL: ${e.toString()}'),
      );
    }
  }

  @override
  String? getUrl() {
    return _urlStorageDataSource.getUrl();
  }

  @override
  FutureResult<bool> clearUrl() async {
    try {
      final result = await _urlStorageDataSource.clearUrl();
      return Result.success(result);
    } catch (e) {
      return Result.failure(
        ServerFailure(error: e, message: 'Failed to clear URL: ${e.toString()}'),
      );
    }
  }

  @override
  FutureResult<List<ScannedDeviceModel>> scanBluetoothDevices() async {
    try {
      final result = await _deviceScannerDataSource.scanBluetoothDevices();
      return Result.success(result);
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        ServerFailure(error: e, message: 'Bluetooth scan failed: ${e.toString()}'),
      );
    }
  }

  @override
  FutureResult<List<ScannedDeviceModel>> scanWifiNetworks() async {
    try {
      final result = await _deviceScannerDataSource.scanWifiNetworks();
      return Result.success(result);
    } catch (e) {
      return Result.failure(
        ServerFailure(error: e, message: 'WiFi scan failed: ${e.toString()}'),
      );
    }
  }

  @override
  Future<bool> requestBluetoothPermissions() {
    return _deviceScannerDataSource.requestBluetoothPermissions();
  }

  @override
  Future<bool> requestLocationPermissions() {
    return _deviceScannerDataSource.requestLocationPermissions();
  }

  @override
  void stopBluetoothScan() {
    _deviceScannerDataSource.stopBluetoothScan();
  }
}
