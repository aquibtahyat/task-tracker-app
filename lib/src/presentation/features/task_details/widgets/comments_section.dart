import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/utils/widgets/center_message_widget.dart';
import 'package:task_tracker_app/src/core/utils/widgets/loading_widget.dart';
import 'package:task_tracker_app/src/domain/entities/comment_entity.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/manager/get_comments/get_comments_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/widgets/add_comment_bottom_sheet.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/widgets/comment_card.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCommentsCubit, BaseState>(
      builder: (context, state) {
        List<CommentEntity> comments = [];

        if (state is SuccessState) {
          comments = state.data;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comments (${comments.length})',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          AddCommentBottomSheet(taskId: taskId),
                    );
                  },
                  child: Text(
                    'Add Comment',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (state is LoadingState)
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: SizedBox(height: 100, child: LoadingWidget()),
              )
            else if (state is FailureState)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: CenterMessageWidget(message: state.message),
              )
            else if (comments.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: CenterMessageWidget(message: 'No Comment Available'),
              )
            else
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: comments
                    .map((comment) => CommentCard(comment: comment))
                    .toList(),
              ),
          ],
        );
      },
    );
  }
}
