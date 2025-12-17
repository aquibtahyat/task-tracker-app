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
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/data_sources/cache/cache_service.dart' as _i789;
import '../../data/data_sources/remote/remote_data_source.dart' as _i103;
import '../../data/repositories/task_repository_impl.dart' as _i337;
import '../../domain/repositories/task_repository.dart' as _i250;
import '../../domain/use_cases/add_comment.dart' as _i923;
import '../../domain/use_cases/create_task.dart' as _i786;
import '../../domain/use_cases/get_comments.dart' as _i1022;
import '../../domain/use_cases/get_tasks.dart' as _i679;
import '../../domain/use_cases/update_task.dart' as _i407;
import '../../presentation/features/task_board/manager/get_tasks/get_tasks_cubit.dart'
    as _i559;
import '../../presentation/features/task_board/manager/task_manager/task_manager_cubit.dart'
    as _i88;
import '../../presentation/features/task_board/manager/timer_tracker/time_tracker_cubit.dart'
    as _i487;
import '../../presentation/features/task_details/manager/add_comment/add_comment_cubit.dart'
    as _i485;
import '../../presentation/features/task_details/manager/get_comments/get_comments_cubit.dart'
    as _i862;
import '../../presentation/features/task_form/manager/task_form/task_form_cubit.dart'
    as _i739;
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
    gh.lazySingleton<_i789.CacheService>(
      () => _i789.SharedPreferencesService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i103.RemoteDataSource>(
      () => _i103.RemoteDataSource(gh<_i361.Dio>(instanceName: 'DIOCLIENT')),
    );
    gh.lazySingleton<_i250.TaskRepository>(
      () => _i337.TaskRepositoryImpl(gh<_i103.RemoteDataSource>()),
    );
    gh.factory<_i923.AddCommentUseCase>(
      () => _i923.AddCommentUseCase(gh<_i250.TaskRepository>()),
    );
    gh.factory<_i407.UpdateTaskUseCase>(
      () => _i407.UpdateTaskUseCase(gh<_i250.TaskRepository>()),
    );
    gh.factory<_i786.CreateTaskUseCase>(
      () => _i786.CreateTaskUseCase(gh<_i250.TaskRepository>()),
    );
    gh.factory<_i1022.GetCommentsUseCase>(
      () => _i1022.GetCommentsUseCase(gh<_i250.TaskRepository>()),
    );
    gh.factory<_i679.GetTasksUseCase>(
      () => _i679.GetTasksUseCase(gh<_i250.TaskRepository>()),
    );
    gh.factory<_i487.TimeTrackerCubit>(
      () => _i487.TimeTrackerCubit(gh<_i789.CacheService>()),
    );
    gh.factory<_i739.TaskFormCubit>(
      () => _i739.TaskFormCubit(
        gh<_i786.CreateTaskUseCase>(),
        gh<_i407.UpdateTaskUseCase>(),
      ),
    );
    gh.factory<_i88.TaskManagerCubit>(
      () => _i88.TaskManagerCubit(gh<_i407.UpdateTaskUseCase>()),
    );
    gh.factory<_i862.GetCommentsCubit>(
      () => _i862.GetCommentsCubit(gh<_i1022.GetCommentsUseCase>()),
    );
    gh.factory<_i485.AddCommentCubit>(
      () => _i485.AddCommentCubit(gh<_i923.AddCommentUseCase>()),
    );
    gh.factory<_i559.GetTasksCubit>(
      () => _i559.GetTasksCubit(gh<_i679.GetTasksUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
