import 'package:equatable/equatable.dart';

class FreezeStatusModel extends Equatable {
  final int? id;
  final bool? isFrozen;
  final String? freezeStart;
  final String? freezeEnd;
  final String? subscriptionEndDate;
  final int? weeksFrozenUsed;
  final int? weeksFrozenAllowed;

  const FreezeStatusModel({
    this.id,
    this.isFrozen,
    this.freezeStart,
    this.freezeEnd,
    this.subscriptionEndDate,
    this.weeksFrozenUsed,
    this.weeksFrozenAllowed,
  });

  factory FreezeStatusModel.fromJson(Map<String, dynamic> json) {
    return FreezeStatusModel(
      id: json['id'] as int?,
      isFrozen: json['is_frozen'] as bool?,
      freezeStart: json['freeze_start'] as String?,
      freezeEnd: json['freeze_end'] as String?,
      subscriptionEndDate: json['subscription_end_date'] as String?,
      weeksFrozenUsed: json['weeks_frozen_used'] as int?,
      weeksFrozenAllowed: json['weeks_frozen_allowed'] as int?,
    );
  }

  @override
  List<Object?> get props => [
    id,
    isFrozen,
    freezeStart,
    freezeEnd,
    subscriptionEndDate,
    weeksFrozenUsed,
    weeksFrozenAllowed,
  ];
}
