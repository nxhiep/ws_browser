import 'dart:async';

import 'package:flutter/material.dart';

mixin SafeState<T extends StatefulWidget> on State<T> {
  String? tempRoute;
  
  FutureOr<void> safeSetState(FutureOr<dynamic> Function() fn) async {
    await fn();
    if (mounted &&
        !context.debugDoingBuild &&
        context.owner?.debugBuilding == false) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(Duration.zero, () async {
      if (mounted) await contextReady();
    });
  }

  @override
  void setState(Function() fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> contextReady() async {}
}
