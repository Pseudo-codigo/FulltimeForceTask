import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  final String name;
  final String value;
  final bool separator;

  const RowItem({
    super.key,
    this.name = "",
    this.separator = false,
    this.value = "",
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        if (separator) const VerticalDivider(),
        Expanded(child: _singleItem(context, name, value)),
      ],
    ));
  }
}

Widget _singleItem(BuildContext context, String name, String value) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          softWrap: true,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
