import 'package:flutter/material.dart';

class SnackBarUtils {

  static void successMessageBar(
      BuildContext context,
      String message, {

        Color backgroundColor = Colors.green,
        Duration duration = const Duration(seconds: 2),
      }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(

      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20, // below status bar
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration).then((_) => overlayEntry.remove());
  }

  static void errorMessageBar(
      BuildContext context,
      String message, {
        Color backgroundColor = Colors.red,
        Duration duration = const Duration(seconds: 2),
      }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20, // below status bar
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration).then((_) => overlayEntry.remove());
  }



}
