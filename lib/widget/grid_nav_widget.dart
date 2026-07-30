import 'package:flutter/material.dart';
import 'package:learning_app/model/home_model.dart';

// 网格卡片
class GridNavWidget extends StatelessWidget {
  final GridNav gridNavModel;
  const GridNavWidget({super.key, required this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(children: _gridNavItems(context)),
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
        //
      },
      child: widget,
    );
  }
}
