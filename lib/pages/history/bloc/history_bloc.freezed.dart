// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryEvent()';
}


}

/// @nodoc
class $HistoryEventCopyWith<$Res>  {
$HistoryEventCopyWith(HistoryEvent _, $Res Function(HistoryEvent) __);
}


/// Adds pattern-matching-related methods to [HistoryEvent].
extension HistoryEventPatterns on HistoryEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadHistory value)?  loadHistory,TResult Function( FilterChanged value)?  filterChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadHistory() when loadHistory != null:
return loadHistory(_that);case FilterChanged() when filterChanged != null:
return filterChanged(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadHistory value)  loadHistory,required TResult Function( FilterChanged value)  filterChanged,}){
final _that = this;
switch (_that) {
case LoadHistory():
return loadHistory(_that);case FilterChanged():
return filterChanged(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadHistory value)?  loadHistory,TResult? Function( FilterChanged value)?  filterChanged,}){
final _that = this;
switch (_that) {
case LoadHistory() when loadHistory != null:
return loadHistory(_that);case FilterChanged() when filterChanged != null:
return filterChanged(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadHistory,TResult Function( DateTime? selectedMonth,  TransactionStatus? selectedStatus,  TransactionCategory? selectedCategory)?  filterChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadHistory() when loadHistory != null:
return loadHistory();case FilterChanged() when filterChanged != null:
return filterChanged(_that.selectedMonth,_that.selectedStatus,_that.selectedCategory);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadHistory,required TResult Function( DateTime? selectedMonth,  TransactionStatus? selectedStatus,  TransactionCategory? selectedCategory)  filterChanged,}) {final _that = this;
switch (_that) {
case LoadHistory():
return loadHistory();case FilterChanged():
return filterChanged(_that.selectedMonth,_that.selectedStatus,_that.selectedCategory);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadHistory,TResult? Function( DateTime? selectedMonth,  TransactionStatus? selectedStatus,  TransactionCategory? selectedCategory)?  filterChanged,}) {final _that = this;
switch (_that) {
case LoadHistory() when loadHistory != null:
return loadHistory();case FilterChanged() when filterChanged != null:
return filterChanged(_that.selectedMonth,_that.selectedStatus,_that.selectedCategory);case _:
  return null;

}
}

}

/// @nodoc


class LoadHistory implements HistoryEvent {
  const LoadHistory();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadHistory);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryEvent.loadHistory()';
}


}




/// @nodoc


class FilterChanged implements HistoryEvent {
  const FilterChanged({this.selectedMonth, this.selectedStatus, this.selectedCategory});
  

 final  DateTime? selectedMonth;
 final  TransactionStatus? selectedStatus;
 final  TransactionCategory? selectedCategory;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterChangedCopyWith<FilterChanged> get copyWith => _$FilterChangedCopyWithImpl<FilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterChanged&&(identical(other.selectedMonth, selectedMonth) || other.selectedMonth == selectedMonth)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory));
}


@override
int get hashCode => Object.hash(runtimeType,selectedMonth,selectedStatus,selectedCategory);

@override
String toString() {
  return 'HistoryEvent.filterChanged(selectedMonth: $selectedMonth, selectedStatus: $selectedStatus, selectedCategory: $selectedCategory)';
}


}

/// @nodoc
abstract mixin class $FilterChangedCopyWith<$Res> implements $HistoryEventCopyWith<$Res> {
  factory $FilterChangedCopyWith(FilterChanged value, $Res Function(FilterChanged) _then) = _$FilterChangedCopyWithImpl;
@useResult
$Res call({
 DateTime? selectedMonth, TransactionStatus? selectedStatus, TransactionCategory? selectedCategory
});




}
/// @nodoc
class _$FilterChangedCopyWithImpl<$Res>
    implements $FilterChangedCopyWith<$Res> {
  _$FilterChangedCopyWithImpl(this._self, this._then);

  final FilterChanged _self;
  final $Res Function(FilterChanged) _then;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedMonth = freezed,Object? selectedStatus = freezed,Object? selectedCategory = freezed,}) {
  return _then(FilterChanged(
selectedMonth: freezed == selectedMonth ? _self.selectedMonth : selectedMonth // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedStatus: freezed == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as TransactionStatus?,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as TransactionCategory?,
  ));
}


}

/// @nodoc
mixin _$HistoryState {

 StatusState get status; List<TransactionModel> get allTransactions; List<TransactionModel> get filteredTransactions; DateTime? get selectedMonth; TransactionStatus? get selectedStatus; TransactionCategory? get selectedCategory; String? get errorMessage;
/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryStateCopyWith<HistoryState> get copyWith => _$HistoryStateCopyWithImpl<HistoryState>(this as HistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.allTransactions, allTransactions)&&const DeepCollectionEquality().equals(other.filteredTransactions, filteredTransactions)&&(identical(other.selectedMonth, selectedMonth) || other.selectedMonth == selectedMonth)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(allTransactions),const DeepCollectionEquality().hash(filteredTransactions),selectedMonth,selectedStatus,selectedCategory,errorMessage);

