import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../services/https_client.dart';

class CategoryController extends GetxController {

  RxInt selectIndex = 0.obs;
  RxList<CategoryItemModel?> leftCategoryList = <CategoryItemModel?>[].obs;
  RxList<CategoryItemModel?> rightCategoryList = <CategoryItemModel?>[].obs;
  HttpClient httpClient = HttpClient();

  @override
  void onInit() {
    super.onInit();
    getLeftCategoryList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeIndex(index, String sId) {
    selectIndex.value = index;
    getRightCategoryList(sId);
    update();
  }

  getLeftCategoryList() async {
    var response = await httpClient.get('api/pcate');
    if (response != null) {
      CategoryModel categoryModel = CategoryModel.fromJson(response.data);
      leftCategoryList.value = categoryModel.result!;
      getRightCategoryList(leftCategoryList[0]?.sId ?? '');
      update();
    }
  }

  getRightCategoryList(String pid) async {
    var response = await httpClient.get('api/pcate?pid=$pid');
    if (response != null) {
      CategoryModel categoryModel = CategoryModel.fromJson(response.data);
      rightCategoryList.value = categoryModel.result!;
      update();
    }
  }
}
