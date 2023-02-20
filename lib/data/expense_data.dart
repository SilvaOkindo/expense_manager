import 'package:expense_manager/datetime/datetime_helper.dart';
import 'package:expense_manager/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseData with ChangeNotifier {
  // list of all expenses
  List<ExpenseItem> overallExenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenses() {
    return overallExenseList;
  }

  // add expense
  void addNewExpense(ExpenseItem expenseItem) {
    overallExenseList.add(expenseItem);

    notifyListeners();
  }

  // get weekday
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thur";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();
    for (var i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(const Duration(days: 1));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpense() {
    Map<String, double> dailyExpenseSummary = {};
    for (var expense in overallExenseList) {
      String date = convertDatetimeToString(expense.date);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmout = dailyExpenseSummary[date]!;
        currentAmout += amount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}
