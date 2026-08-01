import 'package:flutter/material.dart';

// 定义 SearchBar 的三种样式
// home 首页默认状态使用的样式
// homeLight 首页上滑后高亮状态使用的样式
// normal 搜索页面使用的样式

enum SearchBarType { home, homeLight, normal }

class SearchBarWidget extends StatefulWidget {
  // 是否隐藏左侧的返回按钮
  final bool? hideLeft;

  // 搜索框的类型
  final SearchBarType searchBarType;

  // 提示文案
  final String? hintText;

  // 默认内容
  final String? defaultText;

  // 左侧按钮点击的回调
  final void Function()? leftButtonClick;

  // 右侧按钮点击的回调
  final void Function()? rightButtonClick;

  // 输入框的回调
  final void Function()? inputBoxClick;

  // 输入内容变化的回调
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    this.hideLeft,
    this.searchBarType = SearchBarType.normal,
    this.hintText,
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.inputBoxClick,
    this.onChanged,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  Widget get _normalSearchBar => Row(
    children: [
      // 左侧返回按钮
      _wrapTap(
        Padding(padding: const EdgeInsets.fromLTRB(6, 5, 10, 5), child: _backBtn),
        widget.inputBoxClick,
      ),
      Expanded(child: _inputBox),
      // 右侧搜索按钮
      _wrapTap(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: const Text('搜索', style: TextStyle(fontSize: 17, color: Colors.blue)),
        ),
        widget.rightButtonClick,
      ),
    ],
  );

  Widget? get _backBtn =>
      widget.hideLeft ?? false ? null : Icon(Icons.arrow_back_ios, color: Colors.grey, size: 26);

  Widget get _inputBox {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = const Color(0xffededed);
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normal ? 5 : 15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal ? Color(0xffa9a9a9) : Colors.blue,
          ),
          Expanded(child: Container()),
          // todo: 实现清除按钮
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.defaultText != null) {
      _controller.text = widget.defaultText!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _normalSearchBar;
  }

  Widget _wrapTap(Widget child, void Function()? callback) {
    return GestureDetector(onTap: callback, child: child);
  }
}
