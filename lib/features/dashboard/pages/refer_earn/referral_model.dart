class ReferralModel {
  final String email;
  final String date;
  final String status; // 'Pending', 'Completed', 'Active'
  final String statusMessage;

  ReferralModel({
    required this.email,
    required this.date,
    required this.status,
    required this.statusMessage,
  });
}
