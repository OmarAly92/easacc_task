import 'package:equatable/equatable.dart';

enum ScannedDeviceType { wifi, bluetooth, printer, unknown }

enum DeviceConnectionStatus { connected, disconnected }

class ScannedDeviceModel extends Equatable {
  const ScannedDeviceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    this.macAddress,
    this.signalStrength,
  });

  final String id;
  final String name;
  final ScannedDeviceType type;
  final DeviceConnectionStatus status;
  final String? macAddress;
  final int? signalStrength;

  factory ScannedDeviceModel.fromBluetoothDevice({
    required String id,
    required String name,
    required bool isConnected,
    int? rssi,
  }) {
    final isPrinter = name.toLowerCase().contains('print') ||
        name.toLowerCase().contains('hp') ||
        name.toLowerCase().contains('canon') ||
        name.toLowerCase().contains('epson') ||
        name.toLowerCase().contains('brother');

    return ScannedDeviceModel(
      id: id,
      name: name.isEmpty ? 'Unknown Device' : name,
      type: isPrinter ? ScannedDeviceType.printer : ScannedDeviceType.bluetooth,
      status: isConnected ? DeviceConnectionStatus.connected : DeviceConnectionStatus.disconnected,
      macAddress: id,
      signalStrength: rssi,
    );
  }

  factory ScannedDeviceModel.fromWifiDevice({
    required String name,
    String? ipAddress,
    required bool isConnected,
    int? signalLevel,
  }) {
    return ScannedDeviceModel(
      id: name,
      name: name.isEmpty ? 'Unknown Network' : name,
      type: ScannedDeviceType.wifi,
      status: isConnected ? DeviceConnectionStatus.connected : DeviceConnectionStatus.disconnected,
      macAddress: ipAddress,
      signalStrength: signalLevel,
    );
  }

  @override
  List<Object?> get props => [id, name, type, status, macAddress, signalStrength];
}
