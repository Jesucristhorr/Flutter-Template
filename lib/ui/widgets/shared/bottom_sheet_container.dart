import 'package:flutter/material.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/shared/divider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;
  final String? title;

  const BottomSheetContainer({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Padding(
        padding: EdgeInsets.only(
          left: 4,
          right: 4,
          bottom: 32,
          top: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (title != null)
              Column(
                children: [
                  Center(
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Separator(
                    horizontal: 18,
                  ),
                ],
              ),
            child,
          ],
        ),
      ),
    );
  }
}

void showCustomBottomSheet({
  required BuildContext context,
  required Widget child,
  String? title,
}) {
  // ignore: inference_failure_on_function_invocation
  showMaterialModalBottomSheet(
    bounce: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    builder: (context) => BottomSheetContainer(
      title: title,
      child: child,
    ),
  );
}