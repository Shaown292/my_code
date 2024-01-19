class BankPaymentListResponseModel {
  bool? success;
  List<BankPaymentList>? data;
  String? message;

  BankPaymentListResponseModel({this.success, this.data, this.message});

  BankPaymentListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <BankPaymentList>[];
      json['data'].forEach((v) {
        data!.add(BankPaymentList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class BankPaymentList {
  List<ApproveList>? approve;
  List<PendingList>? pending;
  List<RejectList>? reject;

  BankPaymentList({this.approve, this.pending, this.reject});

  BankPaymentList.fromJson(Map<String, dynamic> json) {
    if (json['approve'] != null) {
      approve = <ApproveList>[];
      json['approve'].forEach((v) {
        approve!.add(ApproveList.fromJson(v));
      });
    }
    if (json['pending'] != null) {
      pending = <PendingList>[];
      json['pending'].forEach((v) {
        pending!.add(PendingList.fromJson(v));
      });
    }
    if (json['reject'] != null) {
      reject = <RejectList>[];
      json['reject'].forEach((v) {
        reject!.add(RejectList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (approve != null) {
      data['approve'] = approve!.map((v) => v.toJson()).toList();
    }
    if (pending != null) {
      data['pending'] = pending!.map((v) => v.toJson()).toList();
    }
    if (reject != null) {
      data['reject'] = reject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApproveList {
  String? studentName;
  ViewTransaction? viewTransaction;
  int? amount;
  String? date;
  String? note;
  String? file;
  String? status;

  ApproveList(
      {this.studentName,
        this.viewTransaction,
        this.amount,
        this.date,
        this.note,
        this.file,
        this.status});

  ApproveList.fromJson(Map<String, dynamic> json) {
    studentName = json['student_name'];
    viewTransaction = json['view_transaction'] != null
        ? ViewTransaction.fromJson(json['view_transaction'])
        : null;
    amount = json['amount'];
    date = json['date'];
    note = json['note'];
    file = json['file'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_name'] = studentName;
    if (viewTransaction != null) {
      data['view_transaction'] = viewTransaction!.toJson();
    }
    data['amount'] = amount;
    data['date'] = date;
    data['note'] = note;
    data['file'] = file;
    data['status'] = status;
    return data;
  }
}

class PendingList {
  String? studentName;
  ViewTransaction? viewTransaction;
  int? amount;
  String? date;
  String? note;
  String? file;
  String? status;

  PendingList(
      {this.studentName,
        this.viewTransaction,
        this.amount,
        this.date,
        this.note,
        this.file,
        this.status});

  PendingList.fromJson(Map<String, dynamic> json) {
    studentName = json['student_name'];
    viewTransaction = json['view_transaction'] != null
        ? ViewTransaction.fromJson(json['view_transaction'])
        : null;
    amount = json['amount'];
    date = json['date'];
    note = json['note'];
    file = json['file'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_name'] = studentName;
    if (viewTransaction != null) {
      data['view_transaction'] = viewTransaction!.toJson();
    }
    data['amount'] = amount;
    data['date'] = date;
    data['note'] = note;
    data['file'] = file;
    data['status'] = status;
    return data;
  }
}

class RejectList {
  String? studentName;
  ViewTransaction? viewTransaction;
  int? amount;
  String? date;
  String? note;
  String? file;
  String? status;

  RejectList(
      {this.studentName,
        this.viewTransaction,
        this.amount,
        this.date,
        this.note,
        this.file,
        this.status});

  RejectList.fromJson(Map<String, dynamic> json) {
    studentName = json['student_name'];
    viewTransaction = json['view_transaction'] != null
        ? ViewTransaction.fromJson(json['view_transaction'])
        : null;
    amount = json['amount'];
    date = json['date'];
    note = json['note'];
    file = json['file'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_name'] = studentName;
    if (viewTransaction != null) {
      data['view_transaction'] = viewTransaction!.toJson();
    }
    data['amount'] = amount;
    data['date'] = date;
    data['note'] = note;
    data['file'] = file;
    data['status'] = status;
    return data;
  }
}

class ViewTransaction {
  String? feesType;
  int? paidAmount;

  ViewTransaction({this.feesType, this.paidAmount});

  ViewTransaction.fromJson(Map<String, dynamic> json) {
    feesType = json['fees_type'];
    paidAmount = json['paid_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fees_type'] = feesType;
    data['paid_amount'] = paidAmount;
    return data;
  }
}
