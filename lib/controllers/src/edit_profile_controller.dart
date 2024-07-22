import 'package:get/get.dart';

class EditProfileController extends GetxController {
  var imageUrl = ''.obs;
  var name = ''.obs;
  
  void updateProfile(String name) async{
    this.name.value = name;
    // await APIs.updateUserInfo(newAbout, newAbout); 
  }
  void updateImage(String imageUrl) async{
    this.imageUrl.value = imageUrl;
    // await APIs.updateUserInfo(newAbout, newAbout);
  }
}