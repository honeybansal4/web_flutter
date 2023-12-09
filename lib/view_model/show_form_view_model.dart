import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:web_demo_satish/common_widget/logger.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';

class ShowSelectFormViewModel extends GetxController {
  /// THIS IS FOR GET FORM - DUMMY FORM AND THIER INPUTS
  Map<String, dynamic> getSelectForm = {};
  Map<String, dynamic> dummyGetSelectForm = {};
  List<dynamic> getSelectSaveForm = [];
  // List<dynamic> getParticularSaveForm = [];

  /// THIS IS FOR GET FORM AND THIER INPUTS
  ///

  /// THIS IS FOR WHEN YOU SAVE - UPDATE - EDIT FORM DATA AND SHOW LOADER
  bool isLoader = false;

  updateLoaderValue(bool value) {
    isLoader = value;
    update();
  }

  /// THIS IS FOR WHEN YOU SAVE - UPDATE - EDIT FORM DATA AND SHOW LOADER
  ///

  /// THIS IS FOR CREATE DUMMY MAP FOR WHEN SAVE FORM WITH NO LABEL
  updateDummyMap() {
    dummyGetSelectForm = json.decode(json.encode(getSelectForm));
    print('---DUMMY DATA---${dummyGetSelectForm}');
    update();
  }

  /// THIS IS FOR CREATE DUMMY MAP FOR WHEN SAVE FORM WITH NO LABEL
  ///

  /// GET SAVED FORM PAYLOAD ID FOR UPDATE PAGE

  String payloadId = '';

  updatePayloadId(String id) {
    payloadId = id;
    log('PLAY LOAD ID :- ${payloadId}');
  }

  /// GET SAVED FORM PAYLOAD ID
  ///

  /// SHOW SELECTED FORM SAVE DATA
  int selectedSaveForm = -1;

  updateSelectedSaveData(int index) {
    selectedSaveForm = index;
    print('---selectedSaveForm----${selectedSaveForm}');
    update();
  }

  /// SHOW SELECTED FORM SAVE DATA
  ///

  /// DECIDE UPDATE OR ADD FORM SAVED DATA
  bool save = false;

  updateSave(bool value) {
    save = value;
    update();
  }

  /// DECIDE UPDATE OR ADD FORM SAVED DATA
  ///

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
    (getSelectForm['entries'] as List)[index!]['label'] = title;
    (getSelectForm['entries'] as List)[index]['sequence'] =
        int.parse(sequence.toString());
    (getSelectForm['entries'] as List)[index]['new_line'] = newLine;
    (getSelectForm['entries'] as List)[index]['is_id'] = isId;
    (getSelectForm['entries'] as List)[index]['display_only'] = display_only;
    (getSelectForm['entries'] as List)[index]['control'] = control;
    (getSelectForm['entries'] as List)[index]['fullWidth'] = fullWidth;
    (getSelectForm['entries'] as List)[index]['related'] = related;
    (getSelectForm['entries'] as List)[index]['masked'] = masked;
    if (labelNameType == 'DropDown') {
      (getSelectForm['entries'] as List)[index]['entry_type']['DropDown'] =
          dropDownList;
    }
    if (labelNameType == 'Hyperlink') {
      (getSelectForm['entries'] as List)[index]['entry_type']['Hyperlink'] =
          hyperLink;
    }
    if (labelNameType == 'Collapse Area') {
      (getSelectForm['entries'] as List)[index]['entry_type']['Collapse Area'] =
          expandList;
    }

