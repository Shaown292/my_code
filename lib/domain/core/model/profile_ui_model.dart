import 'dart:convert';

import '../../utils/json_utils.dart';

class ProfileModelUI {
  num id;
  int organizationId;
  int isSaasAdmin;
  String activePanel;
  String name;
  String username;
  int roleId;
  int currentCompanyId;
  int currentShowroomId;
  String email;
  bool isActive;
  String avatar;
  String referralCode;
  Organization organization;

  ProfileModelUI({
    required this.id,
    required this.organizationId,
    required this.isSaasAdmin,
    required this.activePanel,
    required this.name,
    required this.username,
    required this.roleId,
    required this.currentCompanyId,
    required this.currentShowroomId,
    required this.email,
    required this.isActive,
    required this.avatar,
    required this.referralCode,
    required this.organization,
  });

  factory ProfileModelUI.fromJson(Map<String, dynamic> j) => ProfileModelUI(
    id: getSafeValue<num>(j, 'id', 0),
    organizationId: getSafeValue<int>(j, 'organization_id', 0),
    isSaasAdmin: getSafeValue<int>(j, 'is_saas_admin', 0),
    activePanel: getSafeValue<String>(j, 'active_panel', ''),
    name: getSafeValue<String>(j, 'name', ''),
    username: getSafeValue<String>(j, 'username', ''),
    roleId: getSafeValue<int>(j, 'role_id', 0),
    currentCompanyId: getSafeValue<int>(j, 'current_company_id', 0),
    currentShowroomId: getSafeValue<int>(j, 'current_showroom_id', 0),
    email: getSafeValue<String>(j, 'email', ''),
    isActive: getSafeValue<bool>(j, 'is_active', false),
    avatar: getSafeValue<String>(j, 'avatar', ''),
    referralCode: getSafeValue<String>(j, 'referral_code', ''),
    organization: getSafeValue<Organization>(
      j,
      'organization',
      Organization.fromJson({}),
      decoder: (json) => Organization.fromJson(json),
    ),
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['organization_id'] = organizationId;
    data['is_saas_admin'] = isSaasAdmin;
    data['active_panel'] = activePanel;
    data['name'] = name;
    data['username'] = username;
    data['role_id'] = roleId;
    data['current_company_id'] = currentCompanyId;
    data['current_showroom_id'] = currentShowroomId;
    data['email'] = email;
    data['is_active'] = isActive;
    data['avatar'] = avatar;
    data['referral_code'] = referralCode;
    data['organization'] = organization.toJson();
    return data;
  }

  @override
  String toString() => const JsonEncoder.withIndent(' ').convert(toJson());
}

class Organization {
  num id;
  String domain;

  Organization({
    required this.id,
    required this.domain,
  });

  factory Organization.fromJson(Map<String, dynamic> j) => Organization(
    id: getSafeValue<num>(j, 'id', 0),
    domain: getSafeValue<String>(j, 'domain', ''),
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['domain'] = domain;
    return data;
  }

  @override
  String toString() => const JsonEncoder.withIndent(' ').convert(toJson());
}
