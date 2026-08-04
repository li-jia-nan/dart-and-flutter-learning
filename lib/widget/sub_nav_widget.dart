import 'package:flutter/material.dart';
import 'package:learning_app/model/home_model.dart';
import 'package:learning_app/utils/navigator_util.dart';

class SubNavWidget extends StatelessWidget {
  final List<LocalNavList>? subNavList;

  const SubNavWidget({super.key, this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 4, 7, 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Padding(padding: const EdgeInsets.all(7), child: _items(context)),
    );
  }

  Widget? _items(BuildContext context) {
    if (subNavList == null) {
      return null;
    }
    List<Widget> items = [];
    for (var model in subNavList!) {
      items.add(_item(context, model));
    }
    // 计算出第一行显示的数量
    int separate = (subNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(separate, subNavList!.length),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, LocalNavList model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          NavigatorUtil.jumpH5(
            context: context,
            url: model.url,
            title: model.title,
            hideAppBar: false,
            statusBarColor: 'ffffff',
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(model.icon!, width: 18, height: 18),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(model.title, style: const TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
