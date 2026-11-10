// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quotes_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuotesState {

 bool get isLoading; bool get isLoadingMore; bool get canLoadMore; (Success, bool)? get isQuoteSuccess; QuoteModel? get quoteToDelete; List<QuoteModel> get quotes;
/// Create a copy of QuotesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuotesStateCopyWith<QuotesState> get copyWith => _$QuotesStateCopyWithImpl<QuotesState>(this as QuotesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuotesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.canLoadMore, canLoadMore) || other.canLoadMore == canLoadMore)&&(identical(other.isQuoteSuccess, isQuoteSuccess) || other.isQuoteSuccess == isQuoteSuccess)&&(identical(other.quoteToDelete, quoteToDelete) || other.quoteToDelete == quoteToDelete)&&const DeepCollectionEquality().equals(other.quotes, quotes));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,canLoadMore,isQuoteSuccess,quoteToDelete,const DeepCollectionEquality().hash(quotes));

@override
String toString() {
  return 'QuotesState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, canLoadMore: $canLoadMore, isQuoteSuccess: $isQuoteSuccess, quoteToDelete: $quoteToDelete, quotes: $quotes)';
}


}

/// @nodoc
abstract mixin class $QuotesStateCopyWith<$Res>  {
  factory $QuotesStateCopyWith(QuotesState value, $Res Function(QuotesState) _then) = _$QuotesStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool canLoadMore, (Success, bool)? isQuoteSuccess, QuoteModel? quoteToDelete, List<QuoteModel> quotes
});


$QuoteModelCopyWith<$Res>? get quoteToDelete;

}
/// @nodoc
class _$QuotesStateCopyWithImpl<$Res>
    implements $QuotesStateCopyWith<$Res> {
  _$QuotesStateCopyWithImpl(this._self, this._then);

  final QuotesState _self;
  final $Res Function(QuotesState) _then;

/// Create a copy of QuotesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? canLoadMore = null,Object? isQuoteSuccess = freezed,Object? quoteToDelete = freezed,Object? quotes = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,canLoadMore: null == canLoadMore ? _self.canLoadMore : canLoadMore // ignore: cast_nullable_to_non_nullable
as bool,isQuoteSuccess: freezed == isQuoteSuccess ? _self.isQuoteSuccess : isQuoteSuccess // ignore: cast_nullable_to_non_nullable
as (Success, bool)?,quoteToDelete: freezed == quoteToDelete ? _self.quoteToDelete : quoteToDelete // ignore: cast_nullable_to_non_nullable
as QuoteModel?,quotes: null == quotes ? _self.quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<QuoteModel>,
  ));
}
/// Create a copy of QuotesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteModelCopyWith<$Res>? get quoteToDelete {
    if (_self.quoteToDelete == null) {
    return null;
  }

  return $QuoteModelCopyWith<$Res>(_self.quoteToDelete!, (value) {
    return _then(_self.copyWith(quoteToDelete: value));
  });
}
}


/// @nodoc


class _QuotesState implements QuotesState {
  const _QuotesState({this.isLoading = false, this.isLoadingMore = false, this.canLoadMore = true, this.isQuoteSuccess, this.quoteToDelete, final  List<QuoteModel> quotes = const []}): _quotes = quotes;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool canLoadMore;
@override final  (Success, bool)? isQuoteSuccess;
@override final  QuoteModel? quoteToDelete;
 final  List<QuoteModel> _quotes;
@override@JsonKey() List<QuoteModel> get quotes {
  if (_quotes is EqualUnmodifiableListView) return _quotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quotes);
}


/// Create a copy of QuotesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuotesStateCopyWith<_QuotesState> get copyWith => __$QuotesStateCopyWithImpl<_QuotesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuotesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.canLoadMore, canLoadMore) || other.canLoadMore == canLoadMore)&&(identical(other.isQuoteSuccess, isQuoteSuccess) || other.isQuoteSuccess == isQuoteSuccess)&&(identical(other.quoteToDelete, quoteToDelete) || other.quoteToDelete == quoteToDelete)&&const DeepCollectionEquality().equals(other._quotes, _quotes));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,canLoadMore,isQuoteSuccess,quoteToDelete,const DeepCollectionEquality().hash(_quotes));

@override
String toString() {
  return 'QuotesState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, canLoadMore: $canLoadMore, isQuoteSuccess: $isQuoteSuccess, quoteToDelete: $quoteToDelete, quotes: $quotes)';
}


}

/// @nodoc
abstract mixin class _$QuotesStateCopyWith<$Res> implements $QuotesStateCopyWith<$Res> {
  factory _$QuotesStateCopyWith(_QuotesState value, $Res Function(_QuotesState) _then) = __$QuotesStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool canLoadMore, (Success, bool)? isQuoteSuccess, QuoteModel? quoteToDelete, List<QuoteModel> quotes
});


@override $QuoteModelCopyWith<$Res>? get quoteToDelete;

}
/// @nodoc
class __$QuotesStateCopyWithImpl<$Res>
    implements _$QuotesStateCopyWith<$Res> {
  __$QuotesStateCopyWithImpl(this._self, this._then);

  final _QuotesState _self;
  final $Res Function(_QuotesState) _then;

/// Create a copy of QuotesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? canLoadMore = null,Object? isQuoteSuccess = freezed,Object? quoteToDelete = freezed,Object? quotes = null,}) {
  return _then(_QuotesState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,canLoadMore: null == canLoadMore ? _self.canLoadMore : canLoadMore // ignore: cast_nullable_to_non_nullable
as bool,isQuoteSuccess: freezed == isQuoteSuccess ? _self.isQuoteSuccess : isQuoteSuccess // ignore: cast_nullable_to_non_nullable
as (Success, bool)?,quoteToDelete: freezed == quoteToDelete ? _self.quoteToDelete : quoteToDelete // ignore: cast_nullable_to_non_nullable
as QuoteModel?,quotes: null == quotes ? _self._quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<QuoteModel>,
  ));
}

/// Create a copy of QuotesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteModelCopyWith<$Res>? get quoteToDelete {
    if (_self.quoteToDelete == null) {
    return null;
  }

  return $QuoteModelCopyWith<$Res>(_self.quoteToDelete!, (value) {
    return _then(_self.copyWith(quoteToDelete: value));
  });
}
}

// dart format on
