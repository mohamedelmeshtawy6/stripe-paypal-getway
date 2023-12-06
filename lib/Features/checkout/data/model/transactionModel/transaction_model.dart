import 'amount.dart';
import 'item_list.dart';

class TransactionModel {
  Amount? amount;
  String? description;
  ItemList? itemList;

  TransactionModel({this.amount, this.description, this.itemList});

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        amount: json['amount'] == null
            ? null
            : Amount.fromJson(json['amount'] as Map<String, dynamic>),
        description: json['description'] as String?,
        itemList: json['item_list'] == null
            ? null
            : ItemList.fromJson(json['item_list'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'amount': amount?.toJson(),
        'description': description,
        'item_list': itemList?.toJson(),
      };
}
