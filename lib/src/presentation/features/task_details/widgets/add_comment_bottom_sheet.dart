import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:task_tracker_app/src/core/utils/widgets/loading_widget.dart';
import 'package:task_tracker_app/src/domain/entities/add_comment_request_entity.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/manager/add_comment/add_comment_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/manager/get_comments/get_comments_cubit.dart';

class AddCommentBottomSheet extends StatefulWidget {
  const AddCommentBottomSheet({super.key, required this.taskId});

  final String taskId;

  @override
  State<AddCommentBottomSheet> createState() => _AddCommentBottomSheetState();
}

class _AddCommentBottomSheetState extends State<AddCommentBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCommentCubit, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          Navigator.of(context).pop();
          _getComments();
        } else if (state is FailureState) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoadingState;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.surfaceBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comment',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 24),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                    ),
                    maxLength: 50,
                    maxLines: 4,
                    minLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'You didn\'t write anything';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onCommentSubmitted,
                    child: isLoading
                        ? const LoadingWidget()
                        : const Text(
                            'Comment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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

  Future<void> _getComments() async {
    context.read<GetCommentsCubit>().getComments(widget.taskId);
  }

  void _onCommentSubmitted() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      context.read<AddCommentCubit>().addComment(
        AddCommentRequestEntity(
          taskId: widget.taskId,
          content: _commentController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
