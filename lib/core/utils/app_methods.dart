import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:easacc_task/core/helpers/logging/app_logger.dart';
import 'package:easacc_task/core/helpers/cache/cache_helper.dart';
import 'package:easacc_task/core/utils/extensions.dart';
import 'package:safe_device/safe_device.dart';

sealed class AppMethods {
  /// todo; use global key context
  // static Future<void> appLaunchUrl({BuildContext? context, required String urlLink}) async {
  //   final url = Uri.parse(urlLink);
  //   if (!await launchUrl(url)) {
  //     if (context?.mounted ?? false) {
  //       context?.showSnackBar('Could not launch $urlLink');
  //     }
  //   }
  // }

  static String formatTimeToHMA(String? timeString) {
    final inputFormat = DateFormat('HH:mm:ss');
    final outputFormat = DateFormat('h:mm a');

    final dateTime = inputFormat.tryParse(timeString ?? '');
    if (dateTime == null) return timeString ?? 'Invalid time';
    return outputFormat.format(dateTime);
  }

  static String formatTime(DateTime time) {
    int hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    // final period = hour >= 12 ? 'PM' : 'AM';

    // convert to 12-hour format
    hour = hour % 12;
    if (hour == 0) hour = 12;

    // return '$hour:$minute $period';
    return '$hour:$minute';
  }

  static String formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        '${date.year}';
  }

  static String convertMinutes(int minutes) {
    if (minutes < 60) {
      return '$minutes ${'LocaleKeys.min.tr()'}'; // Less than an hour, show in minutes
    }

    final int hours = minutes ~/ 60; // Integer division for hours
    final int mins = minutes % 60; // Get remaining minutes

    if (mins == 0) {
      return '$hours:00'; // Show full hours like "1:00"
    } else {
      return "$hours:${mins.toString().padLeft(2, '0')}"; // Format "H:MM"
    }
  }

  static bool isAuthorization() => CacheHelper.get(CacheKeys.token) != null;

  static Future<bool> get isSafeDevice async {
    try {
      final allSafeDeviceChecks = await Future.wait([
        SafeDevice.isJailBroken,
        SafeDevice.isRealDevice,
        SafeDevice.isMockLocation,
        SafeDevice.isOnExternalStorage,
      ]);
      final bool jailBroken = allSafeDeviceChecks[0];
      final bool realDevice = allSafeDeviceChecks[1];
      final bool mockLocation = allSafeDeviceChecks[2];
      final bool onExternalStorage = Platform.isAndroid ? allSafeDeviceChecks[3] : false;
      AppLogger.info(
        '\n'
        'Real Device: $realDevice\n'
        'Rooted Or JailBroken: $jailBroken\n'
        'MockLocation: $mockLocation\n'
        'onExternalStorage: $onExternalStorage',
      );

      return !(jailBroken || mockLocation || !realDevice || onExternalStorage);
    } catch (e) {
      return false;
    }
  }

  static Future<void> changeLanguage(BuildContext context, {required Locale locale}) async {
    await EasyLocalization.of(context)!.setLocale(locale);
    await CacheHelper.save(CacheKeys.currentLanguage, locale.languageCode);
    // DioConsumer().setDioOptions();
  }

  // static String? parseHtmlString(String? htmlString) {
  //   if (htmlString == null) return null;
  //   final dom.Document document = html_parser.parse(htmlString);
  //   return document.body?.text ?? '';
  // }

  static Future<void> logout() async {
    await CacheHelper.remove(CacheKeys.token);
  }

  // static Future<XFile?> pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   return pickedFile;
  // }

  static String planMonth(int? months) {
    if (months == null) return 'No Date';
    if (months >= 12) {
      final int years = months ~/ 12;
      return years == 1 ? 'Yearly' : '$years years';
    }
    return '$months Month${months > 1 ? 's' : ''}';
  }

  static int getCurrentWeekOfMonth(DateTime date) {
    final int day = date.day; // Day of month (1–31)
    if (day <= 7) {
      return 1;
    } else if (day <= 14) {
      return 2;
    } else if (day <= 21) {
      return 3;
    } else if (day <= 28) {
      return 4;
    } else {
      return 4;
    }
  }

  static String? formatDateToYMD(DateTime? date) {
    if (date == null) {
      return null;
    }
    final formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(date);
  }

  static String currentDurationText(Duration duration) {
    final int seconds = duration.inSeconds;
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString()}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  static String formatWorkDate(DateTime? workDate) {
    if (workDate == null) return 'Unknown Date';
    return DateFormat('EEEE, MMM dd').format(workDate);
  }

  static String formatInOutTime(String? checkIn, String? checkOut) {
    final inTime = checkIn != null ? formatCheckInAndOutTime(checkIn) : '--';
    final outTime = checkOut != null ? formatCheckInAndOutTime(checkOut) : '--';
    return 'In: $inTime Out: $outTime';
  }

  static String formatCheckInAndOutTime(String time) {
    try {
      final parsedTime = DateFormat('HH:mm:ss').parse(time);
      return DateFormat('hh:mm a').format(parsedTime);
    } catch (e) {
      return time;
    }
  }

  static String? calculateLateArrival(String? checkIn) {
    if (checkIn == null) return null;

    try {
      final checkInTime = DateFormat('HH:mm:ss').parse(checkIn);
      final standardTime = DateFormat('HH:mm:ss').parse('09:00:00');

      if (checkInTime.isAfter(standardTime)) {
        final difference = checkInTime.difference(standardTime);
        final minutes = difference.inMinutes;

        if (minutes > 0) {
          if (minutes >= 60) {
            final hours = minutes ~/ 60;
            final remainingMinutes = minutes % 60;
            return '${hours}h ${remainingMinutes}m';
          } else {
            return '${minutes}m';
          }
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
