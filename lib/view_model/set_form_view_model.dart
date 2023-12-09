import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/common_widget/logger.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';
import 'package:web_demo_satish/widget_json.dart';

class SetFormViewModel extends GetxController {
  /// FOR SHOWING ADD FORMS
  bool isShow = false;

  updateShowForm(bool value) {
    isShow = value;
    update();
  }

  /// FOR SHOWING ADD FORMS
  ///
  /// FOR HOVER TAB BAR
  var hover1 = false;
  var hover2 = false;

  updateHover1(bool val) {
    hover1 = val;
    update();
  }

  updateHover2(bool val) {
    hover2 = val;
    update();
  }

  /// FOR HOVER TAB BAR
  ///

  List pages = [
    "HomePage",
    "Add Form",
    "Edit Form",
  ];

  /// WHEN ADD DROP , COLLAPS , SEARCH BOX so SAVE THOES VALUE
  List<dynamic> dropdownList = [];
  List<dynamic> expandList = [];
  Map<String, dynamic> searchBoxData = {};

  addDropDownValue(val) {
    dropdownList.add(val);
    update();
  }

  addSearchValue({String? formName, String? labelId}) {
    searchBoxData.addAll({'formName': formName, 'labelId': labelId});
    update();
  }

  addCollapsValue(val) {
    expandList.add(val);
    update();
  }

  /// WHEN ADD DROP , COLLAPS , SEARCH BOX so SAVE THOES VALUE
  ///

  /// FOR  DATA YOU ADD HOW IT SHOW
  bool isNewLine = false;
  bool isDisplayOnly = false;
  bool isControl = false;
  bool isRelated = false;
  bool isMasked = false;
  bool isFullWidth = false;
  bool saveCall = false;
  bool isId = false;

  updateSaveCall(value) {
    saveCall = value;
    update();
  }

  updateIsId(value) {
    isId = value;
    update();
  }

  updateIsNewLine() {
    isNewLine = !isNewLine;
    update();
  }

  updateIsDisplayOnly() {
    isDisplayOnly = !isDisplayOnly;
    update();
  }

  updateIsControl() {
    isControl = !isControl;
    update();
  }

  updateIsRelated() {
    isRelated = !isRelated;
    update();
  }

  updateIsMasked() {
    isMasked = !isMasked;
    update();
  }

  updateIsFullWidth() {
    isFullWidth = !isFullWidth;
    update();
  }

  /// FOR  DATA YOU ADD HOW IT SHOW
  ///

  /// SELECT TYPE FOR ADD DATA VALUE
  String optionSelected = "Normal Field";
  updateShowTypeDropDownValue({String? value}) {
    optionSelected = value!;
    update();
  }

  /// SELECT TYPE FOR ADD DATA VALUE
  ///

  /// FIELD SELECT LIST
  List options = [
    "Normal Field",
    "DropDown",
    "Check Box",
    "Datefield",
    "TimeField",
    "Scrollable list",
    "Hyperlink",
    "Derived field",
    "Image",
    "Table",
    "Long box",
    "Field grouping",
    "Separator",
    "Collapse Area",
    "Search Box",
    "File upload",
    "Multi Search",
  ];

  /// MAIN MAP
  Map<String, dynamic> dataOfMap = {
    "name": "",
    "description": "",
    "menuType": '',
    "entries": []
  };

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController formTypeController = TextEditingController();
  TextEditingController labelController = TextEditingController();
  TextEditingController hyperlinkController = TextEditingController();
  TextEditingController dropDownTextController = TextEditingController();
  TextEditingController expandTextController = TextEditingController();
  TextEditingController searchBoxTextController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  /// THIS IS SEARCH FOR SAVE FORM
  String searchPage = '';

  updateSearch(String val) {
    searchPage = val;
    update();
  }

  clearSearch() {
    searchController.clear();
    searchPage = '';
    update();
  }

  /// THIS IS SEARCH FOR SAVE FORM
  ///

  /// FOR SWITCH MAIN TAB
  int selectTab = 0;

  updateSelectTab(int index) {
    selectTab = index;
    update();
  }

  /// FOR SWITCH MAIN TAB
  ///

