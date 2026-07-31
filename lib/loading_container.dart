import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({
    super.key,
    required this.child,
    required this.isLoading,
    this.cover = false,
  });

  Widget get _loadingView => Center(child: CircularProgressIndicator(color: Colors.blue));

  Widget get coverView => Stack(children: [child, isLoading ? _loadingView : Container()]);

  Widget get normalView => isLoading ? _loadingView : child;

  @override
  Widget build(BuildContext context) {
    return cover ? coverView : normalView;
  }
}
