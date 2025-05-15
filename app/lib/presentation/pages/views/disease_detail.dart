import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:detect_it/app/controllers/disease_ctl.dart';
import 'package:detect_it/app/models/scan_model.dart';
import 'package:detect_it/library/detect_it.dart';
import 'package:detect_it/presentation/widgets/disease_details_list.dart';
import 'package:detect_it/presentation/widgets/scanner.dart';
import 'package:detect_it/presentation/widgets/shimmer_loading.dart';

class DiseaseDetail extends GetView<DiseaseCtl> {
  const DiseaseDetail({
    super.key,
    this.imageFile,
    this.scan,
    this.isScan = true,
  });

  final XFile? imageFile;
  final ScanModel? scan;
  final bool isScan;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                toolbarHeight: 180,
                leading: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(150),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black.withAlpha(150),
                    ),
                  ),
                ),
                flexibleSpace: Hero(
                  tag: scan?.id ?? '',
                  child: ScanningAnimation(
                    isScanning: controller.isLoading.value,
                    borderRadius: BorderRadius.zero,
                    child: isScan
                        ? Image.file(
                            File(imageFile?.path ?? ''),
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: scan?.imageUrl ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => ShimmerLoading(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      spacing: 10,
                      children: [
                        if (controller.isLoading.value)
                          Column(
                            spacing: 10,
                            children: [
                              ShimmerLoading(),
                              ShimmerLoading(),
                              ShimmerLoading(),
                            ],
                          )
                        else
                          DiseaseDetailsList(
                            disease: isScan ? controller.disease.value : scan!,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          Row(
            spacing: 10,
            children: [
              if (isScan)
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        controller.isDisabled ? null : controller.addScan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text('Save'),
                  ),
                )
              else
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (scan != null) {
                        controller.deleteScan(scan);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text('Delete'),
                  ),
                ),
              if (isScan)
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: Size(50, 50),
                  ),
                  onPressed: controller.isDisabled
                      ? null
                      : controller.refreshDiseaseDetails,
                  icon: const Icon(Icons.refresh, size: 24),
                )
            ],
          ),
        ],
      );
    });
  }
}
