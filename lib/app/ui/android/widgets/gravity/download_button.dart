import 'package:flutter/widgets.dart';

enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  downloaded,
}

@immutable
class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.status,
    this.transitionDuration = const Duration(
      milliseconds: 500,
    ),
  });

  final DownloadStatus status;
  final Duration transitionDuration;

  @override
  Widget build(BuildContext context) {
    // TODO: We'll add more to this later.
    return const SizedBox();
  }
}