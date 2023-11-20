import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/admin/admin_staff_role_wise_list_response_model/admin_staff_role_wise_list_response_model.dart';
import '../../../utilities/api_urls.dart';

class StaffListController extends GetxController {
  LoadingController loadingController = Get.find();

  List<RoleWiseStaffListData> roleWiseStaffList = [];
  int staffId = -1;

  Future<void> getRoleWiseStaffList({required int staffRoleId}) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getAdminRoleWiseStaff(staffRoleId: staffRoleId),
        header: GlobalVariableController.header,
      );

      AdminStaffRoleWiseListResponseModel adminStaffRoleWiseListResponseModel =
          AdminStaffRoleWiseListResponseModel.fromJson(response);

      if (adminStaffRoleWiseListResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminStaffRoleWiseListResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminStaffRoleWiseListResponseModel.data!.length;
              i++) {
            roleWiseStaffList.add(adminStaffRoleWiseListResponseModel.data![i]);
          }
        }
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }
  }

  @override
  void onInit() {
    int staffId = Get.arguments["staff_role_id"];
    this.staffId = staffId;
    getRoleWiseStaffList(staffRoleId: staffId);

    super.onInit();
  }
}
