import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adaptive_bottom_action_sheet.dart';

class IosBottomActionSheet implements AdaptiveBottomActionSheet {
  @override
  Future<T?> show<T>(
    BuildContext context, {
    required List<AdaptiveBottomSheetButtonBuilder> actionButtons,
    bool dismissible = true,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) {
        final cancelButtonBuilder = actionButtons.firstWhereOrNull(
          (element) => element.isCancelAction,
        );

        Widget? cancelButton;
        if (cancelButtonBuilder != null) {
          cancelButton = AdaptiveBottomActionSheetButton(Theme.of(context).platform).build(
            context,
            text: cancelButtonBuilder.text,
            onPressed: cancelButtonBuilder.onPressed,
            isDefaultAction: cancelButtonBuilder.isDefaultAction,
            isDestructiveAction: cancelButtonBuilder.isDestructiveAction,
            isCancelAction: cancelButtonBuilder.isCancelAction,
          );
        }

        final items = actionButtons.where((element) => !element.isCancelAction);

        return CupertinoActionSheet(
          actions: List.generate(
            items.length,
            (index) {
              final item = items.elementAt(index);
              return AdaptiveBottomActionSheetButton(Theme.of(context).platform).build(
                context,
                text: item.text,
                onPressed: item.onPressed,
                isDefaultAction: item.isDefaultAction,
                isDestructiveAction: item.isDestructiveAction,
                isCancelAction: item.isCancelAction,
              );
            },
          ),
          cancelButton: cancelButton,
        );
      },
    );
  }
}
