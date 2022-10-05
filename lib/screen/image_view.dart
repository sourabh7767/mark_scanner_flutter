import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:get/get.dart';

class ImageView extends StatelessWidget {
  final XFile;
  final url;
  const ImageView({Key? key, this.XFile, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Material(
        color: AppColors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: (XFile ?? "")!="" ? Image.file(
                XFile,
                width: double.infinity,
              ) : CachedNetworkImage(
                imageUrl: url,
                width:double.infinity,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_back_ios)),
                ),
            )


          ],
        ),

      ),
    );
  }
}
