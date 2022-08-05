class CodeDataModel {
  int? count;
  String? message;
  String? searchCriteria;
  List<Results>? results;

  CodeDataModel({this.count, this.message, this.searchCriteria, this.results});

  CodeDataModel.fromJson(Map<String, dynamic> json) {
    count = json['Count'];
    message = json['Message'];
    searchCriteria = json['SearchCriteria'];
    if (json['Results'] != null) {
      results = <Results>[];
      json['Results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Count'] = this.count;
    data['Message'] = this.message;
    data['SearchCriteria'] = this.searchCriteria;
    if (this.results != null) {
      data['Results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? value;
  String? valueId;
  String? variable;
  int? variableId;

  Results({this.value, this.valueId, this.variable, this.variableId});

  Results.fromJson(Map<String, dynamic> json) {
    value = json['Value'];
    valueId = json['ValueId'];
    variable = json['Variable'];
    variableId = json['VariableId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Value'] = this.value;
    data['ValueId'] = this.valueId;
    data['Variable'] = this.variable;
    data['VariableId'] = this.variableId;
    return data;
  }
}
