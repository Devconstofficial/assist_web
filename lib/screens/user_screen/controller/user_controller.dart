import 'package:get/get.dart';

import '../../../custom_widgets/view_profile_dialog.dart';

class UserController extends GetxController {
  var users = [
    {
      "name": "Sassanian Habib",
      "email": "sassanian.habib@example.com",
      "birthDate": "02-12-2002",
      "phNumber": "+9212345678901",
      "role": "Applicant"
    },
    {
      "name": "Mehaik Fatima",
      "email": "mehaik.fatima@example.com",
      "birthDate": "02-13-2002",
      "phNumber": "+9212345678902",
      "role": "Subscriber"
    },
    {
      "name": "Ahmed Khan",
      "email": "ahmed.khan@example.com",
      "birthDate": "02-14-2002",
      "phNumber": "+9212345678903",
      "role": "Applicant"
    },
    {
      "name": "Areeba Qamar",
      "email": "areeba.qamar@example.com",
      "birthDate": "02-15-2002",
      "phNumber": "+9212345678904",
      "role": "Subscriber"
    },
    {
      "name": "Umer Rasheed",
      "email": "umer.rasheed@example.com",
      "birthDate": "02-16-2002",
      "phNumber": "+9212345678905",
      "role": "Applicant"
    },
    {
      "name": "Fatima Noor",
      "email": "fatima.noor@example.com",
      "birthDate": "02-17-2002",
      "phNumber": "+9212345678906",
      "role": "Subscriber"
    },
    {
      "name": "Zayan Malik",
      "email": "zayan.malik@example.com",
      "birthDate": "02-18-2002",
      "phNumber": "+9212345678907",
      "role": "Applicant"
    },
    {
      "name": "Hina Shah",
      "email": "hina.shah@example.com",
      "birthDate": "02-19-2002",
      "phNumber": "+9212345678908",
      "role": "Subscriber"
    },
    {
      "name": "Bilal Ansari",
      "email": "bilal.ansari@example.com",
      "birthDate": "02-20-2002",
      "phNumber": "+9212345678909",
      "role": "Applicant"
    },
  ].obs;

  var currentPage = 1.obs;
  final int itemsPerPage = 8;
  final int pagesPerGroup = 4;

  var searchQuery = ''.obs;

  List get filteredUsers {
    if (searchQuery.value.isEmpty) return users;

    return users
        .where((user) =>
        user['name']!.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  List get pagedUsers {
    final filtered = filteredUsers;
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return filtered.sublist(start, end > filtered.length ? filtered.length : end);
  }

  int get totalPages => (filteredUsers.length / itemsPerPage).ceil();


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
}