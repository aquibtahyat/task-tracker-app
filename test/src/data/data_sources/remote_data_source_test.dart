import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_tracker_app/src/data/data_sources/remote/remote_data_source.dart';
import 'package:task_tracker_app/src/data/models/comment_model.dart';
import 'package:task_tracker_app/src/data/models/comment_response_model.dart';
import 'package:task_tracker_app/src/data/models/task_model.dart';
import 'package:task_tracker_app/src/data/models/task_response_model.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
  });

  group('RemoteDataSource', () {
    group('getTasks', () {
      test(
        'should return HttpResponse with TaskResponseModel on success',
        () async {
          // Arrange
          final taskModel = TaskModel(
            id: '1',
            content: 'Test Task',
            description: 'Test Description',
            userId: 'user1',
          );
          final taskResponseModel = TaskResponseModel(results: [taskModel]);
          final responseData = {
            'results': [
              {
                'id': '1',
                'content': 'Test Task',
                'description': 'Test Description',
                'userId': 'user1',
              },
            ],
          };
          final httpResponse = HttpResponse(
            responseData,
            Response(
              requestOptions: RequestOptions(path: '/tasks'),
              statusCode: 200,
              data: responseData,
            ),
          );

          when(
            () => mockRemoteDataSource.getTasks(),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await mockRemoteDataSource.getTasks();

          // Assert
          expect(result, isA<HttpResponse>());
          expect(result.data, isA<Map<String, dynamic>>());
          final taskResponse = TaskResponseModel.fromJson(result.data);
          expect(taskResponse, isA<TaskResponseModel>());
          expect(taskResponse.results.length, 1);
          verify(() => mockRemoteDataSource.getTasks()).called(1);
        },
      );

      test('should throw DioException on failure', () async {
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

        // Act & Assert
        expect(
          () => mockRemoteDataSource.getTasks(),
          throwsA(isA<DioException>()),
        );
        verify(() => mockRemoteDataSource.getTasks()).called(1);
      });
    });

    group('createTask', () {
      test(
        'should return HttpResponse with TaskResponseModel on success',
        () async {
          // Arrange
          final taskModel = TaskModel(
            id: '2',
            content: 'New Task',
            description: 'New Description',
            userId: 'user1',
          );
          final responseData = {
            'results': [
              {
                'id': '2',
                'content': 'New Task',
                'description': 'New Description',
                'userId': 'user1',
              },
            ],
          };
          final httpResponse = HttpResponse(
            responseData,
            Response(
              requestOptions: RequestOptions(path: '/tasks'),
              statusCode: 201,
              data: responseData,
            ),
          );
          final requestBody = {
            'content': 'New Task',
            'description': 'New Description',
          };

          when(
            () => mockRemoteDataSource.createTask(any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await mockRemoteDataSource.createTask(requestBody);

          // Assert
          expect(result, isA<HttpResponse>());
          expect(result.data, isA<Map<String, dynamic>>());
          final taskResponse = TaskResponseModel.fromJson(result.data);
          expect(taskResponse, isA<TaskResponseModel>());
          expect(taskResponse.results.length, 1);
          verify(() => mockRemoteDataSource.createTask(requestBody)).called(1);
        },
      );

      test('should throw DioException on failure', () async {
        // Arrange
        final requestBody = {'content': 'New Task'};
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

        // Act & Assert
        expect(
          () => mockRemoteDataSource.createTask(requestBody),
          throwsA(isA<DioException>()),
        );
        verify(() => mockRemoteDataSource.createTask(requestBody)).called(1);
      });
    });

    group('updateTask', () {
      test(
        'should return HttpResponse with TaskResponseModel on success',
        () async {
          // Arrange
          final taskId = '1';
          final taskModel = TaskModel(
            id: taskId,
            content: 'Updated Task',
            description: 'Updated Description',
            userId: 'user1',
          );
          final responseData = {
            'results': [
              {
                'id': taskId,
                'content': 'Updated Task',
                'description': 'Updated Description',
                'userId': 'user1',
              },
            ],
          };
          final httpResponse = HttpResponse(
            responseData,
            Response(
              requestOptions: RequestOptions(path: '/tasks/$taskId'),
              statusCode: 200,
              data: responseData,
            ),
          );
          final requestBody = {
            'content': 'Updated Task',
            'description': 'Updated Description',
          };

          when(
            () => mockRemoteDataSource.updateTask(any(), any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await mockRemoteDataSource.updateTask(
            taskId,
            requestBody,
          );

          // Assert
          expect(result, isA<HttpResponse>());
          expect(result.data, isA<Map<String, dynamic>>());
          final taskResponse = TaskResponseModel.fromJson(result.data);
          expect(taskResponse, isA<TaskResponseModel>());
          expect(taskResponse.results.length, 1);
          verify(
            () => mockRemoteDataSource.updateTask(taskId, requestBody),
          ).called(1);
        },
      );

      test('should throw DioException on failure', () async {
        // Arrange
        final taskId = '1';
        final requestBody = {'content': 'Updated Task'};
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/tasks/$taskId'),
          response: Response(
            requestOptions: RequestOptions(path: '/tasks/$taskId'),
            statusCode: 404,
            statusMessage: 'Not Found',
          ),
        );

        when(
          () => mockRemoteDataSource.updateTask(any(), any()),
        ).thenThrow(dioException);

        // Act & Assert
        expect(
          () => mockRemoteDataSource.updateTask(taskId, requestBody),
          throwsA(isA<DioException>()),
        );
        verify(
          () => mockRemoteDataSource.updateTask(taskId, requestBody),
        ).called(1);
      });
    });

    group('getComments', () {
      test(
        'should return HttpResponse with CommentResponseModel on success',
        () async {
          // Arrange
          final taskId = '1';
          final commentModel = CommentModel(
            id: '1',
            content: 'Test Comment',
            postedUid: 'user1',
          );
          final responseData = {
            'results': [
              {'id': '1', 'content': 'Test Comment', 'postedUid': 'user1'},
            ],
          };
          final httpResponse = HttpResponse(
            responseData,
            Response(
              requestOptions: RequestOptions(path: '/comments'),
              statusCode: 200,
              data: responseData,
            ),
          );

          when(
            () => mockRemoteDataSource.getComments(any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await mockRemoteDataSource.getComments(taskId);

          // Assert
          expect(result, isA<HttpResponse>());
          expect(result.data, isA<Map<String, dynamic>>());
          final commentResponse = CommentResponseModel.fromJson(result.data);
          expect(commentResponse, isA<CommentResponseModel>());
          expect(commentResponse.results.length, 1);
          verify(() => mockRemoteDataSource.getComments(taskId)).called(1);
        },
      );

      test('should throw DioException on failure', () async {
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

        // Act & Assert
        expect(
          () => mockRemoteDataSource.getComments(taskId),
          throwsA(isA<DioException>()),
        );
        verify(() => mockRemoteDataSource.getComments(taskId)).called(1);
      });
    });

    group('addComment', () {
      test(
        'should return HttpResponse with CommentResponseModel on success',
        () async {
          // Arrange
          final taskId = '1';
          final commentModel = CommentModel(
            id: '2',
            content: 'New Comment',
            postedUid: 'user1',
          );
          final responseData = {
            'results': [
              {'id': '2', 'content': 'New Comment', 'postedUid': 'user1'},
            ],
          };
          final httpResponse = HttpResponse(
            responseData,
            Response(
              requestOptions: RequestOptions(path: '/comments'),
              statusCode: 201,
              data: responseData,
            ),
          );
          final requestBody = {'content': 'New Comment'};

          when(
            () => mockRemoteDataSource.addComment(any(), any()),
          ).thenAnswer((_) async => httpResponse);

          // Act
          final result = await mockRemoteDataSource.addComment(
            taskId,
            requestBody,
          );

          // Assert
          expect(result, isA<HttpResponse>());
          expect(result.data, isA<Map<String, dynamic>>());
          final commentResponse = CommentResponseModel.fromJson(result.data);
          expect(commentResponse, isA<CommentResponseModel>());
          expect(commentResponse.results.length, 1);
          verify(
            () => mockRemoteDataSource.addComment(taskId, requestBody),
          ).called(1);
        },
      );

      test('should throw DioException on failure', () async {
        // Arrange
        final taskId = '1';
        final requestBody = {'content': 'New Comment'};
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

        // Act & Assert
        expect(
          () => mockRemoteDataSource.addComment(taskId, requestBody),
          throwsA(isA<DioException>()),
        );
        verify(
          () => mockRemoteDataSource.addComment(taskId, requestBody),
        ).called(1);
      });
    });
  });
}
