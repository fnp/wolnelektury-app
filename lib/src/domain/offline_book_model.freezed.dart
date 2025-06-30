// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OfflineBookModel {

 BookModel get book; bool get isAudiobookCorrectlyDownloaded; AudiobookModel? get audiobook; ReaderBookModel? get reader;
/// Create a copy of OfflineBookModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflineBookModelCopyWith<OfflineBookModel> get copyWith => _$OfflineBookModelCopyWithImpl<OfflineBookModel>(this as OfflineBookModel, _$identity);

  /// Serializes this OfflineBookModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineBookModel&&(identical(other.book, book) || other.book == book)&&(identical(other.isAudiobookCorrectlyDownloaded, isAudiobookCorrectlyDownloaded) || other.isAudiobookCorrectlyDownloaded == isAudiobookCorrectlyDownloaded)&&(identical(other.audiobook, audiobook) || other.audiobook == audiobook)&&(identical(other.reader, reader) || other.reader == reader));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,isAudiobookCorrectlyDownloaded,audiobook,reader);

@override
String toString() {
  return 'OfflineBookModel(book: $book, isAudiobookCorrectlyDownloaded: $isAudiobookCorrectlyDownloaded, audiobook: $audiobook, reader: $reader)';
}


}

/// @nodoc
abstract mixin class $OfflineBookModelCopyWith<$Res>  {
  factory $OfflineBookModelCopyWith(OfflineBookModel value, $Res Function(OfflineBookModel) _then) = _$OfflineBookModelCopyWithImpl;
@useResult
$Res call({
 BookModel book, bool isAudiobookCorrectlyDownloaded, AudiobookModel? audiobook, ReaderBookModel? reader
});


$BookModelCopyWith<$Res> get book;$AudiobookModelCopyWith<$Res>? get audiobook;

}
/// @nodoc
class _$OfflineBookModelCopyWithImpl<$Res>
    implements $OfflineBookModelCopyWith<$Res> {
  _$OfflineBookModelCopyWithImpl(this._self, this._then);

  final OfflineBookModel _self;
  final $Res Function(OfflineBookModel) _then;

/// Create a copy of OfflineBookModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? isAudiobookCorrectlyDownloaded = null,Object? audiobook = freezed,Object? reader = freezed,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel,isAudiobookCorrectlyDownloaded: null == isAudiobookCorrectlyDownloaded ? _self.isAudiobookCorrectlyDownloaded : isAudiobookCorrectlyDownloaded // ignore: cast_nullable_to_non_nullable
as bool,audiobook: freezed == audiobook ? _self.audiobook : audiobook // ignore: cast_nullable_to_non_nullable
as AudiobookModel?,reader: freezed == reader ? _self.reader : reader // ignore: cast_nullable_to_non_nullable
as ReaderBookModel?,
  ));
}
/// Create a copy of OfflineBookModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res> get book {
  
  return $BookModelCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}/// Create a copy of OfflineBookModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookModelCopyWith<$Res>? get audiobook {
    if (_self.audiobook == null) {
    return null;
  }

  return $AudiobookModelCopyWith<$Res>(_self.audiobook!, (value) {
    return _then(_self.copyWith(audiobook: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _OfflineBookModel implements OfflineBookModel {
  const _OfflineBookModel({required this.book, this.isAudiobookCorrectlyDownloaded = false, this.audiobook, this.reader});
  factory _OfflineBookModel.fromJson(Map<String, dynamic> json) => _$OfflineBookModelFromJson(json);

@override final  BookModel book;
@override@JsonKey() final  bool isAudiobookCorrectlyDownloaded;
@override final  AudiobookModel? audiobook;
@override final  ReaderBookModel? reader;

/// Create a copy of OfflineBookModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflineBookModelCopyWith<_OfflineBookModel> get copyWith => __$OfflineBookModelCopyWithImpl<_OfflineBookModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfflineBookModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfflineBookModel&&(identical(other.book, book) || other.book == book)&&(identical(other.isAudiobookCorrectlyDownloaded, isAudiobookCorrectlyDownloaded) || other.isAudiobookCorrectlyDownloaded == isAudiobookCorrectlyDownloaded)&&(identical(other.audiobook, audiobook) || other.audiobook == audiobook)&&(identical(other.reader, reader) || other.reader == reader));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,isAudiobookCorrectlyDownloaded,audiobook,reader);

@override
String toString() {
  return 'OfflineBookModel(book: $book, isAudiobookCorrectlyDownloaded: $isAudiobookCorrectlyDownloaded, audiobook: $audiobook, reader: $reader)';
}


}

/// @nodoc
abstract mixin class _$OfflineBookModelCopyWith<$Res> implements $OfflineBookModelCopyWith<$Res> {
  factory _$OfflineBookModelCopyWith(_OfflineBookModel value, $Res Function(_OfflineBookModel) _then) = __$OfflineBookModelCopyWithImpl;
@override @useResult
$Res call({
 BookModel book, bool isAudiobookCorrectlyDownloaded, AudiobookModel? audiobook, ReaderBookModel? reader
});


@override $BookModelCopyWith<$Res> get book;@override $AudiobookModelCopyWith<$Res>? get audiobook;

}
/// @nodoc
class __$OfflineBookModelCopyWithImpl<$Res>
    implements _$OfflineBookModelCopyWith<$Res> {
  __$OfflineBookModelCopyWithImpl(this._self, this._then);

  final _OfflineBookModel _self;
  final $Res Function(_OfflineBookModel) _then;

/// Create a copy of OfflineBookModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? isAudiobookCorrectlyDownloaded = null,Object? audiobook = freezed,Object? reader = freezed,}) {
  return _then(_OfflineBookModel(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as BookModel,isAudiobookCorrectlyDownloaded: null == isAudiobookCorrectlyDownloaded ? _self.isAudiobookCorrectlyDownloaded : isAudiobookCorrectlyDownloaded // ignore: cast_nullable_to_non_nullable
as bool,audiobook: freezed == audiobook ? _self.audiobook : audiobook // ignore: cast_nullable_to_non_nullable
as AudiobookModel?,reader: freezed == reader ? _self.reader : reader // ignore: cast_nullable_to_non_nullable
as ReaderBookModel?,
  ));
}

/// Create a copy of OfflineBookModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookModelCopyWith<$Res> get book {
  
  return $BookModelCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}/// Create a copy of OfflineBookModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookModelCopyWith<$Res>? get audiobook {
    if (_self.audiobook == null) {
    return null;
  }

  return $AudiobookModelCopyWith<$Res>(_self.audiobook!, (value) {
    return _then(_self.copyWith(audiobook: value));
  });
}
}

// dart format on