    update();
  }

  /// EDIT LABEL FORM ADD PAGE
  ///
  /// REMOVE LABEL FORM ADD FORM
  removeData(int index) {
    try {
      if (getSelectSaveForm.isNotEmpty) {
        for (int i = 0; i < getSelectSaveForm.length; i++) {
          (getSelectSaveForm[i]['payload'] as List).removeAt(index);
        }
      }
      (getSelectForm['entries'] as List).removeAt(index);
    } catch (e) {
      print('-------ERROR----$e');
    }
    update();
  }

  /// REMOVE LABEL FORM ADD FORM
  ///

  /// ADD FIELD
  setDataOfMap(dynamic value) {
    (getSelectForm['entries'] as List).add(value);

    LoggerUtils.logI('SET DAT OF MAP :- ${getSelectForm}');
    update();
  }

  /// ADD EDIT FIELD
  setEditFields(
      {String? labelController = '',
      bool? isNewLine = false,
      bool? isDisplayOnly = false,
      bool? isControl = false,
      bool? isFullWidth = false,
      bool? isRelated = false,
      bool? isMasked = false,
      bool? isId = false,
      int? sequence,
      String optionSelected = '',
      List? dropdownList,
      Map<String, dynamic>? searchList,
      List? expandList}) {
    try {
      if (getSelectSaveForm.isNotEmpty) {
        for (int i = 0; i < getSelectSaveForm.length; i++) {
          (getSelectSaveForm[i]['payload'] as List).add({
            "label": labelController,
            "value": optionSelected == 'Normal Field'
                ? ''
                : optionSelected == 'Check Box'
                    ? 'false'
                    : optionSelected == 'Datefield'
                        ? 'dd/mm/yyyy'
                        : optionSelected == 'TimeField'
                            ? 'Time'
                            : optionSelected == 'Long box'
                                ? ''
                                : optionSelected == 'Table'
                                    ? [
                                        ['NO'],
                                        [''],
                                      ]
                                    : null
          });
        }
        LoggerUtils.logI('-------SAVED DATA----${getSelectSaveForm}');
      } else {
        print('-----EDIT FORM ADD FIELD ---');
      }
    } catch (e) {
      print('-----EDIT FORM ADD FIELD ERROR---');
    }

    setDataOfMap({
      'sequence': sequence,
      'label': labelController,
      'new_line': isNewLine,
      'is_id': isId,
      'display_only': isDisplayOnly,
      'control': isControl,
      'fullWidth': isFullWidth,
      'related': isRelated,
      'expand': false,
      'masked': isMasked,
      'entry_type': {
        optionSelected.toString(): optionSelected == 'DropDown'
            ? dropdownList
            : optionSelected == 'Search Box' || optionSelected == 'Multi Search'
                ? searchList
                : optionSelected == 'Collapse Area'
                    ? expandList
                    : optionSelected == 'Table'
                        ? []
                        : null
      }
    });
    Get.back();
    update();
  }

  /// CLEAR FORM

  clearSelectForm() {
    if (getSelectSaveForm.isNotEmpty) {
      for (int i = 0; i < getSelectSaveForm.length; i++) {
        (getSelectSaveForm[i]['payload'] as List).clear();
      }
    }
    (getSelectForm['entries'] as List).clear();
    update();
  }

  /// SEARCH IS_ID FORM API CALL
  List isIdFormData = [];
  Map<String, dynamic> isIdDropDownValue = {};

  updateSearchFormValue(var data) {
    isIdDropDownValue = data;
    update();
  }

  Future<dynamic> isIdFormRepo({String? id}) async {
    var searchResponse = await APIService()
        .getResponse(url: '${baseUrl}is_id/$id', apitype: APIType.aGet);
    print('------BASE URL isIdFormRepo-------${baseUrl}is_id/$id');

    return searchResponse;
  }

  ApiResponse _searchIdFormApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get searchIdFormApiResponse => _searchIdFormApiResponse;

  Future<void> isIdFormViewModel({String? id}) async {
    _searchIdFormApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      isIdFormData = await isIdFormRepo(id: id);
      print("isIdFormViewModel=response==>$isIdFormData");

      _searchIdFormApiResponse = ApiResponse.complete(isIdFormData);
    } catch (e) {
      print("isIdFormViewModel=e==>$e");
      _searchIdFormApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// SEARCH IS_ID FORM API CALL
  ///

  /// SEARCH  FORM BY NAME API CALLING

  List searchFormData = [];
  String searchLabel = '';
  updateSearchLabel(String value) {
    searchLabel = value;
    update();
  }

  Future<dynamic> searchFormRepo(
      {String? id, String? name, String? searchText = ''}) async {
    var searchResponse = await APIService().getResponse(
        url: '${baseUrl}search/$name/$id?text=$searchText',
        apitype: APIType.aGet);
    print(
        '------BASE URLSEARCH FormRepo-------${baseUrl}search/$name/$id?text=$searchText');

    return searchResponse;
  }

  ApiResponse _searchFormApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get searchFormApiResponse => _searchFormApiResponse;

  Future<void> searchFormViewModel(
      {String? id,
      String? name,
      String? searchText = '',
      bool isLoading = true}) async {
    if (isLoading) {
      _searchFormApiResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      searchFormData =
          await searchFormRepo(id: id, name: name, searchText: searchText);
      print("SearchFormViewModel=response==>$searchFormData");

      _searchFormApiResponse = ApiResponse.complete(searchFormData);
    } catch (e) {
      print("SearchFormViewModel=e==>$e");
      _searchFormApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// SEARCH  FORM BY NAME API CALLING
  ///

  // /// GET PARTICULAR SAVE FORM DATA
  // Future<dynamic> searchParticularFormRepo(
  //     {String? fieldName, String? formId, String? fieldValue = ''}) async {
  //   var searchResponse = await APIService().getResponse(
  //       url: '${baseUrl}payload/all/$formId/$fieldName/$fieldValue',
  //       apitype: APIType.aGet);
  //   print(
  //       '------BASE URLSEARCH PARTICULAR FormRepo-------${baseUrl}payload/all/$formId/$fieldName/$fieldValue');
  //
  //   return searchResponse;
  // }
  //
  // ApiResponse _particularFormApiResponse =
  //     ApiResponse.initial(message: 'Initialization');
  //
  // ApiResponse get particularFormApiResponse => _particularFormApiResponse;
  //
  // Future<void> searchParticularFormViewModel(
  //     {String? fieldName,
  //     String? formId,
  //     String? fieldValue = '',
  //     bool isLoading = true}) async {
  //   if (isLoading) {
  //     _particularFormApiResponse = ApiResponse.loading(message: 'Loading');
  //   }
  //   update();
  //   try {
  //     searchFormData = await searchParticularFormRepo(
  //         fieldName: fieldName, fieldValue: fieldValue, formId: formId);
  //     print("SearchParticularFormViewModel=response==>$searchFormData");
  //
  //     _particularFormApiResponse = ApiResponse.complete(searchFormData);
  //   } catch (e) {
  //     print("SearchParticularFormViewModel=e==>$e");
  //     _particularFormApiResponse = ApiResponse.error(message: 'error');
  //   }
  //   update();
  // }
  /// GET FORM REPO
  Future<dynamic> getSelectFormRepo({String? formId}) async {
    var response = await APIService().getResponse(
      url: baseUrl + formId!,
      apitype: APIType.aGet,
    );
    print('------BASE URL getSelectForm-------$baseUrl');

    return response;
  }

  ApiResponse _showFormApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get showFormApiResponse => _showFormApiResponse;

  Future<void> showSelectFormViewModel(
      {bool loading = true, String? formId = ''}) async {
    if (loading) {
      _showFormApiResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      getSelectForm = await getSelectFormRepo(formId: formId);

      print('--------------${getSelectForm}');
      updateDummyMap();

      print("getSelectForm=response==>$getSelectForm");

      _showFormApiResponse = ApiResponse.complete(getSelectForm);
    } catch (e) {
      print("getSelectForm=e==>$e");

      _showFormApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// GET FORM REPO
  ///

  /// GET PARTICULAR SAVE FORM REPO

  Future<dynamic> getFormSaveDataRepo(
      {String? id, String? labelId, String? labelValue = ''}) async {
    String url = labelValue!.isNotEmpty
        ? '${baseUrl}payload/search/$id/$labelId?text=$labelValue'
        : '${baseUrl}payload/search/$id/$labelId?text=';
    print('------BASE URL 1getFormSaveData-------${url}');
    var saveResponse =
        await APIService().getResponse(url: url, apitype: APIType.aGet);

    return saveResponse;
  }

  ApiResponse _getFormDataApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getFormDataApiResponse => _getFormDataApiResponse;

  Future<void> getFormSaveDataViewModel(
      {String? id, String? labelId, String? labelValue = ''}) async {
    _getFormDataApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      getSelectSaveForm = await getFormSaveDataRepo(
          labelId: labelId, id: id, labelValue: labelValue);

      getSelectSaveForm.forEach((element) {
        for (int i = 0; i < (element['payload'] as List).length; i++) {
          (element['payload'][i] as Map<String, dynamic>)
              .addAll({'sequence': getSelectForm['entries'][i]['sequence']});
        }
      });
      try {
        getSelectSaveForm.forEach((element) {
          print('------HELOO---${element}');
          element['payload'].sort((a, b) {
            return (int.parse(a['sequence'].toString()))
                .compareTo(int.parse(b['sequence'].toString()));
          });
        });
      } catch (e) {
        print('------HELOO---${e}');
      }
      getSelectForm['entries'].sort((a, b) {
        return (int.parse(a['sequence'].toString()))
            .compareTo(int.parse(b['sequence'].toString()));
      });

      print("getSelectSaveForm1=response==>$getSelectSaveForm");

      _getFormDataApiResponse = ApiResponse.complete(getSelectSaveForm);
    } catch (e) {
      print("getSelectSaveForm=e1==>$e");
      _getFormDataApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// GET PARTICULAR SAVE FORM REPO
  ///

  /// GET ALL SAVED FORM REPO

  Future<dynamic> getEditFormSaveDataRepo({String? id, String? label}) async {
    var saveResponse = await APIService().getResponse(
        url: '${baseUrl}payload/$id/$label', apitype: APIType.aGet);
    print('------BASE URL2 getFormSaveData-------${baseUrl}payload/$id/$label');

    return saveResponse;
  }

  ApiResponse _getEditFormDataApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getEditFormDataApiResponse => _getEditFormDataApiResponse;

  Future<void> getEditFormSaveDataViewModel({String? id, String? label}) async {
    _getEditFormDataApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      getSelectSaveForm = await getEditFormSaveDataRepo(label: label, id: id);

      print("getSelectSaveForm2=response==>$getSelectSaveForm");

      _getEditFormDataApiResponse = ApiResponse.complete(getSelectSaveForm);
    } catch (e) {
      print("getSelectSaveForm2=e==>$e");
      _getEditFormDataApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// GET ALL SAVED FORM REPO
  ///

  updateData() {
    update();
  }
}
