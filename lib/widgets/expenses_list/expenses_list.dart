import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
    required this.onOpenAddExpenseOverlayForUpdate,
  });

  final List<Expense> expenses;

  final void Function(Expense expense) onRemoveExpense;
  final void Function(Expense expense, int index) onOpenAddExpenseOverlayForUpdate;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: GestureDetector(
          onDoubleTap: () {
            onOpenAddExpenseOverlayForUpdate(expenses[index], index);
          },
          child: ExpenseItem(expenses[index]),
        ),
      ),
    );
  }
}
