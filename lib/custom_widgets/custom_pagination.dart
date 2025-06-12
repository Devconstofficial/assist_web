import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomPagination extends StatelessWidget {
  final int currentPage;
  final List<int> visiblePages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Function(int) onPageSelected;

  const CustomPagination({
    super.key,
    required this.currentPage,
    required this.visiblePages,
    required this.onPrevious,
    required this.onNext,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPrevious,
          child: Container(
            height: 44,
            width: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: kBlackColor.withOpacity(0.08)),
            ),
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: kPrimaryColor,
                  child: Transform.rotate(
                    angle: 3.1416,
                    child: const Icon(Icons.arrow_right_alt, size: 12,color: kWhiteColor,),
                  ),
                ),
                const SizedBox(width: 5),
                Text("Previous", style: AppStyles.blackTextStyle().copyWith(fontSize: 14)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 18),

        ...visiblePages.map((page) {
          final isSelected = currentPage == page;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () => onPageSelected(page),
              child: Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? kBlackColor : kBlackColor.withOpacity(0.08),
                  ),
                ),
                child: Center(
                  child: Text(
                    page.toString(),
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 14,
                      color: kBlackColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),

        const SizedBox(width: 18),

        GestureDetector(
          onTap: onNext,
          child: Container(
            height: 44,
            width: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: kBlackColor.withOpacity(0.08)),
            ),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Next", style: AppStyles.blackTextStyle().copyWith(fontSize: 14)),
                const SizedBox(width: 5),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: kPrimaryColor,
                  child: const Icon(Icons.arrow_right_alt, size: 12,color: kWhiteColor,),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
