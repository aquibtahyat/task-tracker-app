import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/domain/entities/comment_entity.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.comment});

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return comment.content == null
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.only(bottom: 12),
            constraints: const BoxConstraints(minHeight: 60),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.primaryLight,
                  child: const Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    comment.content!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
  }
}
