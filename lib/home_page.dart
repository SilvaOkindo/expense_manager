import 'package:expense_manager/component/expense_tile.dart';
import 'package:expense_manager/data/expense_data.dart';
import 'package:expense_manager/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  //add expense
  void addExpense() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Add new expense'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                // expense name
                TextField(
                  controller: expenseController,
                ),

                //expense amount
                TextField(
                  controller: amountController,
                )
              ]),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: const Text('save'),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text('cancel'),
                )
              ],
            ));
  }

  // save
  void save() {
    // new expense
    ExpenseItem expenseItem = ExpenseItem(
        name: expenseController.text,
        amount: amountController.text,
        date: DateTime.now());

    // save the expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(expenseItem);
    Navigator.pop(context);
    clear();
  }

  // cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    expenseController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: Colors.grey[300],
              floatingActionButton: FloatingActionButton(
                onPressed: addExpense,
                child: const Icon(Icons.add),
              ),
              body: ListView.builder(
                  itemCount: value.getAllExpenses().length,
                  itemBuilder: (_, index) => ExpenseTile(
                    name: value.getAllExpenses()[index].name, 
                    amount: value.getAllExpenses()[index].amount, 
                    dateTime: value.getAllExpenses()[index].date
                    )
              )
            ));
  }
}
