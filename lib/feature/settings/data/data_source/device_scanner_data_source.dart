import 'dart:async';

import 'package:easacc_task/core/error_handling/failures/failure.dart';
import 'package:easacc_task/feature/settings/data/model/scanned_device_model.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_scan/wifi_scan.dart';

abstract class DeviceScannerDataSource {
  Future<List<ScannedDeviceModel>> scanBluetoothDevices();

  Future<List<ScannedDeviceModel>> scanWifiNetworks();

  Future<bool> requestBluetoothPermissions();

  Future<bool> requestLocationPermissions();

  void stopBluetoothScan();
}

class DeviceScannerDataSourceImp implements DeviceScannerDataSource {
  final NetworkInfo _networkInfo = NetworkInfo();
  StreamSubscription<List<ScanResult>>? _scanSubscription;

  @override
  Future<List<ScannedDeviceModel>> scanBluetoothDevices() async {
    final devices = <ScannedDeviceModel>[];
    final seenDeviceIds = <String>{};

    try {
      final isSupported = await FlutterBluePlus.isSupported;
      if (!isSupported) {
        throw ServerFailure(
          error: 'Bluetooth not supported',
          message: 'This device does not support Bluetooth',
        );
      }

      final adapterState = await FlutterBluePlus.adapterState.first;
      if (adapterState != BluetoothAdapterState.on) {
        throw ServerFailure(
          error: 'Bluetooth not ready',
          message: 'Please turn on Bluetooth',
        );
      }

      final connectedDevices = FlutterBluePlus.connectedDevices;
      for (final device in connectedDevices) {
        final deviceName = device.platformName;

        if (deviceName.isNotEmpty && !seenDeviceIds.contains(device.remoteId.str)) {
          seenDeviceIds.add(device.remoteId.str);
          devices.add(ScannedDeviceModel.fromBluetoothDevice(
            id: device.remoteId.str,
            name: deviceName,
            isConnected: true,
            rssi: null,
          ));
        }
      }

      final completer = Completer<List<ScannedDeviceModel>>();

      _scanSubscription = FlutterBluePlus.scanResults.listen(
        (results) {
          for (final result in results) {
            if (seenDeviceIds.contains(result.device.remoteId.str)) continue;

            final deviceName = result.device.platformName.isNotEmpty
                ? result.device.platformName
                : result.advertisementData.advName;

            if (deviceName.isNotEmpty) {
              seenDeviceIds.add(result.device.remoteId.str);
              devices.add(ScannedDeviceModel.fromBluetoothDevice(
                id: result.device.remoteId.str,
                name: deviceName,
                isConnected: false,
                rssi: result.rssi,
              ));
            }
          }
        },
        onError: (error) {
          if (!completer.isCompleted) {
            completer.completeError(
              ServerFailure(
                error: error,
                message: 'Bluetooth scan failed: ${error.toString()}',
              ),
            );
          }
        },
      );

      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      Future.delayed(const Duration(seconds: 5), () {
        stopBluetoothScan();
        if (!completer.isCompleted) {
          completer.complete(devices);
        }
      });

      return await completer.future;
    } catch (e) {
      stopBluetoothScan();
      if (e is Failure) rethrow;
      throw ServerFailure(
        error: e,
        message: 'Bluetooth scan failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<ScannedDeviceModel>> scanWifiNetworks() async {
    final networks = <ScannedDeviceModel>[];

    try {
      final canScan = await WiFiScan.instance.canStartScan();
      if (canScan != CanStartScan.yes) {
        return networks;
      }

      final currentWifiName = await _networkInfo.getWifiName();
      final currentWifiIP = await _networkInfo.getWifiIP();
      final connectedSSID = currentWifiName?.replaceAll('"', '');

      await WiFiScan.instance.startScan();
      await Future.delayed(const Duration(seconds: 3));

      final results = await WiFiScan.instance.getScannedResults();

      final seen = <String>{};
      for (final result in results) {
        if (result.ssid.isEmpty || seen.contains(result.ssid)) continue;
        seen.add(result.ssid);

        final isConnected = result.ssid == connectedSSID;

        networks.add(ScannedDeviceModel.fromWifiDevice(
          name: result.ssid,
          ipAddress: isConnected ? currentWifiIP : null,
          isConnected: isConnected,
          signalLevel: result.level,
        ));
      }

      networks.sort((a, b) {
        if (a.status == DeviceConnectionStatus.connected) return -1;
        if (b.status == DeviceConnectionStatus.connected) return 1;
        return (b.signalStrength ?? 0).compareTo(a.signalStrength ?? 0);
      });

      return networks;
    } catch (e) {
      return networks;
    }
  }

  @override
  Future<bool> requestBluetoothPermissions() async {
    final bluetoothScan = await Permission.bluetoothScan.request();
    final bluetoothConnect = await Permission.bluetoothConnect.request();

    return bluetoothScan.isGranted && bluetoothConnect.isGranted;
  }

  @override
  Future<bool> requestLocationPermissions() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  @override
  void stopBluetoothScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    FlutterBluePlus.stopScan();
  }
}
