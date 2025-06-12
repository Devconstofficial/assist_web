import 'dart:developer';

import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_images.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderController extends GetxController {
  late final _DataSource dataSource;

  @override
  void onInit() {
    super.onInit();
    dataSource = _DataSource(appointments);
  }

  final appointments =
      <Appointment>[
        Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(hours: 2)),
          subject: "Shooting Stars",
          color: kGreenColor,
          location: "",
          resourceIds: [
            {"userImg": kAvatar2, "name": "User1"},
          ],
        ),
        Appointment(
          startTime: DateTime.now().add(Duration(days: 2)),
          endTime: DateTime.now()
              .add(Duration(days: 2))
              .add(Duration(hours: 3)),
          subject: "Astronomy Binoculars A Great Alternative",
          color: kYellow1Color,
          location: "",
          resourceIds: [
            {"userImg": kAvatar2, "name": "User1"},
            {"userImg": kAvatar2, "name": "User2"},
          ],
        ),
        Appointment(
          startTime: DateTime.now().add(Duration(days: 1)),
          endTime: DateTime.now()
              .add(Duration(days: 1))
              .add(Duration(hours: 1)),
          subject: "The Amazing Hubble",
          color: kOrangeColor,
          location: "",
          resourceIds: [
            {"userImg": kAvatar2, "name": "User1"},
            {"userImg": kAvatar2, "name": "User2"},
            {"userImg": kAvatar2, "name": "User3"},
          ],
        ),
      ].obs;

  var members =
      [
        {"userImg": kAvatar2, "name": "User1"},
        {"userImg": kAvatar2, "name": "User2"},
        {"userImg": kAvatar2, "name": "User3"},
        {"userImg": kAvatar2, "name": "User4"},
      ].obs;

  void addEvent(Appointment appointment) {
    appointments.add(appointment);
    log("$appointment");
    appointments.refresh();
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }

  void notify() {
    notifyListeners(CalendarDataSourceAction.reset, appointments!);
  }
}
