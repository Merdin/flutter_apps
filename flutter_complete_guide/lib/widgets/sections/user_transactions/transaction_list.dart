import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionsList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 10),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                final transaction = transactions[index];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transaction.amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction.date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            label: Text(
                              'Delete',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            onPressed: () => deleteTransaction(index))
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).colorScheme.error,
                            onPressed: () => deleteTransaction(index),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            );
    });
  }
}