  /// THIS IS FOR WHICH TYPE OF FORM YOU ADD IS APPLICATION OR SET UP
  String selectTypeOfForm = '';
  updateSelectFormType(String val) {
    selectTypeOfForm = val;
    update();
  }

  String selectFormStatus = '';
  updateSelectFormStatus(String val) {
    selectFormStatus = val;
    update();
  }

  List<String> groupItems = [
    'test1',
    'test2',
    'test3',
    'test4',
    'test5',
  ];

  List selectedGroup = [];
  List selectedOrganization = [];
  List selectedRoles = [];

  /// THIS IS FOR WHICH TYPE OF FORM YOU ADD IS APPLICATION OR SET UP
  ///

  /// THIS ARE WHEN YOU SELECT SEARCH BOX AND GET FORM NAME AND THOS VALUE
  String selectPageName = '';
  int? selectPageFieldIndex;
  String selectPageFieldName = '';
  updateSelectPageName(String value) {
    selectPageName = value;
    update();
  }

  updateSelectPageIndex(String index) {
    selectPageFieldIndex = int.parse(index);
    update();
  }

  updateSelectPageFieldName(String value) {
    selectPageFieldName = value;
    update();
  }

  /// THIS ARE WHEN YOU SELECT SEARCH BOX AND GET FORM NAME AND THOS VALUE
  ///

  /// FOR EDIT ADD FORM  HOMEPAGE - ADDFORM - EDIT PAGE
  int pageSelected = 0;

  updateSelectedPage(int index) {
    pageSelected = index;
    update();
  }

  /// FOR EDIT ADD FORM  HOMEPAGE - ADDFORM - EDIT PAGE
  ///

  /// FOR SHOW ALL PAGES DATA IN 1 PAGE
  int selectAllPage = -1;

  updateSelectAllPage(int index) {
    selectAllPage = index;
    update();
  }

  /// FOR SHOW ALL PAGES DATA IN 1 PAGE
  ///

  /// FOR SELECT SAVE FORM PAGE - YOUR SAVE FORM INDEX LIKE SETUP PAGES
  int savePageSelected = -1;

  updateSaveSelectedPage(int index) {
    savePageSelected = index;

    update();
  }

  /// FOR SELECT SAVE FORM PAGE - YOUR SAVE FORM INDEX LIKE SETUP PAGES
  ///

  /// THIS ARE WHEN USER SELECT FIELD AND USER ADD INPUT
  bool hyperLink = false;
  bool dropDownValue = false;
  bool expandValue = false;
  bool searchBoxValue = false;

  updateHyperLinkTrue() {
    hyperLink = true;
    update();
  }

  updateHyperLinkFalse() {
    hyperLink = false;
    update();
  }

  updateDropDownTrue() {
    dropDownValue = true;
    update();
  }

  updateDropDownFalse() {
    dropDownValue = false;
    update();
  }

  updateExpandTrue() {
    expandValue = true;
    update();
  }

  updateExpandFalse() {
    expandValue = false;
    update();
  }

  updateSearchBoxTrue() {
    searchBoxValue = true;
    update();
  }

  updateSearchBoxFalse() {
    searchBoxValue = false;
    update();
  }

  /// THIS ARE WHEN USER SELECT FIELD AND USER ADD INPUT
  ///

  /// CLEAR ALL VALUE WHEN DATA IS ADDED

  clearData() {
    updateHyperLinkFalse();
    updateDropDownFalse();
    updateExpandFalse();
    updateSearchBoxFalse();
    hyperlinkController.clear();
    dropDownTextController.clear();
    labelController.clear();
    optionSelected = "Normal Field";
    isNewLine = false;
    isDisplayOnly = false;
    isControl = false;
    isRelated = false;
    isMasked = false;
    isFullWidth = false;
    isId = false;
    selectPageName = '';
    selectPageFieldIndex = null;
    selectPageFieldName = '';

    update();
  }

  updateState() {
    update();
  }

