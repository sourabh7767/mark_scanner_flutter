import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/* Created by Bholendra Singh  */
class ProgressDialog {
  static OverlayEntry? currentLoader;
  static bool isShowing = false;

  static void show(BuildContext context) {
    if (!isShowing) {
      currentLoader = new OverlayEntry(
        builder: (context) => GestureDetector(
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getCircularProgressIndicator(),
                ],
              ),
            ),
          ),
          onTap: () {
            // do nothing
          },
        ),
      );
      Overlay.of(context)?.insert(currentLoader!);
      isShowing = true;
    }
  }

  static void hide() {
    if (currentLoader != null) {
      currentLoader!.remove();
      isShowing = false;
      currentLoader = null;
    }
  }

  static getCircularProgressIndicator({double? height, double? width}) {
    if (height == null) {
      height = 40.0;
    }
    if (width == null) {
      width = 40.0;
    }
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: CircularProgressIndicator(),
        height: height,
        width: width,
      ),
    );
  }

  static getErrorWidget() {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: Text("Oops! Something went wrong."),
        height: 40.0,
        width: 40.0,
      ),
    );
  }

  static getNoRecordWidget() {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: Text("No Record(s)"),
      ),
    );
  }
}
