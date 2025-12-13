// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/remote/remote_data_source.dart' as _i103;
import '../network/network_module.dart' as _i200;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.singleton<_i361.Dio>(
      () => networkModule.getDio(),
      instanceName: 'DIOCLIENT',
    );
    gh.lazySingleton<_i103.RemoteDataSource>(
      () => _i103.RemoteDataSource(gh<_i361.Dio>(instanceName: 'DIOCLIENT')),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
