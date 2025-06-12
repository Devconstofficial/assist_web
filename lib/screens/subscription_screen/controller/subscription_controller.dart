import 'package:get/get.dart';

import '../../../custom_widgets/view_profile_dialog.dart';

class SubscriptionController extends GetxController {
  var users = [
    {
      "name": "Sassanian Habib",
      "email": "sassanian.habib@example.com",
      "dDate": "02-12-2002",
      "dAmount": "200",
      "role": "Applicant"
    },
    {
      "name": "Mehaik Fatima",
      "email": "mehaik.fatima@example.com",
      "dDate": "02-12-2002",
      "dAmount": "200",
      "role": "Subscriber"
    },
    {
      "name": "Ahmed Khan",
      "email": "ahmed.khan@example.com",
      "dDate": "02-12-2002",
      "dAmount": "200",
      "role": "Applicant"
    },
    {
      "name": "Areeba Qamar",
      "email": "areeba.qamar@example.com",
      "dDate": "02-12-2002",
      "dAmount": "200",
      "role": "Subscriber"
    },
    {
      "name": "Umer Rasheed",
      "email": "umer.rasheed@example.com",
      "dDate": "02-12-2002",
      "dAmount": "200",
      "role": "Applicant"
    },
    {
      "name": "Fatima Noor",
      "email": "fatima.noor@example.com",
      "dDate": "02-12-2002",
      "dAmount": "200",
      "role": "Subscriber"
    },
    {
      "name": "Zayan Malik",
      "email": "zayan.malik@example.com",
      "dDate": "02-12-2002",
      "dAmount": "200",
      "role": "Applicant"
    },
    {
      "name": "Hina Shah",
      "email": "hina.shah@example.com",
      "dDate": "02-12-2002",
      "dAmount": "200",
      "role": "Subscriber"
    },
    {
      "name": "Bilal Ansari",
      "email": "bilal.ansari@example.com",
      "dDate": "02-12-2002",
      "dAmount": "200",
      "role": "Applicant"
    },
  ].obs;

  var currentPage = 1.obs;
  final int itemsPerPage = 3;
  final int pagesPerGroup = 4;

  int get totalPages => (users.length / itemsPerPage).ceil();

  List get pagedUsers {
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return users.sublist(start, end > users.length ? users.length : end);
  }

  int get currentGroup => ((currentPage.value - 1) / pagesPerGroup).floor();

  List<int> get visiblePageNumbers {
    int startPage = currentGroup * pagesPerGroup + 1;
    int endPage = (startPage + pagesPerGroup - 1).clamp(1, totalPages);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage.value = page;
  }

  void goToNextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  void deleteUserAt(int index) {
    users.removeAt(index);
  }
  void editUserAt(int index) {
    final user = users[index];
    if (user['role'] == 'Subscriber') {
      Get.dialog(viewProfileDialog(isSubscriber: true));
    } else {
      Get.dialog(viewProfileDialog());
    }
  }

  var isMonthly = true.obs;

  void selectMonthly() => isMonthly.value = true;
  void selectYearly() => isMonthly.value = false;
}