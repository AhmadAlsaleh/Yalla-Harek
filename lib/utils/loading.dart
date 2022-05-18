import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Loading {
  BuildContext context;
  Function action;

  Loading({
    required this.context,
    required this.action,
  });

  startAction() async {
    await action();
  }

  showLoadingWithAction() async {
    showDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
        });
    await action();
  }

  static bool _isImage(String url) =>
      url.contains('.png') || url.contains('.jpg') || url.contains('.jpeg');

  static Widget imageWithLoader(BuildContext context, String? url) {
    try {
      url = url ?? '';
      if (!_isImage(url) || url.endsWith("storage")) {
        return const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: Icon(Icons.error),
          ),
        );
      }
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        placeholder: (context, url) => Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: Icon(Icons.error),
          ),
        ),
      );
    } catch (e) {
      return const Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: Icon(Icons.error),
        ),
      );
    }
  }
}
