import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_tracker_app/src/core/network/network_module.dart';

part 'remote_data_source.g.dart';

@RestApi()
@lazySingleton
abstract class RemoteDataSource {
  @factoryMethod
  factory RemoteDataSource(@Named(dioClient) Dio dio) = _RemoteDataSource;

  @GET('/tasks')
  Future<HttpResponse> getTasks();

  @POST('/tasks')
  Future<HttpResponse> createTask(@Body() Map<String, dynamic> body);

  @POST('/tasks/{id}')
  Future<HttpResponse> updateTask(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @GET('/comments')
  Future<HttpResponse> getComments(@Query('task_id') String taskId);

  @POST('/comments')
  Future<HttpResponse> addComment(
    @Query('task_id') String taskId,
    @Body() Map<String, dynamic> body,
  );
}
