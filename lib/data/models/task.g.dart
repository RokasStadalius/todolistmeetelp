// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      taskID: json['taskID'] as String?,
      userId: json['userId'] as String? ?? '',
      text: json['text'] as String? ?? '',
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'taskID': instance.taskID,
      'userId': instance.userId,
      'text': instance.text,
    };
