part of 'webview_cubit.dart';

sealed class WebViewState extends Equatable {
  const WebViewState();
}

final class WebViewInitialState extends WebViewState {
  const WebViewInitialState();

  @override
  List<Object> get props => [];
}

final class WebViewLoadingState extends WebViewState {
  const WebViewLoadingState();

  @override
  List<Object> get props => [];
}

final class WebViewNoUrlState extends WebViewState {
  const WebViewNoUrlState();

  @override
  List<Object> get props => [];
}

final class WebViewUrlLoadedState extends WebViewState {
  const WebViewUrlLoadedState({required this.url});

  final String url;

  @override
  List<Object> get props => [url];
}

final class WebViewPageLoadingState extends WebViewState {
  const WebViewPageLoadingState();

  @override
  List<Object> get props => [];
}

final class WebViewPageLoadedState extends WebViewState {
  const WebViewPageLoadedState({required this.url});

  final String url;

  @override
  List<Object> get props => [url];
}

final class WebViewErrorState extends WebViewState {
  const WebViewErrorState({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
