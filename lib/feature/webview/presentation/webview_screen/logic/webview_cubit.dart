import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easacc_task/core/error_handling/failures/failure.dart';
import 'package:easacc_task/feature/webview/data/repository/webview_repository.dart';

part 'webview_state.dart';

class WebViewCubit extends Cubit<WebViewState> {
  WebViewCubit(this._repository) : super(const WebViewInitialState());
  final WebViewRepository _repository;

  String? _currentUrl;
  String? get currentUrl => _currentUrl;

  void loadUrl() {
    emit(const WebViewLoadingState());

    _currentUrl = _repository.getSavedUrl();

    if (_currentUrl == null || _currentUrl!.isEmpty) {
      emit(const WebViewNoUrlState());
      return;
    }

    String url = _currentUrl!;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
      _currentUrl = url;
    }

    emit(WebViewUrlLoadedState(url: url));
  }

  void setLoading() {
    emit(const WebViewPageLoadingState());
  }

  void setLoaded() {
    emit(WebViewPageLoadedState(url: _currentUrl ?? ''));
  }

  void setError(String message) {
    emit(
      WebViewErrorState(
        failure: ServerFailure(error: message, message: message),
      ),
    );
  }

  void refresh() {
    loadUrl();
  }
}
