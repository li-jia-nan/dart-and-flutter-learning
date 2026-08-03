import 'package:flutter/material.dart';
import 'package:learning_app/model/travel_tab_model.dart' hide Image;
import 'package:transparent_image/transparent_image.dart';

// 瀑布流卡片
class TravelItemWidget extends StatelessWidget {
  final TravelItem item;
  final int? index;
  const TravelItemWidget({super.key, required this.item, this.index});

  Widget get _title => Container(
    padding: const EdgeInsets.all(4),
    child: Text(
      item.article.articleTitle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
    ),
  );

  Widget get _infoText => Container(
    padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_avatarAndNickName, _likeIconAndCount],
    ),
  );

  Widget get _avatarAndNickName => Row(
    children: [
      PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12),
        child: Image.network(item.article.author.coverImage.dynamicUrl, width: 24, height: 24),
      ),
      Container(
        padding: const EdgeInsets.all(5),
        width: 90,
        child: Text(
          item.article.author.nickName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    ],
  );

  Widget get _likeIconAndCount => Row(
    children: [
      const Icon(Icons.thumb_up, size: 14, color: Colors.grey),
      Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Text(item.article.likeCount.toString(), style: const TextStyle(fontSize: 10)),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点击跳转到H5页面
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_itemImage(context), _title, _infoText],
          ),
        ),
      ),
    );
  }

  Widget _itemImage(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minHeight: size.height / 2 - 10),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item.article.images[0].dynamicUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
