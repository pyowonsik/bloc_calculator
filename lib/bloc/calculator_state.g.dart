// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CalculatorState _$$_CalculatorStateFromJson(Map<String, dynamic> json) =>
    _$_CalculatorState(
      inputExpression: json['inputExpression'] as String,
      resultExpression: json['resultExpression'] as String,
      calculatedNumber: json['calculatedNumber'] as num,
      isCalculated: json['isCalculated'] as bool,
    );

Map<String, dynamic> _$$_CalculatorStateToJson(_$_CalculatorState instance) =>
    <String, dynamic>{
      'inputExpression': instance.inputExpression,
      'resultExpression': instance.resultExpression,
      'calculatedNumber': instance.calculatedNumber,
      'isCalculated': instance.isCalculated,
    };
