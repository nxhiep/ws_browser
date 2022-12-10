
import 'package:flutter/material.dart';

class AutoListView extends StatefulWidget {

  final Widget child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  const AutoListView({Key? key, required this.child, this.onLoadMore, this.onRefresh }) : super(key: key);

  @override
  State<AutoListView> createState() => _AutoListViewState();
}

class _AutoListViewState extends State<AutoListView> {

  double maxScrollExtent = 0;

  @override
  void initState() {
    super.initState();
    maxScrollExtent = 0;
  }

  @override
  Widget build(BuildContext context) {
    bool requesting = false;
    return RefreshIndicator(
      onRefresh: () async => widget.onRefresh?.call(),
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification && notification.metrics.axis == Axis.vertical) {
            if(maxScrollExtent == 0) {
              maxScrollExtent = notification.metrics.maxScrollExtent;
            }
            if((notification.metrics.pixels % maxScrollExtent) / maxScrollExtent > 0.8) {
              if(!requesting) {
                requesting = true;
                widget.onLoadMore?.call();
                Future.delayed(const Duration(seconds: 2), () => requesting = false);
              }
            }
          }
          return false;
        },
        child: widget.child,
      )
    );
  }
}