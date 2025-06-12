import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/calender_controller.dart';

class CalenderScreen extends GetView<CalenderController> {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // CommonCode.unFocus(context);
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SideMenu(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 23.h,
                          right: 59.w,
                          bottom: 32.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PageHeader(pageName: "Calendar"),
                            SizedBox(height: 19),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                color: kGreyShade9Color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(27),
                                child: SfCalendar(
                                  view: CalendarView.week,
                                  firstDayOfWeek: 1,
                                  todayHighlightColor: kPrimaryColor,
                                  showDatePickerButton: true,
                                  appointmentTextStyle: TextStyle(color: Colors.black),
                                  dataSource: _DataSource(controller.appointments),
                                  onTap: (calendarTapDetails) {
                                    if (calendarTapDetails.targetElement == CalendarElement.calendarCell &&
                                        calendarTapDetails.date != null) {
                                      final selectedDateTime = calendarTapDetails.date!;
                                      Get.dialog(
                                        EventDialog(
                                          initialDateTime: selectedDateTime,
                                          onSave: (title, start, end) {
                                            controller.addEvent(Appointment(
                                              startTime: start,
                                              endTime: end,
                                              subject: title,
                                              color: Colors.deepPurpleAccent,
                                            ));
                                          },
                                        ),
                                      );
                                    }
                                  },

                                )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

class EventDialog extends StatefulWidget {
  final DateTime initialDateTime;
  final Function(String title, DateTime start, DateTime end) onSave;

  const EventDialog({
    super.key,
    required this.initialDateTime,
    required this.onSave,
  });

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  final TextEditingController _titleController = TextEditingController();
  late DateTime _startDateTime;
  late DateTime _endDateTime;

  @override
  void initState() {
    super.initState();
    _startDateTime = widget.initialDateTime;
    _endDateTime = _startDateTime.add(const Duration(hours: 1));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Event'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Event Title'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text("Start: "),
              TextButton(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_startDateTime),
                  );
                  if (picked != null) {
                    setState(() {
                      _startDateTime = DateTime(
                        _startDateTime.year,
                        _startDateTime.month,
                        _startDateTime.day,
                        picked.hour,
                        picked.minute,
                      );
                      // auto adjust end time
                      _endDateTime = _startDateTime.add(const Duration(hours: 1));
                    });
                  }
                },
                child: Text(TimeOfDay.fromDateTime(_startDateTime).format(context)),
              ),
            ],
          ),
          Row(
            children: [
              const Text("End: "),
              TextButton(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_endDateTime),
                  );
                  if (picked != null) {
                    setState(() {
                      _endDateTime = DateTime(
                        _endDateTime.year,
                        _endDateTime.month,
                        _endDateTime.day,
                        picked.hour,
                        picked.minute,
                      );
                    });
                  }
                },
                child: Text(TimeOfDay.fromDateTime(_endDateTime).format(context)),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isNotEmpty) {
              widget.onSave(
                _titleController.text.trim(),
                _startDateTime,
                _endDateTime,
              );
              Get.back();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}


