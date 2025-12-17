import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:task_tracker_app/src/core/utils/widgets/loading_widget.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/get_tasks/get_tasks_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_form/manager/task_form/task_form_cubit.dart';

class TaskFormPage extends StatefulWidget {
  const TaskFormPage({super.key, this.task});

  final TaskEntity? task;

  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.content ?? '';
      _descriptionController.text = widget.task!.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskFormCubit, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          Navigator.of(context).pop();
          _getTasks();
        } else if (state is FailureState) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoadingState;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(widget.task != null ? 'Edit Task' : 'Create Task'),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            hintText: 'Enter task title',
                          ),
                          maxLength: 30,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter task description',
                            alignLabelWithHint: true,
                          ),
                          maxLength: 80,
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Description is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _onSubmit,
                      child: isLoading
                          ? const LoadingWidget()
                          : Text(
                              widget.task != null
                                  ? 'Update Task'
                                  : 'Create Task',
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _getTasks() async {
    context.read<GetTasksCubit>().getTasks();
  }

  void _onSubmit() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();

      if (widget.task != null) {
        final isTitleChanged = title != (widget.task!.content ?? '');
        final isDescriptionChanged =
            description != (widget.task!.description ?? '');

        if (!isTitleChanged && !isDescriptionChanged) {
          context.showSnackBar('No changes detected');
          return;
        }

        context.read<TaskFormCubit>().editTask(
          widget.task!.copyWith(content: title, description: description),
        );
      } else {
        context.read<TaskFormCubit>().createTask(
          content: title,
          description: description,
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
