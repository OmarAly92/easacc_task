sealed class TimeHelpers {
  /// Parse "HH:mm[:ss]" (e.g., "17:00:00" or "17:00") into hour/minute/second.
  static ({int h, int m, int s}) _parseHms(String time) {
    final re = RegExp(r'^(\d{1,2}):(\d{2})(?::(\d{2}))?$');
    final mch = re.firstMatch(time.trim());
    if (mch == null) {
      throw const FormatException('Time must be "HH:mm" or "HH:mm:ss"');
    }
    final h = int.parse(mch.group(1)!);
    final m = int.parse(mch.group(2)!);
    final s = int.parse(mch.group(3) ?? '0');
    if (h < 0 || h > 23 || m < 0 || m > 59 || s < 0 || s > 59) {
      throw FormatException('Invalid time: $time');
    }
    return (h: h, m: m, s: s);
  }

  /// Remaining time until the next occurrence of [endStr] (HH:mm[:ss]), using now as the start.
  static Duration remainingFromNowUntil(String endStr, [DateTime? now]) {
    now ??= DateTime.now();
    final t = _parseHms(endStr);

    // Build a DateTime for today's occurrence of the end time.
    DateTime end = DateTime(now.year, now.month, now.day, t.h, t.m, t.s);

    // If the end time has already passed today, move it to tomorrow:contentReference[oaicite:2]{index=2}.
    if (end.isBefore(now)) {
      end = end.add(const Duration(days: 1));
    }

    // difference() returns a Duration that may be negative if the second argument is after this DateTime:contentReference[oaicite:3]{index=3}.
    // Here it will always be >= zero because we adjusted for cross‑midnight.
    return end.difference(now);
  }

  /// Remaining hours as a floating‑point number between now and [endStr].
  static double remainingHoursFromNow(String endStr, [DateTime? now]) {
    final duration = remainingFromNowUntil(endStr, now);
    return duration.inMinutes / 60.0;
  }

  /// Remaining fraction (0..1) of today's window from midnight → [endStr].
  /// If we are at/after [endStr], returns 0.0.
  static double remainingFromNowUntilPercent(String endStr, [DateTime? now]) {
    now ??= DateTime.now();
    final t = _parseHms(endStr);

    // Midnight of the current day.
    final midnight = DateTime(now.year, now.month, now.day);

    // Build DateTime for end time today.
    DateTime end = DateTime(now.year, now.month, now.day, t.h, t.m, t.s);

    // If end has already passed, roll it over to tomorrow:contentReference[oaicite:0]{index=0}.
    if (end.isBefore(now)) {
      end = end.add(const Duration(days: 1));
    }

    final totalSecs = end.difference(midnight).inSeconds;
    if (totalSecs <= 0) return 0.0; // Guard against invalid windows.

    // If we are at/after end, nothing remains.
    if (!now.isBefore(end)) return 0.0;

    final remainingSecs = end.difference(now).inSeconds;
    return remainingSecs / totalSecs;
  }

  /// Finished fraction (0..1) of today's window from midnight → [endStr].
  static double finishedFromNowUntilPercent(String endStr, [DateTime? now]) {
    // The finished portion is simply 1.0 minus the remaining portion.
    return 1.0 - remainingFromNowUntilPercent(endStr, now);
  }

  /// Calculates hours worked from start time until now, handling overnight shifts.
  static int finishedHoursFromStartUntilNow(
    String startStr,
    String endStr, [
    DateTime? now,
  ]) {
    now ??= DateTime.now();
    final startTime = _parseHms(startStr);
    final endTime = _parseHms(endStr);

    // Build DateTime for start time today
    DateTime start = DateTime(
      now.year,
      now.month,
      now.day,
      startTime.h,
      startTime.m,
      startTime.s,
    );
    DateTime end = DateTime(
      now.year,
      now.month,
      now.day,
      endTime.h,
      endTime.m,
      endTime.s,
    );

    // Handle overnight shifts (e.g., 17:00 -> 09:00 next day)
    if (end.isBefore(start)) {
      end = end.add(const Duration(days: 1));
    }

    // If current time is before start time, check if it's an overnight shift continuation
    if (now.isBefore(start)) {
      // Check if we're in the second part of an overnight shift (after midnight)
      if (end.day > start.day && now.hour <= endTime.h) {
        // We're in the morning part of overnight shift
        start = start.subtract(const Duration(days: 1));
      } else {
        // Work hasn't started yet
        return 0;
      }
    }

    // Calculate worked hours from start until now
    final workedDuration = now.difference(start);
    return workedDuration.inHours.clamp(0, 24); // Clamp to reasonable range
  }

  /// Calculates percentage of shift completed from start time to end time.
  static double finishedShiftPercent(
    String startStr,
    String endStr, [
    DateTime? now,
  ]) {
    now ??= DateTime.now();
    final startTime = _parseHms(startStr);
    final endTime = _parseHms(endStr);

    // Build DateTime for start and end times
    DateTime start = DateTime(
      now.year,
      now.month,
      now.day,
      startTime.h,
      startTime.m,
      startTime.s,
    );
    DateTime end = DateTime(
      now.year,
      now.month,
      now.day,
      endTime.h,
      endTime.m,
      endTime.s,
    );

    // Handle overnight shifts
    if (end.isBefore(start)) {
      end = end.add(const Duration(days: 1));
    }

    // If current time is before start, check for overnight shift continuation
    if (now.isBefore(start)) {
      if (end.day > start.day && now.hour <= endTime.h) {
        start = start.subtract(const Duration(days: 1));
      } else {
        return 0.0; // Work hasn't started
      }
    }

    // If current time is after end, return 100%
    if (now.isAfter(end)) {
      return 1.0;
    }

    final totalShiftDuration = end.difference(start);
    final elapsedDuration = now.difference(start);

    if (totalShiftDuration.inSeconds <= 0) return 0.0;

    return (elapsedDuration.inSeconds / totalShiftDuration.inSeconds).clamp(
      0.0,
      1.0,
    );
  }
}

/// Optional HH:mm:ss formatter for nice display.
extension PrettyDuration on Duration {
  String get hhmmss {
    final s = inSeconds.abs();
    final h = s ~/ 3600;
    final m = (s % 3600) ~/ 60;
    final sec = s % 60;
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(h)}:${two(m)}:${two(sec)}';
  }
}
