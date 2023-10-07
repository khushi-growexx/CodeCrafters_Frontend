import 'package:flutter/material.dart';

class LoaderButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  const LoaderButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = AnimatedSwitcher(
        key: UniqueKey(),
        duration: const Duration(microseconds: 300),
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(label));

    return SelectionContainer.disabled(
      child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (onPressed != null && !loading) {
              onPressed!();
            }
          },
          child: child),
    );
  }
}
