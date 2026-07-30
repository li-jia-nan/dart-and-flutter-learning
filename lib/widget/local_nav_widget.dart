import 'package:flutter/material.dart';
import 'package:learning_app/model/home_model.dart';

// 球区入口
class LocalNavWidget extends StatelessWidget {
  final List<LocalNavList> localNavList;
  const LocalNavWidget({super.key, required this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 4, 7, 4),
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(padding: const EdgeInsets.all(7), child: _items(context)),
    );
  }

  Widget _items(BuildContext context) {
    List<Widget> items = [];
    for (var model in localNavList) {
      items.add(_item(context, model));
    }
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: items);
  }

  Widget _item(BuildContext context, LocalNavList model) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(model.icon!, width: 32, height: 32),
          const SizedBox(height: 2),
          Text(model.title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
