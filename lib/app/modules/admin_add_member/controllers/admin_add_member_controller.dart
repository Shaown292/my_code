import 'package:flutter/cupertino.dart';
import 'package:flutter_single_getx_api_v2/app/data/constants/app_text.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/api_urls.dart';
import 'package:flutter_single_getx_api_v2/app/utilities/message/snack_bars.dart';
import 'package:flutter_single_getx_api_v2/config/global_variable/global_variable_controller.dart';
import 'package:flutter_single_getx_api_v2/domain/base_client/base_client.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_class_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_parents_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_roles_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_section_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_student_response_model.dart';
import 'package:flutter_single_getx_api_v2/domain/core/model/admin/admin_library_model/member_model/admin_library_add_member_user_name_response_model.dart';
import 'package:get/get.dart';

class AdminAddMemberController extends GetxController {

  TextEditingController idTextController = TextEditingController();

  /// Loader
  RxBool rolesLoader = false.obs;
  RxBool userNameLoader = false.obs;
  RxBool classLoader = false.obs;
  RxBool sectionLoader = false.obs;
  RxBool studentLoader = false.obs;
  RxBool parentLoader = false.obs;

  /// Dropdown List
  RxList<AdminAddMemberRoleData> rolesList = <AdminAddMemberRoleData>[].obs;
  RxList<AdminAddMemberUserNameData> userNameList = <AdminAddMemberUserNameData>[].obs;
  RxList<AdminLibraryAddMemberClassData> classList = <AdminLibraryAddMemberClassData>[].obs;
  RxList<AdminAddMemberSectionData> sectionList = <AdminAddMemberSectionData>[].obs;
  RxList<AdminLibraryAddMemberStudentData> studentList = <AdminLibraryAddMemberStudentData>[].obs;
  RxList<AdminLibraryAddMemberParentsData> parentsList = <AdminLibraryAddMemberParentsData>[].obs;

  RxString memberCategory = "Driver".obs;
  RxList<String> memberCategoryList = [
    "Driver",
    "Teacher",
    "Security Guard",
    "Librarian",
    "Student",
    "Parents",
  ].obs;

  RxString memberName = "Sumon".obs;
  RxList<String> memberNameList = [
    "Sumon",
    "Sujon",
    "Sukhon",
    "Roton"
  ].obs;


