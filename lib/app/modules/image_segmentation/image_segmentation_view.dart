import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:ml_examples/app/common/widgets/custom_action.dart';
import 'package:ml_examples/app/common/widgets/custom_appbar.dart';
import 'package:ml_examples/app/modules/image_segmentation/image_segmentation_controller.dart';
import 'package:ml_examples/app/routes/app_pages.dart';
import 'package:ml_examples/app/utils/app_utils.dart';

class ImageSegmentationView extends GetView<ImageSegmentationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Image Segmentation',
        leadings: [
          CustomAction(() {
            navigator.pop();
          }, FlutterIcons.back_ant)
        ],
        actions: [
          CustomAction(() {
            Get.offNamed(Routes.HOME);
          }, FlutterIcons.home_ant)
        ],
      ),
      body: kIsWeb
          ? Center(child: Text('Unsupported in Web, please check app'))
          : buildBody(),
    );
  }

  Widget buildBody() {
    return GetBuilder<ImageSegmentationController>(builder: (ic) {
      return ListView(physics: BouncingScrollPhysics(), children: [
        ic.pickedImage != null
            ? Center(
                child: Text(
                  'Original Image:',
                  style: kBoldText,
                ),
              )
            : Text(''),
        GestureDetector(
          onTap: ic.pickGalleryImage,
          child: Container(
            margin: EdgeInsets.all(18),
            width: Get.width,
            child: ic.pickedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      ic.pickedImage,
                      fit: BoxFit.fill,
                    ),
                  )
                : Center(
                    child: Text(
                      'Tap here to select an Image',
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        ),
        ic.loading || ic.segmentedImage == null
            ? Container(
                height: 50,
                width: 50,
                child: ic.loading
                    ? Center(child: CircularProgressIndicator())
                    : Center(child: Text('Select an Image to continue')),
              )
            : Center(
                child: Text(
                  'Segmented Image:',
                  style: kBoldText,
                ),
              ),
        ic.segmentedImage != null
            ? Container(
                margin: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: MemoryImage(ic.segmentedImage),
                      fit: BoxFit.fill),
                ),
                child: Opacity(
                  opacity: 0.3,
                  child: Image.file(ic.pickedImage, fit: BoxFit.fill),
                ),
              )
            : Container()
      ]);
    });
  }
}
