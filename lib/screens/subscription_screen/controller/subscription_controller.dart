import 'package:assist_web/models/subscription_model.dart';
import 'package:assist_web/services/donation_service.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  final DonationService _service = DonationService();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  var isLoadingRevenue = false.obs;
  var isErrorRevenue = false.obs;
  var errorMsgRevenue = "".obs;
  var isLoading1 = false.obs;
  var isError1 = false.obs;
  var errorMsg1 = "".obs;
  var totalDonations = 0.0.obs;
  var individualSubscriber = 0.0.obs;
  RxList<Map<String, dynamic>> graphData = <Map<String, dynamic>>[].obs;
  RxList<SubscriptionModel> allSubscriptions = <SubscriptionModel>[].obs;
  RxList<SubscriptionModel> filteredSubs = <SubscriptionModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAll();
  }

  void getAll() {
    Future.wait([
      getDonationStats(),
      getRevenue(isMonthly.value ? "monthly" : "yearly"),
      getSubscriptions(),
    ]);
  }

  Future getDonationStats() async {
    try {
      isLoading(true);
      var result = await _service.getDonationStats();
      isLoading(false);
      if (result is Map<String, dynamic>) {
        totalDonations.value = result['totalDonation'];
        individualSubscriber.value = result['averageDonationPerUser'];
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

  Future getSubscriptions() async {
    try {
      isLoading1(true);
      var result = await _service.getSubscriptions();
      isLoading1(false);
      if (result is List<SubscriptionModel>) {
        allSubscriptions.assignAll(result);
        filteredSubs.assignAll(result);
        isError1(false);
        errorMsg1.value = '';
        return;
      } else {
        isError1(true);
        errorMsg1.value = result.toString();
      }
    } catch (e) {
      isLoading1(false);
      isError1(true);
      errorMsg1.value = e.toString();
    }
  }

  Future getRevenue(String type) async {
    try {
      isErrorRevenue(false);
      errorMsgRevenue.value = '';
      isLoadingRevenue(true);
      var result = await _service.getRevenue(type: type);
      isLoadingRevenue(false);
      if (result is List<Map<String, dynamic>>) {
        graphData.assignAll(result);
        return;
      } else {
        isErrorRevenue(true);
        errorMsgRevenue.value = result.toString();
      }
    } catch (e) {
      isLoadingRevenue(false);
      isErrorRevenue(true);
      errorMsgRevenue.value = e.toString();
    }
  }

  var currentPage = 1.obs;
  final int itemsPerPage = 3;
  final int pagesPerGroup = 4;

  var searchQuery = ''.obs;

  List get pagedUsers {
    final filtered = filteredSubs;
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return filtered.sublist(
      start,
      end > filtered.length ? filtered.length : end,
    );
  }

  int get totalPages => (filteredSubs.length / itemsPerPage).ceil();

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

  var isMonthly = true.obs;

  void selectMonthly() => isMonthly.value = true;
  void selectYearly() => isMonthly.value = false;
}
