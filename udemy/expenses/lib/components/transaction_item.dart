import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.tr,
    required this.onRemove,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(child: Text('R\$${tr.value}')),
          ),
        ),
        title: Text(tr.title, style: Theme.of(context).textTheme.headline6),
        subtitle: Text(DateFormat('d MMM y').format(tr.date)),
        trailing: MediaQuery.of(context).size.width > 400
            ? SizedBox(
                width: 90,
                child: TextButton(
                  onPressed: () => onRemove(tr.id),
                  style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
                  child: Row(
                    children: const [
                      Icon(Icons.delete),
                      Text('Excluir'),
                    ],
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => onRemove(tr.id),
              ),
      ),
    );
  }
}
