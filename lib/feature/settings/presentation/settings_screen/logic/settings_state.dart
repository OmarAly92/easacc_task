part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();
}

final class SettingsInitialState extends SettingsState {
  const SettingsInitialState();

  @override
  List<Object> get props => [];
}

final class UrlLoadedState extends SettingsState {
  const UrlLoadedState({this.url});

  final String? url;

  @override
  List<Object?> get props => [url];
}

final class UrlSavingState extends SettingsState {
  const UrlSavingState();

  @override
  List<Object> get props => [];
}

final class UrlSavedState extends SettingsState {
  const UrlSavedState({required this.url});

  final String url;

  @override
  List<Object> get props => [url];
}

final class UrlClearedState extends SettingsState {
  const UrlClearedState();

  @override
  List<Object> get props => [];
}

final class DeviceScanningState extends SettingsState {
  const DeviceScanningState();

  @override
  List<Object> get props => [];
}

final class DevicesScannedState extends SettingsState {
  const DevicesScannedState({
    required this.devices,
    required this.wifiNetworks,
    required this.printerCount,
  });

  final List<ScannedDeviceModel> devices;
  final List<ScannedDeviceModel> wifiNetworks;
  final int printerCount;

  @override
  List<Object?> get props => [devices, wifiNetworks, printerCount];
}

final class LogoutSuccessState extends SettingsState {
  const LogoutSuccessState();

  @override
  List<Object> get props => [];
}

final class LogoutFailureState extends SettingsState {
  const LogoutFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}

final class SettingsFailureState extends SettingsState {
  const SettingsFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
