import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_tracker_app/src/core/base/result.dart';
import 'package:task_tracker_app/src/data/data_sources/remote/remote_data_source.dart';
import 'package:task_tracker_app/src/data/models/comment_model.dart';
import 'package:task_tracker_app/src/data/models/comment_response_model.dart';
import 'package:task_tracker_app/src/data/models/task_model.dart';
import 'package:task_tracker_app/src/data/models/task_response_model.dart';
import 'package:task_tracker_app/src/data/repositories/task_repository_impl.dart';
import 'package:task_tracker_app/src/domain/entities/add_comment_request_entity.dart';
import 'package:task_tracker_app/src/domain/entities/comment_entity.dart';
import 'package:task_tracker_app/src/domain/entities/create_task_request_entity.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

class ModelMocks {
  static TaskModel createTaskModel({
    String? id,
    String? content,
    String? description,
    String? userId,
    List<String>? labels,
  }) {
    return TaskModel(
      id: id ?? '1',
      content: content ?? 'Test Task',
      description: description ?? 'Test Description',
      userId: userId ?? 'user1',
      labels: labels,
      projectId: 'project1',
      sectionId: 'section1',
      checked: false,
      isDeleted: false,
      priority: 1,
    );
  }

  static CommentModel createCommentModel({
    String? id,
    String? content,
    String? postedUid,
  }) {
    return CommentModel(
      id: id ?? '1',
      content: content ?? 'Test Comment',
      postedUid: postedUid ?? 'user1',
      isDeleted: false,
    );
  }

  static TaskResponseModel createTaskResponseModel({List<TaskModel>? tasks}) {
    return TaskResponseModel(results: tasks ?? [createTaskModel()]);
  }

  static CommentResponseModel createCommentResponseModel({
    List<CommentModel>? comments,
  }) {
    return CommentResponseModel(results: comments ?? [createCommentModel()]);
  }

  static Map<String, dynamic> createTaskJson({
    String? id,
    String? content,
    String? description,
    String? userId,
    List<String>? labels,
  }) {
    return {
      'id': id ?? '1',
      'content': content ?? 'Test Task',
      'description': description ?? 'Test Description',
      'userId': userId ?? 'user1',
      'labels': labels ?? [],
      'projectId': 'project1',
      'sectionId': 'section1',
      'checked': false,
      'isDeleted': false,
      'priority': 1,
    };
  }

  static Map<String, dynamic> createCommentJson({
    String? id,
    String? content,
    String? postedUid,
  }) {
    return {
      'id': id ?? '1',
      'content': content ?? 'Test Comment',
      'postedUid': postedUid ?? 'user1',
      'isDeleted': false,
    };
  }

  static Map<String, dynamic> createTaskResponseJson({
    List<Map<String, dynamic>>? tasks,
  }) {
    return {
      'results': tasks ?? [createTaskJson()],
    };
  }

  static Map<String, dynamic> createCommentResponseJson({
    List<Map<String, dynamic>>? comments,
  }) {
    return {
      'results': comments ?? [createCommentJson()],
    };
  }

