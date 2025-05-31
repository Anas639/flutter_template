import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TodoListItemSkeleton extends StatelessWidget {
  const TodoListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('lorem ipsum' * (Random().nextInt(3) + 1)),
      subtitle: Text(
        'lorem ipsum',
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Skeleton.shade(
        child: Checkbox(
          onChanged: (_) {},
          value: false,
        ),
      ),
    );
  }
}
