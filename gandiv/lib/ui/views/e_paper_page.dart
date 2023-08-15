import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:gandiv/ui/controllers/e_paper_controller.dart';
import 'package:get/get.dart';

import '../../constants/values/app_colors.dart';

class EPaperPage extends GetView<EPaperController> {
  const EPaperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: Text('e_paper'.tr),
      ),
      body: Obx(
        // ignore: sized_box_for_whitespace
        () => Container(
          width: double.infinity,
          height: double.infinity,
          child: const PDF().fromUrl(
            controller.pdfUrl.value,
            placeholder: (double progress) =>
                Center(child: Text('$progress %')),
            errorWidget: (dynamic error) =>
                Center(child: Text(error.toString())),
          ),
        ),
      ),
    );
  }
}