  /// EDIT LABEL FORM ADD PAGE
  editData({
    int? index,
    List? dropDownList,
    List? expandList,
    String? hyperLink,
    String? title,
    String? labelNameType,
    String? sequence,
    bool? newLine = false,
    bool? display_only = false,
    bool? control = false,
    bool? fullWidth = false,
    bool? related = false,
    bool? isId = false,
    bool? masked = false,
  }) {
    (dataOfMap['entries'] as List)[index!]['label'] = title;
    (dataOfMap['entries'] as List)[index]['sequence'] =
        int.parse(sequence.toString());
    (dataOfMap['entries'] as List)[index]['new_line'] = newLine;
    (dataOfMap['entries'] as List)[index]['is_id'] = isId;
    (dataOfMap['entries'] as List)[index]['display_only'] = display_only;
    (dataOfMap['entries'] as List)[index]['control'] = control;
    (dataOfMap['entries'] as List)[index]['fullWidth'] = fullWidth;
    (dataOfMap['entries'] as List)[index]['related'] = related;
    (dataOfMap['entries'] as List)[index]['masked'] = masked;
    if (labelNameType == 'DropDown') {
      (dataOfMap['entries'] as List)[index]['entry_type']['DropDown'] =
          dropDownList;
    }
    if (labelNameType == 'Hyperlink') {
      (dataOfMap['entries'] as List)[index]['entry_type']['Hyperlink'] =
          hyperLink;
    }
    if (labelNameType == 'Collapse Area') {
      (dataOfMap['entries'] as List)[index]['entry_type']['Collapse Area'] =
          expandList;
    }

    update();
  }

  /// REMOVE LABEL FORM ADD FORM
  removeData(int index) {
    (dataOfMap['entries'] as List).removeAt(index);
    update();
  }

  /// ADD ALL FORM DATA
  setDataOfMap(
    dynamic value,
    title,
    des,
    user,
    addTime,
    userUpdate,
    lastUpdate,
    menu,
    roles,
    organization,
    status,
    group,
  ) {
    (dataOfMap['entries'] as List).add(value);
    dataOfMap['name'] = title;
    dataOfMap['description'] = des;

    dataOfMap['menuType'] = menu;
    dataOfMap['created_user'] = user;
    dataOfMap['inserted_datetime'] = addTime;
    dataOfMap['last_updated_user'] = userUpdate;
    dataOfMap['last_updated'] = lastUpdate;
    dataOfMap['roles'] = roles;
    dataOfMap['organization'] = organization;
    dataOfMap['status'] = status;
    dataOfMap['group'] = group;
    LoggerUtils.logI('SET DAT OF MAP :- ${dataOfMap}');

    update();
  }

  /// ADD NEW FORM FIELD

  addNewFormField(context, int sequence) {
    setDataOfMap({
      'sequence': sequence,
      'label': labelController.text.trim(),
      'new_line': isNewLine,
      'is_id': isId,
      'display_only': isDisplayOnly,
      'control': isControl,
      'fullWidth': isFullWidth,
      'related': isRelated,
      'expand': false,
      'masked': isMasked,
      'entry_type': {
        optionSelected.toString(): optionSelected == 'Table'
            ? []
            : optionSelected == 'Collapse Area'
                ? expandList
                : optionSelected == 'Search Box' ||
                        optionSelected == 'Multi Search'
                    ? searchBoxData
                    : optionSelected == 'DropDown'
                        ? dropdownList
                        : optionSelected == 'Hyperlink'
                            ? hyperlinkController.text.trim().toString()
                            : null
      },
      'edit_code': optionSelected == 'Normal Field'
          ? jsonDecode(textFieldJson.replaceAll(
              "Flutter TextField", labelController.text.trim()))
          : {},
    },
        titleController.text,
        desController.text,
        '',
        DateTime.now().toString(),
        '',
        DateTime.now().toString(),
        selectTypeOfForm,
        selectedRoles,
        selectedOrganization,
        selectFormStatus,
        selectedGroup);

    Get.back();
    update();
  }

  /// THIS IS WHEN YOU SWITCH TAB AND REMOVE PREVIOUS FORM DATA
  clearForm() {
    dataOfMap = {"name": "", "description": "", "menuType": '', "entries": []};
    titleController.clear();
    desController.clear();

    selectTypeOfForm = '';
    selectFormStatus = '';
    selectedGroup.clear();
    selectedRoles.clear();
    selectedOrganization.clear();
  }

