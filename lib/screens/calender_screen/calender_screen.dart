import 'package:assist_web/custom_widgets/custom_button.dart';
import 'package:assist_web/custom_widgets/custom_error_widget.dart';
import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/screens/calender_screen/select_location_screen.dart';
import 'package:assist_web/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../utils/app_colors.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/calender_controller.dart';

class CalenderScreen extends GetView<CalenderController> {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                              height: height,
                              width: width,
                              padding: EdgeInsets.symmetric(
                                horizontal: 40.w,
                                vertical: 40.h,
                              ),
                              decoration: BoxDecoration(
                                color: kGreyShade9Color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(27),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: kPrimaryColor,
                                        onPrimary: Colors.white,
                                        surface: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                    ),
                                    child: Obx(
                                      () =>
                                          controller.isLoadingEvents.value
                                              ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                              : controller.isErrorEvents.value
                                              ? CustomErrorWidget(
                                                title:
                                                    controller.errorMsg.value,
                                              )
                                              : SfCalendar(
                                                timeSlotViewSettings:
                                                    TimeSlotViewSettings(
                                                      timeIntervalHeight: 80.h,
                                                      timeIntervalWidth: 200.w,
                                                    ),
                                                view: CalendarView.week,
                                                firstDayOfWeek: 1,
                                                todayHighlightColor:
                                                    kPrimaryColor,
                                                showDatePickerButton: true,
                                                headerStyle:
                                                    CalendarHeaderStyle(
                                                      backgroundColor:
                                                          kWhiteColor,
                                                    ),
                                                appointmentTextStyle: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                dataSource:
                                                    controller.dataSource,
                                                appointmentBuilder: (
                                                  context,
                                                  details,
                                                ) {
                                                  final Appointment
                                                  appointment =
                                                      details
                                                          .appointments
                                                          .first;
                                                  return CustomAppointmentWidget(
                                                    appointment: appointment,
                                                  );
                                                },
                                                onTap: (calendarTapDetails) {
                                                  if (calendarTapDetails
                                                              .targetElement ==
                                                          CalendarElement
                                                              .calendarCell &&
                                                      calendarTapDetails.date !=
                                                          null) {
                                                    final selectedDateTime =
                                                        calendarTapDetails
                                                            .date!;
                                                    Get.dialog(
                                                      EventDialog(
                                                        initialDateTime:
                                                            selectedDateTime,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                    ),
                                  ),
                                ),
                              ),
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

class CustomAppointmentWidget extends StatelessWidget {
  final Appointment appointment;

  const CustomAppointmentWidget({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final isShortDuration =
        appointment.endTime.difference(appointment.startTime).inMinutes <= 60;
    return Container(
      height: isShortDuration ? 120.h : null,
      padding: isShortDuration ? EdgeInsets.all(5) : EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: appointment.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: kBlackTextColor4, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 20.h,
                width: 35.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kBlackTextColor4,
                ),
                child: Center(
                  child: Text(
                    DateFormat('HH:mm').format(appointment.startTime),
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w900,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ),
              if (appointment.startTime != appointment.endTime)
                Container(
                  height: 20.h,
                  width: 35.w,
                  margin: EdgeInsets.only(left: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kBlackTextColor4,
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('HH:mm').format(appointment.endTime),
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w900,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 3.h),
          Text(
            appointment.subject,
            style: TextStyle(
              fontSize: isShortDuration ? 8.sp : 10.sp,
              fontWeight: FontWeight.w700,
              color: kGreyShade16Color,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 20.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: appointment.resourceIds!.length,
              itemBuilder: (context, index) {
                final resource = appointment.resourceIds![index] as String;
                return Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: ImageNetwork(
                      image: resource,
                      height: 25.h,
                      width: 22.w,
                      fitWeb: BoxFitWeb.cover,
                      fitAndroidIos: BoxFit.cover,
                      onLoading: const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      onError: Image.asset(kDummyImg, fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EventDialog extends StatefulWidget {
  final DateTime initialDateTime;
  final Function(String title, DateTime start, DateTime end)? onSave;

  const EventDialog({super.key, required this.initialDateTime, this.onSave});

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime? _startDateTime;
  DateTime? _endDateTime;
  List<String> selectedMembers = [];
  String? _selectedLocation;
  List<String> selectedMemberIds = [];
  void _showMultiSelectDialog(BuildContext context) {
    final calenderController = Get.find<CalenderController>();

    List<String> tempSelectedIds = List.from(selectedMemberIds);
    List<String> tempSelectedNames = List.from(selectedMembers);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Select Members"),
          content: SizedBox(
            width: 300.w,
            height: 400.h,
            child: Obx(() {
              return ListView.builder(
                itemCount: calenderController.allUsers.length,
                itemBuilder: (context, index) {
                  final user = calenderController.allUsers[index];
                  final isSelected = tempSelectedIds.contains(user.userId);

                  return CheckboxListTile(
                    value: isSelected,
                    onChanged: (checked) {
                      if (checked == true) {
                        tempSelectedIds.add(user.userId);
                        tempSelectedNames.add(user.name);
                      } else {
                        tempSelectedIds.remove(user.userId);
                        tempSelectedNames.remove(user.name);
                      }
                      (context as Element).markNeedsBuild();
                    },
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          child: ClipOval(
                            child: ImageNetwork(
                              image: user.userImage,
                              height: 30,
                              width: 30,
                              fitWeb: BoxFitWeb.cover,
                              fitAndroidIos: BoxFit.cover,
                              onLoading: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                              onError: Image.asset(
                                kDummyImg,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(user.name)),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
              );
            }),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Cancel",
                    height: 50,
                    borderRadius: 12,
                    fontWeight: FontWeight.w600,
                    borderColor: kPrimaryColor,
                    textColor: kPrimaryColor,
                    color: kWhiteColor,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(width: 16),

                Expanded(
                  child: CustomButton(
                    title: "Done",
                    height: 50,
                    borderRadius: 12,
                    textSize: 16,
                    fontWeight: FontWeight.w600,
                    textColor: kWhiteColor,
                    color: kPrimaryColor,
                    onTap: () {
                      setState(() {
                  selectedMemberIds = tempSelectedIds;
                  selectedMembers = tempSelectedNames;
                });
                Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            // TextButton(
            //   onPressed: () => Navigator.pop(context), // Cancel
            //   child: const Text("Cancel"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     setState(() {
            //       selectedMemberIds = tempSelectedIds;
            //       selectedMembers = tempSelectedNames;
            //     });
            //     Navigator.pop(context);
            //   },
            //   child: const Text("Done"),
            // ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CalenderController calenderController = Get.find();
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 440.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 27.h),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: "Event Title",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            right: 6,
                            bottom: 6,
                            left: 10,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.title, color: kGreyShade10Color),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.keyboard_arrow_down, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () async {
                  var result = await Get.to(() => SelectLocationScreen());
                  if (result != null) {
                    setState(() {
                      _selectedLocation = result;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.place_outlined, color: kGreyShade10Color),
                    SizedBox(width: 15.w),
                    SizedBox(
                      width: 350.w,
                      child: Text(
                        _selectedLocation != null
                            ? "$_selectedLocation"
                            : "Add Place",
                        maxLines: 1,
                        style: TextStyle(
                          color:
                              _selectedLocation != null
                                  ? kBlackColor
                                  : kGreyShade10Color,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 30),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: _optionRow(
                      Icons.calendar_today_outlined,
                      _startDateTime != null
                          ? "${_startDateTime!.day}/${_startDateTime!.month}/${_startDateTime!.year}"
                          : "Add Date",
                      _startDateTime != null ? kBlackColor : kGreyShade10Color,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _startDateTime ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                datePickerTheme: DatePickerThemeData(
                                  backgroundColor:
                                      Colors.white, // Set background to white
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() {
                            _startDateTime = DateTime(
                              picked.year,
                              picked.month,
                              picked.day,
                              _startDateTime?.hour ?? 0,
                              _startDateTime?.minute ?? 0,
                            );
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 48,
                    width: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: _optionRow(
                      Icons.access_time_outlined,
                      (_startDateTime != null && _endDateTime != null)
                          ? "${TimeOfDay.fromDateTime(_startDateTime!).format(context)} to ${TimeOfDay.fromDateTime(_endDateTime!).format(context)}"
                          : "Add Time",
                      _endDateTime != null ? kBlackColor : kGreyShade10Color,
                      onTap: () async {
                        final startTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (startTime != null) {
                          final endTime = await showTimePicker(
                            context: context,
                            initialTime: startTime.replacing(
                              hour: startTime.hour + 1,
                            ),
                          );
                          if (endTime != null) {
                            setState(() {
                              final now = _startDateTime ?? DateTime.now();
                              _startDateTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                startTime.hour,
                                startTime.minute,
                              );
                              _endDateTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                endTime.hour,
                                endTime.minute,
                              );
                            });
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Icon(Icons.group_outlined, color: kGreyShade10Color),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showMultiSelectDialog(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                selectedMembers.isEmpty
                                    ? 'Add Members'
                                    : selectedMembers.join(', '),
                                style: TextStyle(
                                  color:
                                      selectedMembers.isEmpty
                                          ? kGreyShade10Color
                                          : kBlackColor,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, color: kGreyShade10Color),
                  SizedBox(width: 15.w),

                  Expanded(
                    child: TextField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        hintText: "Add Notes",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            CustomButton(
              title: "Add",
              onTap: () {
                if (_titleController.text.trim().isNotEmpty &&
                    _startDateTime != null &&
                    _endDateTime != null &&
                    _notesController.text.isNotEmpty &&
                    _selectedLocation!.isNotEmpty &&
                    selectedMembers.isNotEmpty) {
                  Map<String, dynamic> body = {
                    "eventTitle": _titleController.text.trim(),
                    "place": _selectedLocation,
                    "date": _startDateTime!.toIso8601String(), // ISO format
                    "startTime": _startDateTime!.hour, // 24-hour int
                    "endTime": _endDateTime!.hour, // 24-hour int
                    "notes": _notesController.text.trim(),
                    "members": selectedMemberIds,
                  };

                  calenderController.addEvent(body: body);
                } else {
                  showCustomSnackbar("Error", "Please fill all fields");
                }
                // if (_titleController.text.trim().isNotEmpty &&
                //     _startDateTime != null &&
                //     _endDateTime != null) {
                //   widget.onSave(
                //     _titleController.text.trim(),
                //     _startDateTime!,
                //     _endDateTime!,
                //   );
              },
              borderRadius: 10,
              width: 250.w,
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  Widget _optionRow(
    IconData icon,
    String label,
    Color textColor, {
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: kGreyShade10Color),
          SizedBox(width: 15.w),
          Text(label, style: TextStyle(color: textColor, fontSize: 16)),
        ],
      ),
    );
  }
}