@override
String toString() {
  return 'HistoryState(status: $status, allTransactions: $allTransactions, filteredTransactions: $filteredTransactions, selectedMonth: $selectedMonth, selectedStatus: $selectedStatus, selectedCategory: $selectedCategory, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $HistoryStateCopyWith<$Res>  {
  factory $HistoryStateCopyWith(HistoryState value, $Res Function(HistoryState) _then) = _$HistoryStateCopyWithImpl;
@useResult
$Res call({
 StatusState status, List<TransactionModel> allTransactions, List<TransactionModel> filteredTransactions, DateTime? selectedMonth, TransactionStatus? selectedStatus, TransactionCategory? selectedCategory, String? errorMessage
});




}
/// @nodoc
class _$HistoryStateCopyWithImpl<$Res>
    implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._self, this._then);

  final HistoryState _self;
  final $Res Function(HistoryState) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? allTransactions = null,Object? filteredTransactions = null,Object? selectedMonth = freezed,Object? selectedStatus = freezed,Object? selectedCategory = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusState,allTransactions: null == allTransactions ? _self.allTransactions : allTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,filteredTransactions: null == filteredTransactions ? _self.filteredTransactions : filteredTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,selectedMonth: freezed == selectedMonth ? _self.selectedMonth : selectedMonth // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedStatus: freezed == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as TransactionStatus?,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as TransactionCategory?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryState].
extension HistoryStatePatterns on HistoryState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryState value)  $default,){
final _that = this;
switch (_that) {
case _HistoryState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StatusState status,  List<TransactionModel> allTransactions,  List<TransactionModel> filteredTransactions,  DateTime? selectedMonth,  TransactionStatus? selectedStatus,  TransactionCategory? selectedCategory,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that.status,_that.allTransactions,_that.filteredTransactions,_that.selectedMonth,_that.selectedStatus,_that.selectedCategory,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StatusState status,  List<TransactionModel> allTransactions,  List<TransactionModel> filteredTransactions,  DateTime? selectedMonth,  TransactionStatus? selectedStatus,  TransactionCategory? selectedCategory,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _HistoryState():
return $default(_that.status,_that.allTransactions,_that.filteredTransactions,_that.selectedMonth,_that.selectedStatus,_that.selectedCategory,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StatusState status,  List<TransactionModel> allTransactions,  List<TransactionModel> filteredTransactions,  DateTime? selectedMonth,  TransactionStatus? selectedStatus,  TransactionCategory? selectedCategory,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that.status,_that.allTransactions,_that.filteredTransactions,_that.selectedMonth,_that.selectedStatus,_that.selectedCategory,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _HistoryState implements HistoryState {
  const _HistoryState({this.status = StatusState.idle, final  List<TransactionModel> allTransactions = const [], final  List<TransactionModel> filteredTransactions = const [], this.selectedMonth, this.selectedStatus, this.selectedCategory, this.errorMessage}): _allTransactions = allTransactions,_filteredTransactions = filteredTransactions;
  

@override@JsonKey() final  StatusState status;
 final  List<TransactionModel> _allTransactions;
@override@JsonKey() List<TransactionModel> get allTransactions {
  if (_allTransactions is EqualUnmodifiableListView) return _allTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allTransactions);
}

 final  List<TransactionModel> _filteredTransactions;
@override@JsonKey() List<TransactionModel> get filteredTransactions {
  if (_filteredTransactions is EqualUnmodifiableListView) return _filteredTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredTransactions);
}

@override final  DateTime? selectedMonth;
@override final  TransactionStatus? selectedStatus;
@override final  TransactionCategory? selectedCategory;
@override final  String? errorMessage;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryStateCopyWith<_HistoryState> get copyWith => __$HistoryStateCopyWithImpl<_HistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._allTransactions, _allTransactions)&&const DeepCollectionEquality().equals(other._filteredTransactions, _filteredTransactions)&&(identical(other.selectedMonth, selectedMonth) || other.selectedMonth == selectedMonth)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_allTransactions),const DeepCollectionEquality().hash(_filteredTransactions),selectedMonth,selectedStatus,selectedCategory,errorMessage);

@override
String toString() {
  return 'HistoryState(status: $status, allTransactions: $allTransactions, filteredTransactions: $filteredTransactions, selectedMonth: $selectedMonth, selectedStatus: $selectedStatus, selectedCategory: $selectedCategory, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$HistoryStateCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory _$HistoryStateCopyWith(_HistoryState value, $Res Function(_HistoryState) _then) = __$HistoryStateCopyWithImpl;
@override @useResult
$Res call({
 StatusState status, List<TransactionModel> allTransactions, List<TransactionModel> filteredTransactions, DateTime? selectedMonth, TransactionStatus? selectedStatus, TransactionCategory? selectedCategory, String? errorMessage
});




}
/// @nodoc
class __$HistoryStateCopyWithImpl<$Res>
    implements _$HistoryStateCopyWith<$Res> {
  __$HistoryStateCopyWithImpl(this._self, this._then);

  final _HistoryState _self;
  final $Res Function(_HistoryState) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? allTransactions = null,Object? filteredTransactions = null,Object? selectedMonth = freezed,Object? selectedStatus = freezed,Object? selectedCategory = freezed,Object? errorMessage = freezed,}) {
  return _then(_HistoryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusState,allTransactions: null == allTransactions ? _self._allTransactions : allTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,filteredTransactions: null == filteredTransactions ? _self._filteredTransactions : filteredTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionModel>,selectedMonth: freezed == selectedMonth ? _self.selectedMonth : selectedMonth // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedStatus: freezed == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as TransactionStatus?,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as TransactionCategory?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
