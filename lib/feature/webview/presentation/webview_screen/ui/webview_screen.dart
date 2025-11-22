import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easacc_task/core/app_themes/colors/app_colors.dart';
import 'package:easacc_task/core/app_themes/text_style/app_text_style.dart';
import 'package:easacc_task/core/utils/app_assets.dart';
import 'package:easacc_task/core/widgets/main_widgets/app_text.dart';
import 'package:easacc_task/core/widgets/main_widgets/primary_button.dart';
import 'package:easacc_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:easacc_task/core/widgets/package_widgets/app_svg_image.dart';
import 'package:easacc_task/feature/settings/presentation/settings_screen/logic/settings_cubit.dart';
import 'package:easacc_task/feature/webview/presentation/webview_screen/logic/webview_cubit.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? _webViewController;
  bool _canGoBack = false;
  bool _canGoForward = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<WebViewCubit>().loadUrl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is UrlSavedState) {
          context.read<WebViewCubit>().loadUrl();
          _webViewController?.reload();
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: BlocBuilder<WebViewCubit, WebViewState>(
          builder: (context, state) {
            if (state is WebViewLoadingState) {
              return _buildLoadingWidget();
            }

            if (state is WebViewNoUrlState) {
              return _buildNoUrlWidget();
            }

            if (state is WebViewErrorState) {
              return _buildErrorWidget(state.failure.message);
            }

            if (state is WebViewUrlLoadedState ||
                state is WebViewPageLoadingState ||
                state is WebViewPageLoadedState) {
              final url = context.read<WebViewCubit>().currentUrl;
              if (url == null) return _buildNoUrlWidget();
              return _buildWebView(url);
            }

            return _buildLoadingWidget();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: AppText('WebView', style: AppTextStyle.style18Bold),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            context.read<WebViewCubit>().loadUrl();
            _webViewController?.reload();
          },
          icon: AppSvgImage(
            AppAsset.refreshIcon,
            width: 24.w,
            height: 24.h,
            color: AppColors.zn700,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_isLoading ? 4.h : 0),
        child: _isLoading
            ? LinearProgressIndicator(
                backgroundColor: AppColors.zn200,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: SpinKitFadingCircle(color: AppColors.primaryColor, size: 50.sp),
    );
  }

  Widget _buildNoUrlWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvgImage(
              AppAsset.webviewInactiveIcon,
              width: 80.w,
              height: 80.h,
              color: AppColors.zn300,
            ),
            const VerticalSpace(24),
            AppText(
              'No URL Configured',
              style: AppTextStyle.style20Bold.copyWith(color: AppColors.zn700),
            ),
            const VerticalSpace(12),
            AppText(
              'Please go to Settings and configure a website URL to display here.',
              style: AppTextStyle.style14Regular.copyWith(color: AppColors.zn400),
              textAlign: TextAlign.center,
            ),
            const VerticalSpace(32),
            PrimaryButton(
              text: 'Go to Settings',
              onPressed: () {
                // Navigate to settings tab
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80.sp, color: Colors.red.shade300),
            const VerticalSpace(24),
            AppText(
              'Failed to Load Page',
              style: AppTextStyle.style20Bold.copyWith(color: AppColors.zn700),
            ),
            const VerticalSpace(12),
            AppText(
              message,
              style: AppTextStyle.style14Regular.copyWith(color: AppColors.zn400),
              textAlign: TextAlign.center,
            ),
            const VerticalSpace(32),
            PrimaryButton(
              text: 'Try Again',
              onPressed: () {
                context.read<WebViewCubit>().loadUrl();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebView(String url) {
    return RefreshIndicator(
      onRefresh: () async {
        await _webViewController?.reload();
      },
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(url)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              useHybridComposition: true,
            ),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() => _isLoading = true);
              context.read<WebViewCubit>().setLoading();
            },
            onLoadStop: (controller, url) async {
              setState(() => _isLoading = false);
              context.read<WebViewCubit>().setLoaded();
              _canGoBack = await controller.canGoBack();
              _canGoForward = await controller.canGoForward();
              setState(() {});
            },
            onReceivedError: (controller, request, error) {
              context.read<WebViewCubit>().setError(error.description);
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                setState(() => _isLoading = false);
              }
            },
          ),
          if (_webViewController != null)
            Positioned(
              bottom: 16.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: _canGoBack ? () => _webViewController?.goBack() : null,
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 20.sp,
                          color: _canGoBack ? AppColors.primaryColor : AppColors.zn300,
                        ),
                      ),
                      IconButton(
                        onPressed: _canGoForward ? () => _webViewController?.goForward() : null,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                          color: _canGoForward ? AppColors.primaryColor : AppColors.zn300,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _webViewController?.reload(),
                        icon: Icon(Icons.refresh, size: 20.sp, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
