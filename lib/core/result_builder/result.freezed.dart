// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Result<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<T, $Res> {
  factory $ResultCopyWith(Result<T> value, $Res Function(Result<T>) then) =
      _$ResultCopyWithImpl<T, $Res, Result<T>>;
}

/// @nodoc
class _$ResultCopyWithImpl<T, $Res, $Val extends Result<T>>
    implements $ResultCopyWith<T, $Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$initImplCopyWith<T, $Res> {
  factory _$$initImplCopyWith(
          _$initImpl<T> value, $Res Function(_$initImpl<T>) then) =
      __$$initImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$initImplCopyWithImpl<T, $Res>
    extends _$ResultCopyWithImpl<T, $Res, _$initImpl<T>>
    implements _$$initImplCopyWith<T, $Res> {
  __$$initImplCopyWithImpl(
      _$initImpl<T> _value, $Res Function(_$initImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$initImpl<T> implements _init<T> {
  const _$initImpl();

  @override
  String toString() {
    return 'Result<$T>.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$initImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _init<T> implements Result<T> {
  const factory _init() = _$initImpl<T>;
}

/// @nodoc
abstract class _$$LodaingImplCopyWith<T, $Res> {
  factory _$$LodaingImplCopyWith(
          _$LodaingImpl<T> value, $Res Function(_$LodaingImpl<T>) then) =
      __$$LodaingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LodaingImplCopyWithImpl<T, $Res>
    extends _$ResultCopyWithImpl<T, $Res, _$LodaingImpl<T>>
    implements _$$LodaingImplCopyWith<T, $Res> {
  __$$LodaingImplCopyWithImpl(
      _$LodaingImpl<T> _value, $Res Function(_$LodaingImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LodaingImpl<T> implements _Lodaing<T> {
  const _$LodaingImpl();

  @override
  String toString() {
    return 'Result<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LodaingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Lodaing<T> implements Result<T> {
  const factory _Lodaing() = _$LodaingImpl<T>;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<T, $Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl<T> value, $Res Function(_$LoadedImpl<T>) then) =
      __$$LoadedImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<T, $Res>
    extends _$ResultCopyWithImpl<T, $Res, _$LoadedImpl<T>>
    implements _$$LoadedImplCopyWith<T, $Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl<T> _value, $Res Function(_$LoadedImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$LoadedImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$LoadedImpl<T> implements _Loaded<T> {
  const _$LoadedImpl({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'Result<$T>.loaded(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<T, _$LoadedImpl<T>> get copyWith =>
      __$$LoadedImplCopyWithImpl<T, _$LoadedImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded<T> implements Result<T> {
  const factory _Loaded({required final T data}) = _$LoadedImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<T, _$LoadedImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<T, $Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl<T> value, $Res Function(_$ErrorImpl<T>) then) =
      __$$ErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<T, $Res>
    extends _$ResultCopyWithImpl<T, $Res, _$ErrorImpl<T>>
    implements _$$ErrorImplCopyWith<T, $Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl<T> _value, $Res Function(_$ErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl<T> implements _Error<T> {
  const _$ErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'Result<$T>.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      __$$ErrorImplCopyWithImpl<T, _$ErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<T> implements Result<T> {
  const factory _Error({required final String error}) = _$ErrorImpl<T>;

  String get error;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
