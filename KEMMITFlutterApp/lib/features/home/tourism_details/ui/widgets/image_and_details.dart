import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/home/tourism_details/logic/tourism_details_provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class ImageAndDetails extends ConsumerWidget {
  final String placeId;
  final String tourismImage;
  final String description;
  final String city;
  final String location;
  final num entryFee;
  final num rating;
  final DateTime openingTime;
  final DateTime closingTime;
  final bool isPopular;
  final int index;

  const ImageAndDetails({
    required this.index,
    required this.placeId,
    required this.tourismImage,
    required this.description,
    required this.city,
    required this.location,
    required this.entryFee,
    required this.rating,
    required this.openingTime,
    required this.closingTime,
    required this.isPopular,
    super.key,
  });

  /// **Function to Open Google Maps**
  Future<void> openGoogleMaps() async {
    final Uri googleMapsUri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$location");
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      throw 'Could not open the map';
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(getAllTourism(placeId));

    return data.when(
      data: (data) {
        return data.when(success: (details) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),

                /// **Tourism Image with Hero Animation**
                Hero(
                  tag: placeId,
                  child: Container(
                    width: double.maxFinite,
                    height: 250.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      image: DecorationImage(
                        image: NetworkImage(tourismImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Gap(15.h),

                /// **Description Box with Additional Details**
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// **Description**
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Gap(10.h),

                      /// **City Display**
                      Row(
                        children: [
                          Icon(Icons.location_city, color: Colors.grey.shade700, size: 20.sp),
                          Gap(5.w),
                          Text(
                            city,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Gap(5.h),

                      /// **Clickable Location (Opens Google Maps)**
                      GestureDetector(
                        onTap: openGoogleMaps,
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.redAccent, size: 20.sp),
                            Gap(5.w),
                            Text(
                              "View on Map",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.h),

                      /// **Opening & Closing Time**
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey.shade700, size: 20.sp),
                          Gap(5.w),
                          Text(
                            "Open: ${_formatTime(openingTime)} - Close: ${_formatTime(closingTime)}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Gap(10.h),

                      /// **Entry Fee**
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.green, size: 20.sp),
                          Gap(5.w),
                          Text(
                            "Entry Fee: \$${entryFee.toString()}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Gap(10.h),

                      /// **Rating in Stars**
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orangeAccent, size: 20.sp),
                          Gap(5.w),
                          Text(
                            "Rating: ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          Row(
                            children: List.generate(
                              rating.toInt(),
                              (index) => Icon(Icons.star, color: Colors.orangeAccent, size: 16.sp),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(20.h),

                /// **Comments Section**
                details.isEmpty
                    ? Center(
                        child: Text(
                          'No Comments',
                          style: TextStyle(
                            color: const Color(0xffCEA16E),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: details.length,
                        itemBuilder: (context, index) {
                          return buildFacebookStyleComment(details[index]);
                        },
                      ),
              ],
            ),
          );
        }, failure: (failure) {
          return Text(failure.toString());
        });
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => SizedBox(
        height: 500.h,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xffCEA16E),
            backgroundColor: Color(0xffDAB58F),
          ),
        ),
      ),
    );
  }

  /// **Time Formatting Function**
  String _formatTime(DateTime time) {
    return "${time.hour % 12 == 0 ? 12 : time.hour % 12}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}";
  }

  /// **Facebook-Style Comment UI**
  Widget buildFacebookStyleComment(dynamic comment) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Profile Picture Placeholder**
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, size: 20.sp, color: Colors.white),
            ),
            Gap(10.w),

            /// **Comment Details**
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **User Name & Rating**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        comment.reviewerName.toString(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Gap(5.h),

                  /// **Comment Text**
                  Text(
                    comment.comment.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
