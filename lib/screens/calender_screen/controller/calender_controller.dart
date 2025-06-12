import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../custom_widgets/view_profile_dialog.dart';

class CalenderController extends GetxController {

  final appointments = <Appointment>[].obs;

  void addEvent(Appointment appointment) {
    appointments.add(appointment);
    appointments.refresh();
  }
}