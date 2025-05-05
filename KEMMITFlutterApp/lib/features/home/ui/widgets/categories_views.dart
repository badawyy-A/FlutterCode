import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/home/logic/home_provider.dart';

class CategoriesViews extends ConsumerStatefulWidget {
  const CategoriesViews({super.key});

  @override
  ConsumerState<CategoriesViews> createState() => _CategoriesViewsState();
}

class _CategoriesViewsState extends ConsumerState<CategoriesViews> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(getAllCategories);
    return data.when(
      data: (data) => data.when(success: (categories) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SizedBox(
            height: 100.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      categoryID = category.id.toString();
                    });
                    ref.refresh(getAllTourism);
                  },
                  child: Container(
                    width: 80.w,
                    height: 100.h,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: categoryID == category.id.toString()
                          ? Colors.lightBlue[400]
                          : null,
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 5.r,
                            spreadRadius: 1.r,
                            offset: const Offset(0.0, 3.0))
                      ],
                      border: Border.all(color: Colors.grey, width: 1.w),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 11.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category.name.toString() == "Hospitals"
                                ? Icons.local_hospital
                                : category.name.toString() == "Transportation"
                                    ? Icons.emoji_transportation
                                    : category.name.toString() == "Historical"
                                        ? Icons.history_toggle_off_rounded
                                        : category.name.toString() == "Souvenir"
                                            ? Icons.card_giftcard_outlined
                                            : category.name.toString() ==
                                                    "Museums"
                                                ? Icons.museum
                                                : category.name.toString() ==
                                                        "Entertainment"
                                                    ? Icons.festival
                                                    : category.name
                                                                .toString() ==
                                                            "Hotels"
                                                        ? Icons.hotel
                                                        : category.name
                                                                    .toString() ==
                                                                "Restaurants"
                                                            ? Icons.restaurant
                                                            : category.name
                                                                        .toString() ==
                                                                    "Beaches"
                                                                ? Icons
                                                                    .beach_access
                                                                : Icons
                                                                    .receipt_long_rounded,
                            color: Colors.white,
                            size: 30.w,
                          ),
                          Gap(8.h),
                          Center(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              category.name.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }, failure: (failure) {
        return Text('$failure');
      }),
      error: (error, stack) {
        return Text('$error');
      },
      loading: () => SizedBox(
        height: 100.h,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xffCEA16E),
            backgroundColor: Color(0xffDAB58F),
          ),
        ),
      ),
    );
  }
}
