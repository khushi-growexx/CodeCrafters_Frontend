import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FunctionalSheet extends StatelessWidget {
  final String message;
  final String buttonName;
  final Function onPressButton;
  final bool showCancelButton;
  final String cancelButtonTitle;
  final TextAlign? textAlign;

  const FunctionalSheet({
    Key? key,
    required this.message,
    required this.buttonName,
    required this.onPressButton,
    this.showCancelButton = true,
    this.textAlign,
    this.cancelButtonTitle = "CANCEL",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Text(message.toString(),
              textAlign: textAlign ?? TextAlign.center,
              style: theme.textTheme.bodyLarge),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            children: [
              showCancelButton
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: TextButtonTheme(
                          data: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                  minimumSize: const Size(0, 40),
                                  backgroundColor: Colors.grey.shade300,
                                  foregroundColor:
                                      Colors.black.withOpacity(0.85),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      side: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1)),
                                  padding: const EdgeInsets.all(13))),
                          child: TextButton(
                            key: const Key("cancel"),
                            onPressed: () {
                              try {
                                context.pop();
                                // ignore: empty_catches
                              } catch (e) {}
                            },
                            child: Text(cancelButtonTitle),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Expanded(
                child: TextButtonTheme(
                  data: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          minimumSize: const Size(0, 40),
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                              side: const BorderSide(
                                  color: Colors.transparent, width: 1)),
                          padding: const EdgeInsets.all(10))),
                  child: TextButton(
                    key: const Key("function"),
                    onPressed: () {
                      try {
                        context.pop();
                        onPressButton();
                        // ignore: empty_catches
                      } catch (e) {}
                    },
                    child: Text(buttonName.toUpperCase()),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
