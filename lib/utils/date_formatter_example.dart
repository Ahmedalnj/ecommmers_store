// Example: How to use DateFormatter in your app
// 
// After signup, you can access the formatted date like this:
//
// import 'package:ecommmers_store/features/controllers/auth_controller.dart';
// import 'package:ecommmers_store/utils/date_formatter.dart';
//
// // In your widget:
// final controller = AuthController();
// 
// // After successful signup, the formatted date is available:
// Text('Account created: ${controller.userCreatedAtFormatted}')
// // Output: "Account created: January 1, 2026 at 10:56 PM"
//
// // Or format any date string directly:
// String myDate = "2026-01-01 22:56:58.826297+00";
// String formatted = DateFormatter.formatDateTime(myDate);
// // Output: "January 1, 2026 at 10:56 PM"
//
// // Display in a widget:
// Text(
//   'Created: ${DateFormatter.formatDateTime(controller.userCreatedAt)}',
//   style: TextStyle(fontSize: 14, color: Colors.grey),
// )

