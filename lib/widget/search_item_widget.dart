import 'package:flutter/material.dart';
import 'package:learning_app/model/search_model.dart';

class SearchItemWidget extends StatelessWidget {
  final SearchItem searchItem;
  const SearchItemWidget({super.key, required this.searchItem});

  Widget get _item => Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
    ),
    child: Row(
      children: [
        // 左侧图片
        // Image.network(searchItem.url, width: 100, height: 80, fit: BoxFit.cover),
        Column(
          children: [
            SizedBox(width: 300, child: _title),
            Container(width: 300, margin: const EdgeInsets.only(top: 5), child: _subTitle),
          ],
        ),
      ],
    ),
  );

  Widget get _title => Text(
    searchItem.word,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );

  Widget get _subTitle => RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: searchItem.price,
          style: const TextStyle(fontSize: 16, color: Colors.orange),
        ),
        TextSpan(
          text: searchItem.star,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点击搜索结果项的回调
      },
      child: _item,
    );
  }
}
