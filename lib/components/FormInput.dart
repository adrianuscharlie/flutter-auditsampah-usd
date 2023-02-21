import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FormInput extends StatefulWidget {
  String title;
  int count;
  String id;
  final incrementItem;

  FormInput(
      {required this.title,
      required this.count,
      required this.id,
      required this.incrementItem});
  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    int _itemCount = widget.count;
    return Card(
      child: ListTile(
        title: Text(widget.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _itemCount != 0
                ? new IconButton(
                    icon: new Icon(Icons.remove),
                    onPressed: () => setState(() => _itemCount--),
                  )
                : new Container(),
            new Text(_itemCount.toString()),
            new IconButton(
                icon: new Icon(Icons.add), onPressed: widget.incrementItem())
          ],
        ),
      ),
    );
  }
}