  /// Get Member Role List
  Future<AdminLibraryAddMemberRolesResponseModel> getRolesList() async {


    try{

      rolesLoader.value = true;

      final response = await BaseClient().getData(url: InfixApi.getAdminMemberRolesList, header: GlobalVariable.header);

      AdminLibraryAddMemberRolesResponseModel addMemberRolesResponseModel = AdminLibraryAddMemberRolesResponseModel.fromJson(response);

      if(addMemberRolesResponseModel.success == true){

        rolesLoader.value = false;

        if(addMemberRolesResponseModel.data!.isNotEmpty){
          for(int i = 0; i < addMemberRolesResponseModel.data!.length; i++){
            rolesList.add(addMemberRolesResponseModel.data![i]);
          }
        }


      } else{
        rolesLoader.value = false;
        showBasicFailedSnackBar(message: addMemberRolesResponseModel.message ?? AppText.somethingWentWrong);
      }

    } catch(e, t){
      rolesLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally{
      rolesLoader.value = false;
    }

    return AdminLibraryAddMemberRolesResponseModel();
  }

  /// Get User Name list
  Future<AdminLibraryAddMemberUserNameResponseModel> getUserNameList({required int roleId}) async {


    try{

      userNameLoader.value = true;

      final response = await BaseClient().getData(url: InfixApi.getAdminMemberUserNameList(roleId: roleId), header: GlobalVariable.header);

      AdminLibraryAddMemberUserNameResponseModel addMemberUserNameResponseModel = AdminLibraryAddMemberUserNameResponseModel.fromJson(response);

      if(addMemberUserNameResponseModel.success == true){

        userNameLoader.value = false;

        if(addMemberUserNameResponseModel.data!.isNotEmpty){
          for(int i = 0; i < addMemberUserNameResponseModel.data!.length; i++){
            userNameList.add(addMemberUserNameResponseModel.data![i]);
          }
        }


      } else{
        userNameLoader.value = false;
        showBasicFailedSnackBar(message: addMemberUserNameResponseModel.message ?? AppText.somethingWentWrong);
      }

    } catch(e, t){
      userNameLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally{
      userNameLoader.value = false;
    }

    return AdminLibraryAddMemberUserNameResponseModel();
  }

  /// Get Class List
  Future<AdminLibraryAddMemberClassResponseModel> getClassList({required int roleId}) async {


    try{

      classLoader.value = true;

      final response = await BaseClient().getData(url: InfixApi.getAdminMemberClassList(roleId: roleId), header: GlobalVariable.header);

      AdminLibraryAddMemberClassResponseModel addMemberClassResponseModel = AdminLibraryAddMemberClassResponseModel.fromJson(response);

      if(addMemberClassResponseModel.success == true){

        classLoader.value = false;

        if(addMemberClassResponseModel.data!.isNotEmpty){
          for(int i = 0; i < addMemberClassResponseModel.data!.length; i++){
            classList.add(addMemberClassResponseModel.data![i]);
          }
        }


      } else{
        classLoader.value = false;
        showBasicFailedSnackBar(message: addMemberClassResponseModel.message ?? AppText.somethingWentWrong);
      }

    } catch(e, t){
      classLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally{
      classLoader.value = false;
    }

    return AdminLibraryAddMemberClassResponseModel();
  }


  /// Get Sections List
  Future<AdminLibraryAddMemberSectionResponseModel> getSectionList({required int classId}) async {


    try{

      sectionLoader.value = true;

      final response = await BaseClient().getData(url: InfixApi.getAdminMemberSectionList(classId: classId), header: GlobalVariable.header);

      AdminLibraryAddMemberSectionResponseModel addMemberSectionResponseModel = AdminLibraryAddMemberSectionResponseModel.fromJson(response);

      if(addMemberSectionResponseModel.success == true){

        sectionLoader.value = false;

        if(addMemberSectionResponseModel.data!.isNotEmpty){
          for(int i = 0; i < addMemberSectionResponseModel.data!.length; i++){
            sectionList.add(addMemberSectionResponseModel.data![i]);
          }
        }


      } else{
        sectionLoader.value = false;
        showBasicFailedSnackBar(message: addMemberSectionResponseModel.message ?? AppText.somethingWentWrong);
      }

    } catch(e, t){
      sectionLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally{
      sectionLoader.value = false;
    }

    return AdminLibraryAddMemberSectionResponseModel();
  }


  /// Get Students List
  Future<AdminLibraryAddMemberStudentResponseModel> getStudentList({required int classId, required int sectionId}) async {


    try{

      studentLoader.value = true;

      final response = await BaseClient().getData(url: InfixApi.getAdminMemberStudentList(classId: classId, sectionId: sectionId), header: GlobalVariable.header);

      AdminLibraryAddMemberStudentResponseModel addMemberStudentResponseModel = AdminLibraryAddMemberStudentResponseModel.fromJson(response);

      if(addMemberStudentResponseModel.success == true){

        studentLoader.value = false;

        if(addMemberStudentResponseModel.data!.isNotEmpty){
          for(int i = 0; i < addMemberStudentResponseModel.data!.length; i++){
            studentList.add(addMemberStudentResponseModel.data![i]);
          }
        }


      } else{
        studentLoader.value = false;
        showBasicFailedSnackBar(message: addMemberStudentResponseModel.message ?? AppText.somethingWentWrong);
      }

    } catch(e, t){
      studentLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally{
      studentLoader.value = false;
    }

    return AdminLibraryAddMemberStudentResponseModel();
  }


  /// Get Parents List
  Future<AdminLibraryAddMemberParentsResponseModel> getParentsList({required int classId, required int sectionId}) async {


    try{

      parentLoader.value = true;

      final response = await BaseClient().getData(url: InfixApi.getAdminMemberParentList(classId: classId, sectionId: sectionId), header: GlobalVariable.header);

      AdminLibraryAddMemberParentsResponseModel addMemberParentsResponseModel = AdminLibraryAddMemberParentsResponseModel.fromJson(response);

      if(addMemberParentsResponseModel.success == true){

        parentLoader.value = false;

        if(addMemberParentsResponseModel.data!.isNotEmpty){
          for(int i = 0; i < addMemberParentsResponseModel.data!.length; i++){
            parentsList.add(addMemberParentsResponseModel.data![i]);
          }
        }


      } else{
        parentLoader.value = false;
        showBasicFailedSnackBar(message: addMemberParentsResponseModel.message ?? AppText.somethingWentWrong);
      }

    } catch(e, t){
      parentLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally{
      parentLoader.value = false;
    }

    return AdminLibraryAddMemberParentsResponseModel();
  }



  @override
  void onInit() {
    getRolesList();
    getUserNameList(roleId: 1);
    getClassList(roleId: 2);
    getSectionList(classId: 1);
    getStudentList(classId: 1, sectionId: 1);
    getParentsList(classId: 1, sectionId: 1);

    super.onInit();
  }

}
