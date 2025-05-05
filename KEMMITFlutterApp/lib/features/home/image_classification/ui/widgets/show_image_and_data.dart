/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/home/image_classification/controller/image_classifier.dart';

class ShowImageAndData extends ConsumerStatefulWidget {
  const ShowImageAndData({super.key});

  @override
  ConsumerState<ShowImageAndData> createState() => _ShowImageAndDataState();
}

class _ShowImageAndDataState extends ConsumerState<ShowImageAndData> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(chatBotControllerProvider);
    final dataAndImage =
        ref.read(chatBotControllerProvider.notifier).dataAndImage;

    return data.when(
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: dataAndImage.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 370,
                      height: 370,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Color(0xff464A7A), width: 1.5),
                        image: DecorationImage(
                          image: FileImage(dataAndImage[index].image,),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _defaultText(
                            title: 'Name of statue', subTitle: dataAndImage[index].name),
                      ],
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _defaultText({
    required String title,
    required String subTitle,
  }) {
    return Text(
      textAlign: TextAlign.center,
      '$title\n$subTitle',
      style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w800),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }


}
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/home/image_classification/controller/image_classifier.dart';

class ShowImageAndData extends ConsumerStatefulWidget {
  const ShowImageAndData({super.key});

  @override
  ConsumerState<ShowImageAndData> createState() => _ShowImageAndDataState();
}

class _ShowImageAndDataState extends ConsumerState<ShowImageAndData> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(chatBotControllerProvider);
    final dataAndImage =
        ref.read(chatBotControllerProvider.notifier).dataAndImage;

    return data.when(
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: dataAndImage.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  // Image Display
                  Container(
                    width: 370,
                    height: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xff464A7A), width: 1.5),
                      image: DecorationImage(
                        image: FileImage(dataAndImage[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(20),

                  // Prediction & Description Display
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle("Recognized King"),
                        _styledText(
                          dataAndImage[index].name,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff464A7A),
                        ),
                        const SizedBox(height: 16),
                        _sectionTitle("Description"),
                        _styledText(
                          dataAndImage[index].description,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // Styled section title
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // Styled text with customization
  Widget _styledText(
      String text, {
        required double fontSize,
        required FontWeight fontWeight,
        required Color color,
        double height = 1.2,
      }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      ),
    );
  }
}
