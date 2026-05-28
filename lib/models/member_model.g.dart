// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => _MemberModel(
  id: json['id'] as String,
  name: json['name'] as String,
  city: json['city'] as String,
  joinDate: DateTime.parse(json['joinDate'] as String),
  membershipStatus: json['membershipStatus'] as String,
);

Map<String, dynamic> _$MemberModelToJson(_MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'joinDate': instance.joinDate.toIso8601String(),
      'membershipStatus': instance.membershipStatus,
    };
