class SalaryReportFields {
  static final String? id = 'id';
  static final String? name = 'Name';
  static final String? totalSalary = 'TotalSalary';
  static final String? month = 'Month';
  static final String? overtimeDays = 'OverTimeDays';
  static final String? advanceTaken = 'AdvanceTaken';
  static final String? balanceAmount = 'BalanceAmount';

  static List<String> getFields() => [
        id!,
        name!,
        totalSalary!,
        month!,
        overtimeDays!,
        advanceTaken!,
        balanceAmount!,
      ];
}

class SalaryReport {
  final int? id;
  final String? name;
  final double? totalSalary;
  final int? month;
  final int? overtimeDays;
  final double? advanceTaken;
  final double? balanceAmount;

  const SalaryReport({
    this.id,
    required this.name,
    required this.totalSalary,
    required this.month,
    required this.overtimeDays,
    required this.advanceTaken,
    required this.balanceAmount,
  });

  SalaryReport copy({
    int? id,
    String? name,
    double? totalSalary,
    int? month,
    int? overtimeDays,
    double? advanceTaken,
    double? balanceAmount,
  }) =>
      SalaryReport(
        id: id ?? this.id,
        name: name ?? this.name,
        totalSalary: totalSalary ?? this.totalSalary,
        month: month ?? this.month,
        overtimeDays: overtimeDays ?? this.overtimeDays,
        advanceTaken: advanceTaken ?? this.advanceTaken,
        balanceAmount: balanceAmount ?? this.balanceAmount,
      );

  Map<String, dynamic> toJson() => {
        SalaryReportFields.id!: id,
        SalaryReportFields.name!: name,
        SalaryReportFields.totalSalary!: totalSalary,
        SalaryReportFields.month!: month,
        SalaryReportFields.overtimeDays!: overtimeDays,
        SalaryReportFields.advanceTaken!: advanceTaken,
        SalaryReportFields.balanceAmount!: balanceAmount,
      };
}
