import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/models/event_model.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/services/event_service.dart';
import 'package:assist_web/services/user_service.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderController extends GetxController {
  final EventService _service = EventService();
  final UserService _userService = UserService();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  var isLoadingEvents = false.obs;
  var isErrorEvents = false.obs;
  var errorMsgEvents = "".obs;
  late final DataSource dataSource;
  RxList<UserModel> allUsers = <UserModel>[].obs;
  RxList<EventModel> allEvents = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getEvents();
    getUsers();
  }

  void getEvents() async {
    try {
      isLoadingEvents(true);
      var result = await _service.getEvents();

      if (result is List<EventModel>) {
        allEvents.assignAll(result);
        isErrorEvents(false);
        errorMsgEvents.value = '';
        final List<Appointment> generatedAppointments =
            allEvents.map((event) {
              return Appointment(
                startTime: event.date.copyWith(hour: event.startTime),
                endTime: event.date.copyWith(hour: event.endTime),
                subject: event.eventTitle,
                notes: event.notes,
                location: event.place,
                color: kPrimaryColor,
                resourceIds:
                    event.members.map((member) => member.userImage).toList(),
              );
            }).toList();
        dataSource = DataSource(generatedAppointments);
        update();
        isLoadingEvents(false);
        return;
      } else {
        isLoadingEvents(false);
        isErrorEvents(true);
        errorMsgEvents.value = result.toString();
      }
    } catch (e) {
      isLoadingEvents(false);
      isErrorEvents(true);
      errorMsgEvents.value = e.toString();
    }
  }

  void getUsers() async {
    try {
      isLoading(true);
      var result = await _userService.getUsers();
      isLoading(false);
      if (result is List<UserModel>) {
        allUsers.assignAll(result);
        isError(false);
        errorMsg.value = '';
        return;
      } else {
        isError(true);
        errorMsg.value = result.toString();
      }
    } catch (e) {
      isLoading(false);
      isError(true);
      errorMsg.value = e.toString();
    }
  }

  void addEvent({required Map<String, dynamic> body}) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      var result = await _service.addEvent(body: body);
      Get.back();
      if (result is bool) {
        Get.back();
        getEvents();
        showCustomSnackbar(
          "Success",
          "Event added Successfully",
          backgroundColor: Colors.green,
        );
        return;
      } else {
        showCustomSnackbar("Error", result.toString());
      }
    } catch (e) {
      Get.back();
      showCustomSnackbar("Error", e.toString());
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }

  void notify() {
    notifyListeners(CalendarDataSourceAction.reset, appointments!);
  }
}