  /// THIS IS WHEN YOU SWITCH TAB AND REMOVE PREVIOUS FORM DATA
  ///

  ///  FOR ADD FORM ORGANIZATION TAB DATA
  String organizationId = '64883b90242068a622a4b646';
  String organizationLabel = 'Org ID';
  String organizationValueKey = 'Organisation Name';
  List<String> organizationItems = [];
  List<dynamic> getOrgFormData = [];

  Future<dynamic> getOrgSaveDataRepo({String? id, String? label}) async {
    var saveResponse = await APIService().getResponse(
        url: '${baseUrl}payload/$id/$label', apitype: APIType.aGet);
    print('------BASE  getALLFormSaveData-------${baseUrl}payload/$id/$label');

    return saveResponse;
  }

  ApiResponse _getOrgDataApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getOrgDataApiResponse => _getOrgDataApiResponse;

  Future<void> getOrgDataViewModel() async {
    _getOrgDataApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      getOrgFormData = await getOrgSaveDataRepo(
          label: '${organizationLabel}', id: '${organizationId}');
      organizationItems.clear();

      getOrgFormData.forEach((element) {
        element['payload'].forEach((element1) {
          if (element1['label'].toString().toLowerCase() ==
              organizationValueKey.toLowerCase()) {
            organizationItems.add(element1['value']);
          }
        });
      });

      print("getOrgFormData=response==>$getOrgFormData");

      _getOrgDataApiResponse = ApiResponse.complete(getOrgFormData);
    } catch (e) {
      print("getOrgFormData=e==>$e");
      _getOrgDataApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  ///  FOR ADD FORM ORGANIZATION TAB DATA
  ///

  ///  FOR ADD FORM ROLE TAB DATA

  List<String> rolesItem = [];
  String roleId = '64883ccb242068a622a4b64c';
  String roleLabel = 'Org ID';
  String roleKey = 'Role';
  List<dynamic> getRoleFormData = [];

  ApiResponse _getRoleDataApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getRoleDataApiResponse => _getRoleDataApiResponse;

  Future<void> getRoleDataViewModel() async {
    _getRoleDataApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      getRoleFormData =
          await getOrgSaveDataRepo(label: '${roleLabel}', id: '${roleId}');
      rolesItem.clear();

      getRoleFormData.forEach((element) {
        element['payload'].forEach((element1) {
          if (element1['label'].toString().toLowerCase() ==
              roleKey.toLowerCase()) {
            rolesItem.add(element1['value']);
          }
        });
      });

      print("getRoleFormData=response==>$getRoleFormData");

      _getRoleDataApiResponse = ApiResponse.complete(getRoleFormData);
    } catch (e) {
      print("getRoleFormData=e==>$e");
      _getRoleDataApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  ///  FOR ADD FORM ROLE TAB DATA
  ///

  ///  FOR ADD FORM NAVIGATION TAB DATA

  List<String> navigationItem = [];
  String navigationId = '6488402b242068a622a4b653';
  String navigationLabel = 'ORG ID';
  String navigationKey = 'Navigation';
  List<dynamic> getNavigationFormData = [];

  ApiResponse _getNavigationDataApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getNavigationDataApiResponse => _getNavigationDataApiResponse;

  Future<void> getNavigationDataViewModel({bool isLoading = true}) async {
    if (isLoading) {
      _getNavigationDataApiResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      getNavigationFormData = await getOrgSaveDataRepo(
          label: '${navigationLabel}', id: '${navigationId}');
      navigationItem.clear();

      getNavigationFormData.forEach((element) {
        element['payload'].forEach((element1) {
          if (element1['label'].toString().toLowerCase() ==
              navigationKey.toLowerCase()) {
            navigationItem.add(element1['value']);
          }
        });
      });

      print("getNavigationFormData=response==>$navigationItem");

      _getNavigationDataApiResponse =
          ApiResponse.complete(getNavigationFormData);
    } catch (e) {
      print("getNavigationFormData=e==>$e");
      _getNavigationDataApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  callAllApi() async {
    await getOrgDataViewModel();
    await getRoleDataViewModel();
    // await getNavigationDataViewModel();
  }
}
