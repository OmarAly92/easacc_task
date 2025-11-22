import 'package:easacc_task/core/error_handling/failures/failure.dart';
import 'package:easacc_task/core/helpers/cache/cache_helper.dart';
import 'package:easacc_task/core/helpers/result/result.dart';
import 'package:easacc_task/feature/settings/data/model/scanned_device_model.dart';
import 'package:easacc_task/feature/settings/data/repository/settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository) : super(const SettingsInitialState()) {
    loadSavedUrl();
    scanDevices();
  }

  final SettingsRepository _repository;

  final urlController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? _currentUrl;
  List<ScannedDeviceModel> _devices = [];
  List<ScannedDeviceModel> _wifiNetworks = [];

  String? get currentUrl => _currentUrl;

  List<ScannedDeviceModel> get devices => _devices;

  List<ScannedDeviceModel> get wifiNetworks => _wifiNetworks;

  List<ScannedDeviceModel> get printerDevices =>
      _devices.where((d) => d.type == ScannedDeviceType.printer).toList();

  void loadSavedUrl() {
    _currentUrl = _repository.getUrl();
    if (_currentUrl != null) {
      urlController.text = _currentUrl!;
    }
    emit(UrlLoadedState(url: _currentUrl));
  }

  Future<void> saveUrl() async {
    final url = urlController.text.trim();
    if (url.isEmpty) {
      emit(
        SettingsFailureState(
          failure: ServerFailure(error: 'Empty URL', message: 'URL cannot be empty'),
        ),
      );
      return;
    }

    if (!_isValidUrl(url)) {
      emit(
        SettingsFailureState(
          failure: ServerFailure(error: 'Invalid URL', message: 'Please enter a valid URL'),
        ),
      );
      return;
    }

    emit(const UrlSavingState());
    final result = await _repository.saveUrl(url);
    result.when(
      onSuccess: (_) {
        _currentUrl = url;
        emit(UrlSavedState(url: url));
      },
      onFailure: (failure) => emit(SettingsFailureState(failure: failure)),
    );
  }

  Future<void> clearUrl() async {
    emit(const UrlSavingState());
    final result = await _repository.clearUrl();
    result.when(
      onSuccess: (_) {
        _currentUrl = null;
        urlController.clear();
        emit(const UrlClearedState());
      },
      onFailure: (failure) => emit(SettingsFailureState(failure: failure)),
    );
  }

  Future<void> scanDevices() async {
    await Future.delayed(Durations.short1);
    emit(const DeviceScanningState());

    final hasBluetoothPermission = await _repository.requestBluetoothPermissions();
    final hasLocationPermission = await _repository.requestLocationPermissions();

    if (!hasBluetoothPermission || !hasLocationPermission) {
      emit(
        SettingsFailureState(
          failure: ServerFailure(
            error: 'Permission denied',
            message: 'Please grant Bluetooth and Location permissions',
          ),
        ),
      );
      return;
    }

    final wifiResult = await _repository.scanWifiNetworks();
    wifiResult.when(
      onSuccess: (networks) => _wifiNetworks = networks,
      onFailure: (_) => _wifiNetworks = [],
    );

    final bluetoothResult = await _repository.scanBluetoothDevices();
    bluetoothResult.when(
      onSuccess: (deviceList) {
        _devices = deviceList;
        emit(
          DevicesScannedState(
            devices: deviceList,
            wifiNetworks: _wifiNetworks,
            printerCount: printerDevices.length,
          ),
        );
      },
      onFailure: (failure) => emit(SettingsFailureState(failure: failure)),
    );
  }

  void stopScan() {
    _repository.stopBluetoothScan();
  }

  Future<void> logout() async {
    try {
      await CacheHelper.remove(CacheKeys.token);
      await CacheHelper.remove(CacheKeys.userEmail);
      await CacheHelper.remove(CacheKeys.userName);
      await CacheHelper.remove(CacheKeys.userPhoto);
      await CacheHelper.remove(CacheKeys.socialProvider);
      emit(const LogoutSuccessState());
    } catch (e) {
      emit(
        LogoutFailureState(
          failure: ServerFailure(error: e, message: 'Failed to logout'),
        ),
      );
    }
  }

  bool _isValidUrl(String url) {
    final urlPattern = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(url);
  }

  @override
  Future<void> close() {
    urlController.dispose();
    stopScan();
    return super.close();
  }
}
