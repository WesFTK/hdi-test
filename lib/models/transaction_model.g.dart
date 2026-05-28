// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      category: $enumDecode(_$TransactionCategoryEnumMap, json['category']),
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
      description: json['description'] as String,
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'category': _$TransactionCategoryEnumMap[instance.category]!,
      'amount': instance.amount,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'description': instance.description,
    };

const _$TransactionCategoryEnumMap = {
  TransactionCategory.food: 'food',
  TransactionCategory.electronics: 'electronics',
  TransactionCategory.clothing: 'clothing',
  TransactionCategory.health: 'health',
  TransactionCategory.entertainment: 'entertainment',
  TransactionCategory.travel: 'travel',
  TransactionCategory.other: 'other',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.paid: 'paid',
  TransactionStatus.pending: 'pending',
  TransactionStatus.failed: 'failed',
  TransactionStatus.refunded: 'refunded',
};
