// import 'package:googleapis/calendar/v3.dart';
// import 'package:googleapis_auth/auth_io.dart';

// //get Service Account Credentials
// final accountCredentials = new ServiceAccountCredentials.fromJson({
//   "private_key_id": "myprivatekeyid",
//   "private_key": "myprivatekey",
//   "client_email": "myclientemail",
//   "client_id": "myclientid",
//   "type": "service_account"
// });
// var _scopes = [
//   CalendarApi.CalendarScope
// ]; //defines the scopes for the calendar api

// void getCalendarEvents() {
//   clientViaServiceAccount(accountCredentials, _scopes).then((client) {
//     var calendar = new CalendarApi(client);
//     var calEvents = calendar.events.list("primary");
//     calEvents.then((Events events) {
//       events.items.forEach(
//         (Event event) {
//           print(event.summary);
//         },
//       );
//     });
//   });
// }
