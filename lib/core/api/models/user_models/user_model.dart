import 'package:equatable/equatable.dart';
import 'package:easacc_task/core/api/models/user_models/user_attributes_model.dart';

class UserModel extends Equatable {
  final String? type;
  final int? id;
  final UserAttributesModel? attributes;

  const UserModel({this.type, this.id, this.attributes});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    type: json['type'] as String?,
    id: (json['id'] as num?)?.toInt(),
    attributes: json['attributes'] != null
        ? UserAttributesModel.fromJson(json['attributes'] as Map<String, dynamic>)
        : null,
  );

  @override
  List<Object?> get props => [type, id, attributes];
}
