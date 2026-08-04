import 'package:flutter/material.dart';
import 'package:learning_app/model/home_model.dart';
import 'package:learning_app/utils/navigator_util.dart';

// 网格卡片
class GridNavWidget extends StatelessWidget {
  final GridNav gridNavModel;
  const GridNavWidget({super.key, required this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Column(children: _gridNavItems(context)),
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNavModel.hotel, true));
    items.add(_gridNavItem(context, gridNavModel.flight, false));
    items.add(_gridNavItem(context, gridNavModel.travel, false));
    return items;
  }

  Widget _gridNavItem(BuildContext context, Flight gridNavItem, bool isFirst) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    List<Widget> expandItems = [];
    for (var item in items) {
      expandItems.add(Expanded(flex: 1, child: item));
    }
    final startColor = _parseColor(gridNavItem.startColor);
    final endColor = _parseColor(gridNavItem.endColor);
    return Container(
      height: 88,
      margin: isFirst ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(children: expandItems),
    );
  }

  Color _parseColor(String hexColor) {
    final hex = hexColor.replaceFirst('#', '');
    final colorValue = hex.length == 6 ? 'FF$hex' : hex;
    return Color(int.parse(colorValue, radix: 16));
  }

  Widget _mainItem(BuildContext context, LocalNavList model) {
    return _wrapGesture(
      context,
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.network(
            model.icon!,
            fit: BoxFit.contain,
            width: 121,
            height: 88,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: const EdgeInsets.only(top: 11),
            child: Text(model.title, style: const TextStyle(fontSize: 14, color: Colors.white)),
          ),
        ],
      ),
      model,
    );
  }

  Widget _wrapGesture(BuildContext context, Widget widget, LocalNavList model) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.jumpH5(
          context: context,
          url: model.url,
          title: model.title,
          hideAppBar: model.hideAppBar,
          statusBarColor: model.statusBarColor,
        );
      },
      child: widget,
    );
  }

  // 右侧的上下 item
  Widget _doubleItem(BuildContext context, LocalNavList topItem, LocalNavList bottomItem) {
    return Column(
      children: [
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false)),
      ],
    );
  }

  Widget _item(BuildContext context, LocalNavList item, bool isFirst) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: borderSide,
          bottom: isFirst ? const BorderSide(width: 0.8, color: Colors.white) : BorderSide.none,
        ),
      ),
      child: _wrapGesture(
        context,
        Center(
          child: Text(item.title, style: const TextStyle(fontSize: 14, color: Colors.white)),
        ),
        item,
      ),
    );
  }
}
