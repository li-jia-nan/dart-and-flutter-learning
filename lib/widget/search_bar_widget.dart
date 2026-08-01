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
          Expanded(child: _textField),
          if (showClear)
            _wrapTap(Icon(Icons.clear, size: 22, color: Colors.grey), () {
              _controller.clear();
              _onChanged('');
            }),
        ],
      ),
    );
  }

  Widget get _homeSearchBar => Row(
    children: [
      _wrapTap(
        Container(
          padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
          child: Row(
            children: [
              Text('北京', style: TextStyle(color: _homeFontColor, fontSize: 20)),
              Icon(Icons.expand_more, size: 22, color: _homeFontColor),
            ],
          ),
        ),
        widget.leftButtonClick,
      ),
      Expanded(child: _inputBox),
      _wrapTap(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text('登出', style: TextStyle(fontSize: 18, color: _homeFontColor)),
        ),
        widget.rightButtonClick,
      ),
    ],
  );

  Color get _homeFontColor =>
      widget.searchBarType == SearchBarType.homeLight ? Colors.black54 : Colors.white;

  // 输入框
  Widget get _textField => widget.searchBarType == SearchBarType.normal
      ? TextField(
          controller: _controller,
          onChanged: _onChanged,
          autofocus: true,
          cursorColor: Colors.blue,
          cursorHeight: 20,
          style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 5, right: 5, bottom: 12),
            border: InputBorder.none,
            hintText: widget.hintText ?? '请输入搜索内容',
            hintStyle: const TextStyle(fontSize: 15),
          ),
        )
      : _wrapTap(
          Text(widget.defaultText ?? '', style: TextStyle(fontSize: 13, color: Colors.grey)),
          widget.inputBoxClick,
        );

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
    return widget.searchBarType == SearchBarType.normal ? _normalSearchBar : _homeSearchBar;
  }

  Widget _wrapTap(Widget child, void Function()? callback) {
    return GestureDetector(onTap: callback, child: child);
  }

  void _onChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}
