enum ActivitiesStatusEnum {
  pending,
  approved,
  rejected,
  cancelled;

  static ActivitiesStatusEnum? fromJson(String? value) {
    if (value == null) return null;
    return ActivitiesStatusEnum.values.byName(value.toLowerCase());
  }

  String toJson() => name.toUpperCase();
}

enum EmployeeTypeEnum {
  fixedSchedule,
  hourly,
  exempt;

  static EmployeeTypeEnum? fromJson(String? value) {
    if (value == null) return null;
    if (value == 'FIXED_SCHEDULE') {
      return fixedSchedule;
    }
    return EmployeeTypeEnum.values.byName(value.toLowerCase());
  }

  String toJson() {
    if (name == fixedSchedule.name) {
      return 'FIXED_SCHEDULE';
    }
    return name.toUpperCase();
  }
}

enum PaymentHistoryEnum {
  draft,
  published,
  pending,
  paid;

  String toJson() => name.toUpperCase();

  static PaymentHistoryEnum? fromJson(String? value) {
    if (value == null) return null;
    return PaymentHistoryEnum.values.byName(value.toLowerCase());
  }
}

enum ChatBubbleTypeEnum { text, image, audio, video }
