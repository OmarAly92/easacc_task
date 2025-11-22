sealed class EndPoints {
  // static const String baseUrl = 'https://hr.thebrandmakerz.com/api/';
  static const String baseUrl = 'https://hrsaas.thebrandmakerz.com/api/';

  static const String refreshToken = '';

  /// HOME
  static const String homeSummary = 'mobile/dashboard/home‐summary';
  static const String attendanceHistory = 'attendance/history';
  static const String checkIn = 'attendance/check-in';
  static const String checkout = 'attendance/check-out';
  static const String attendanceSummary = 'attendance/summary';
  static const String attendanceStatus = 'attendance/status';
  static const String recentActivities = 'mobile/recent-activities';

  /// AUTH
  static const String signup = 'mobile/register';
  static const String login = 'mobile/login';
  static const String forgotPassword = 'forgot-password';
  static const String sendOtp = '/$forgotPassword/send-otp';
  static const String verifyOtp = '/$forgotPassword/verify-otp';
  static const String resetPassword = '/$forgotPassword/reset';

  /// Notification
  static const String getNotification = '/notifications';
  static const String readAllNotifications = '/notifications/mark-all-as-read';

  static String readNotification(int id) => '/notifications/read/$id';

  /// PROFILE
  static const String settings = 'settings';
  static const String faqs = '$settings/faqs';
  static const String terms = '$settings/terms';
  static const String privacy = '$settings/privacy';
  static const String profile = 'mobile/profile/data';
  static const String help = 'settings/faqs';
  static const String changePassword = 'mobile/profile/password';

  /// Request
  static const String leavesOverview = 'leaves/overview';
  static const String earlyLeavesRequest = 'leaves/early-leave';
  static const String getLeavesType = 'leave/leave-types';
  static const String leaveRequest = 'leaves/request';
  static const String loanRequest = 'loans/request';
  static const String getRequestHistory = 'leaves/requests-mobile';

  /// Chat
  static const String sendMessage = 'chat/send';
  static const String getCompanyAdmins = 'mobile/chat-admins';

  static String getMessages(int userId) => 'chat/messages/$userId';

  /// Payroll
  static const String getPayrollMonthlySummary =
      'payroll/mobile/monthly-summary';
  static const String getPayrollPaymentHistory =
      'payroll/mobile/payment-history';
  static const String getLatestPayslipsDetails =
      'payroll/mobile/latest-payslip';

  static String getPayslipsDetails(int id) =>
      'payroll/mobile/payslips/$id/details';
}