  static HttpResponse createHttpResponse({
    required Map<String, dynamic> data,
    int statusCode = 200,
  }) {
    return HttpResponse(
      data,
      Response(
        requestOptions: RequestOptions(path: '/'),
        statusCode: statusCode,
        data: data,
      ),
    );
  }
}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late TaskRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = TaskRepositoryImpl(mockRemoteDataSource);
  });

  group('TaskRepositoryImpl', () {
    group('getTasks', () {
      test(
        'should return Success with List<TaskEntity> when data source succeeds',
        () async {
          // Arrange
          final taskJson = ModelMocks.createTaskJson();
          final responseData = ModelMocks.createTaskResponseJson();
          final httpResponse = ModelMocks.createHttpResponse(
            data: responseData,
          );

          when(
            () => mockRemoteDataSource.getTasks(),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.getTasks();

          // Assert
          expect(result, isA<Success<List<TaskEntity>>>());
          expect(result.isSuccess, isTrue);
          expect(result.data, isNotNull);
          expect(result.data, isA<List<TaskEntity>>());
          expect(result.data!.length, 1);
          expect(result.data!.first.id, '1');
          verify(() => mockRemoteDataSource.getTasks()).called(1);
        },
      );

      test(
        'should return Success with empty list when response has no tasks',
        () async {
          // Arrange
          final responseData = {'results': []};
          final httpResponse = ModelMocks.createHttpResponse(
            data: responseData,
          );

          when(
            () => mockRemoteDataSource.getTasks(),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.getTasks();

          // Assert
          expect(result, isA<Success<List<TaskEntity>>>());
          expect(result.isSuccess, isTrue);
          expect(result.data, isNotNull);
          expect(result.data, isEmpty);
          verify(() => mockRemoteDataSource.getTasks()).called(1);
        },
      );

      test(
        'should return Success with multiple tasks when response has multiple tasks',
        () async {
          // Arrange
          final tasks = [
            ModelMocks.createTaskJson(id: '1', content: 'Task 1'),
            ModelMocks.createTaskJson(id: '2', content: 'Task 2'),
            ModelMocks.createTaskJson(id: '3', content: 'Task 3'),
          ];
          final responseData = ModelMocks.createTaskResponseJson(tasks: tasks);
          final httpResponse = ModelMocks.createHttpResponse(
            data: responseData,
          );

          when(
            () => mockRemoteDataSource.getTasks(),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.getTasks();

          // Assert
          expect(result, isA<Success<List<TaskEntity>>>());
          expect(result.isSuccess, isTrue);
          expect(result.data, isNotNull);
          expect(result.data!.length, 3);
          verify(() => mockRemoteDataSource.getTasks()).called(1);
        },
      );

      test(
        'should return Failure when data source throws DioException',
        () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: '/tasks'),
            response: Response(
              requestOptions: RequestOptions(path: '/tasks'),
              statusCode: 500,
              statusMessage: 'Internal Server Error',
            ),
          );

          when(() => mockRemoteDataSource.getTasks()).thenThrow(dioException);

          // Act
          final result = await repository.getTasks();

          // Assert
          expect(result, isA<Failure<List<TaskEntity>>>());
          expect(result.isFailure, isTrue);
          expect(result.message, isNotNull);
          expect(result.data, isNull);
          verify(() => mockRemoteDataSource.getTasks()).called(1);
        },
      );

      test(
        'should return Failure when data source throws generic Exception',
        () async {
          // Arrange
          when(
            () => mockRemoteDataSource.getTasks(),
          ).thenThrow(Exception('Network error'));

          // Act
          final result = await repository.getTasks();

          // Assert
          expect(result, isA<Failure<List<TaskEntity>>>());
          expect(result.isFailure, isTrue);
          expect(result.message, isNotNull);
          expect(result.data, isNull);
          verify(() => mockRemoteDataSource.getTasks()).called(1);
        },
      );
    });

    group('createTask', () {
      test(
        'should return Success with TaskEntity when data source succeeds',
        () async {
          // Arrange
          final request = CreateTaskRequestEntity(
            content: 'New Task',
            description: 'New Description',
          );
          final taskJson = ModelMocks.createTaskJson(
            id: '2',
            content: 'New Task',
            description: 'New Description',
          );
          final httpResponse = ModelMocks.createHttpResponse(
            data: taskJson,
            statusCode: 201,
          );

          when(
            () => mockRemoteDataSource.createTask(any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.createTask(request);

          // Assert
          expect(result, isA<Success<TaskEntity>>());
          expect(result.isSuccess, isTrue);
          expect(result.data, isNotNull);
          expect(result.data, isA<TaskEntity>());
          verify(() => mockRemoteDataSource.createTask(any())).called(1);
        },
      );

      test('should call data source with correct request body', () async {
        // Arrange
        final request = CreateTaskRequestEntity(
          content: 'New Task',
          description: 'New Description',
          projectId: 'project1',
          priority: 2,
        );
        final taskJson = ModelMocks.createTaskJson();
        final httpResponse = ModelMocks.createHttpResponse(data: taskJson);

        when(
          () => mockRemoteDataSource.createTask(any()),
        ).thenAnswer((_) async => httpResponse);

        // Act
        await repository.createTask(request);

        // Assert
        final captured = verify(
          () => mockRemoteDataSource.createTask(captureAny()),
        ).captured;
        expect(captured.length, 1);
        final requestBody = captured.first as Map<String, dynamic>;
        expect(requestBody['content'], 'New Task');
        expect(requestBody['description'], 'New Description');
        expect(requestBody['project_id'], 'project1');
        expect(requestBody['priority'], 2);
      });

      test(
        'should return Failure when data source throws DioException',
        () async {
          // Arrange
          final request = CreateTaskRequestEntity(content: 'New Task');
          final dioException = DioException(
            requestOptions: RequestOptions(path: '/tasks'),
            response: Response(
              requestOptions: RequestOptions(path: '/tasks'),
              statusCode: 400,
              statusMessage: 'Bad Request',
            ),
          );

          when(
            () => mockRemoteDataSource.createTask(any()),
          ).thenThrow(dioException);

          // Act
          final result = await repository.createTask(request);

          // Assert
          expect(result, isA<Failure<TaskEntity>>());
          expect(result.isFailure, isTrue);
          expect(result.message, isNotNull);
          expect(result.data, isNull);
          verify(() => mockRemoteDataSource.createTask(any())).called(1);
        },
      );
    });

    group('updateTask', () {
      test(
        'should return Success with TaskEntity when data source succeeds',
        () async {
          // Arrange
          final task = TaskEntity(
            id: '1',
            content: 'Updated Task',
            description: 'Updated Description',
            userId: 'user1',
          );
          final taskJson = ModelMocks.createTaskJson(
            id: '1',
            content: 'Updated Task',
            description: 'Updated Description',
          );
          final httpResponse = ModelMocks.createHttpResponse(data: taskJson);

          when(
            () => mockRemoteDataSource.updateTask(any(), any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.updateTask(task);

          // Assert
          expect(result, isA<Success<TaskEntity>>());
          expect(result.isSuccess, isTrue);
          expect(result.data, isNotNull);
          expect(result.data, isA<TaskEntity>());
          verify(() => mockRemoteDataSource.updateTask(any(), any())).called(1);
        },
      );

      test('should call data source with correct task id and body', () async {
        // Arrange
        final task = TaskEntity(
          id: '123',
          content: 'Updated Task',
          description: 'Updated Description',
        );
        final taskJson = ModelMocks.createTaskJson();
        final httpResponse = ModelMocks.createHttpResponse(data: taskJson);

        when(
          () => mockRemoteDataSource.updateTask(any(), any()),
        ).thenAnswer((_) async => httpResponse);

        // Act
        await repository.updateTask(task);

        // Assert
        verify(() => mockRemoteDataSource.updateTask('123', any())).called(1);
      });

      test('should handle null task id by using empty string', () async {
        // Arrange
        final task = TaskEntity(id: null, content: 'Updated Task');
        final taskJson = ModelMocks.createTaskJson();
        final httpResponse = ModelMocks.createHttpResponse(data: taskJson);

        when(
          () => mockRemoteDataSource.updateTask(any(), any()),
        ).thenAnswer((_) async => httpResponse);

        // Act
        await repository.updateTask(task);

        // Assert
        verify(() => mockRemoteDataSource.updateTask('', any())).called(1);
      });

      test(
        'should return Failure when data source throws DioException',
        () async {
          // Arrange
          final task = TaskEntity(id: '1', content: 'Updated Task');
          final dioException = DioException(
            requestOptions: RequestOptions(path: '/tasks/1'),
            response: Response(
              requestOptions: RequestOptions(path: '/tasks/1'),
              statusCode: 404,
              statusMessage: 'Not Found',
            ),
          );

          when(
            () => mockRemoteDataSource.updateTask(any(), any()),
          ).thenThrow(dioException);

          // Act
          final result = await repository.updateTask(task);

          // Assert
          expect(result, isA<Failure<TaskEntity>>());
          expect(result.isFailure, isTrue);
          expect(result.message, isNotNull);
          expect(result.data, isNull);
          verify(() => mockRemoteDataSource.updateTask(any(), any())).called(1);
        },
      );
    });

    group('getComments', () {
      test(
        'should return Success with List<CommentEntity> when data source succeeds',
        () async {
          // Arrange
          final taskId = '1';
          final commentJson = ModelMocks.createCommentJson();
          final responseData = ModelMocks.createCommentResponseJson();
          final httpResponse = ModelMocks.createHttpResponse(
            data: responseData,
          );

          when(
            () => mockRemoteDataSource.getComments(any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.getComments(taskId);

          // Assert
          expect(result, isA<Success<List<CommentEntity>>>());
          expect(result.isSuccess, isTrue);
          expect(result.data, isNotNull);
          expect(result.data, isA<List<CommentEntity>>());
          expect(result.data!.length, 1);
          verify(() => mockRemoteDataSource.getComments(taskId)).called(1);
        },
      );

      test(
        'should return Success with empty list when response has no comments',
        () async {
          // Arrange
          final taskId = '1';
          final responseData = {'results': []};
          final httpResponse = ModelMocks.createHttpResponse(
            data: responseData,
          );

          when(
            () => mockRemoteDataSource.getComments(any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.getComments(taskId);

          // Assert
          expect(result, isA<Success<List<CommentEntity>>>());
          expect(result.isSuccess, isTrue);
          expect(result.data, isNotNull);
          expect(result.data, isEmpty);
          verify(() => mockRemoteDataSource.getComments(taskId)).called(1);
        },
      );

      test(
        'should return Success with multiple comments when response has multiple comments',
        () async {
          // Arrange
          final taskId = '1';
          final comments = [
            ModelMocks.createCommentJson(id: '1', content: 'Comment 1'),
            ModelMocks.createCommentJson(id: '2', content: 'Comment 2'),
          ];
          final responseData = ModelMocks.createCommentResponseJson(
            comments: comments,
          );
          final httpResponse = ModelMocks.createHttpResponse(
            data: responseData,
          );

          when(
            () => mockRemoteDataSource.getComments(any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.getComments(taskId);

          // Assert
          expect(result, isA<Success<List<CommentEntity>>>());
          expect(result.isSuccess, isTrue);
          expect(result.data, isNotNull);
          expect(result.data!.length, 2);
          verify(() => mockRemoteDataSource.getComments(taskId)).called(1);
        },
      );

      test(
        'should return Failure when data source throws DioException',
        () async {
          // Arrange
          final taskId = '1';
          final dioException = DioException(
            requestOptions: RequestOptions(path: '/comments'),
            response: Response(
              requestOptions: RequestOptions(path: '/comments'),
              statusCode: 500,
              statusMessage: 'Internal Server Error',
            ),
          );

          when(
            () => mockRemoteDataSource.getComments(any()),
          ).thenThrow(dioException);

          // Act
          final result = await repository.getComments(taskId);

          // Assert
          expect(result, isA<Failure<List<CommentEntity>>>());
          expect(result.isFailure, isTrue);
          expect(result.message, isNotNull);
          expect(result.data, isNull);
          verify(() => mockRemoteDataSource.getComments(taskId)).called(1);
        },
      );
    });

    group('addComment', () {
      test(
        'should return Success with CommentEntity when data source succeeds',
        () async {
          // Arrange
          final request = AddCommentRequestEntity(
            content: 'New Comment',
            taskId: '1',
          );
          final commentJson = ModelMocks.createCommentJson(
            id: '2',
            content: 'New Comment',
          );
          final httpResponse = ModelMocks.createHttpResponse(
            data: commentJson,
            statusCode: 201,
          );

          when(
            () => mockRemoteDataSource.addComment(any(), any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await repository.addComment(request);

          // Assert
          expect(result, isA<Success<CommentEntity>>());
          expect(result.isSuccess, isTrue);
          expect(result.data, isNotNull);
          expect(result.data, isA<CommentEntity>());
          verify(() => mockRemoteDataSource.addComment(any(), any())).called(1);
        },
      );

      test(
        'should call data source with correct task id and request body',
        () async {
          // Arrange
          final request = AddCommentRequestEntity(
            content: 'New Comment',
            taskId: '123',
          );
          final commentJson = ModelMocks.createCommentJson();
          final httpResponse = ModelMocks.createHttpResponse(data: commentJson);

          when(
            () => mockRemoteDataSource.addComment(any(), any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          await repository.addComment(request);

          // Assert
          final captured = verify(
            () => mockRemoteDataSource.addComment(captureAny(), captureAny()),
          ).captured;
          expect(captured.length, 2);
          final taskId = captured.first as String;
          final requestBody = captured.last as Map<String, dynamic>;
          expect(taskId, '123');
          expect(requestBody['content'], 'New Comment');
          expect(requestBody['task_id'], '123');
        },
      );

      test('should handle null task id by using empty string', () async {
        // Arrange
        final request = AddCommentRequestEntity(
          content: 'New Comment',
          taskId: null,
        );
        final commentJson = ModelMocks.createCommentJson();
        final httpResponse = ModelMocks.createHttpResponse(data: commentJson);

        when(
          () => mockRemoteDataSource.addComment(any(), any()),
        ).thenAnswer((_) async => httpResponse);

        // Act
        await repository.addComment(request);

        // Assert
        verify(() => mockRemoteDataSource.addComment('', any())).called(1);
      });

      test(
        'should return Failure when data source throws DioException',
        () async {
          // Arrange
          final request = AddCommentRequestEntity(
            content: 'New Comment',
            taskId: '1',
          );
          final dioException = DioException(
            requestOptions: RequestOptions(path: '/comments'),
            response: Response(
              requestOptions: RequestOptions(path: '/comments'),
              statusCode: 400,
              statusMessage: 'Bad Request',
            ),
          );

          when(
            () => mockRemoteDataSource.addComment(any(), any()),
          ).thenThrow(dioException);

          // Act
          final result = await repository.addComment(request);

          // Assert
          expect(result, isA<Failure<CommentEntity>>());
          expect(result.isFailure, isTrue);
          expect(result.message, isNotNull);
          expect(result.data, isNull);
          verify(() => mockRemoteDataSource.addComment(any(), any())).called(1);
        },
      );
    });
  });
}
