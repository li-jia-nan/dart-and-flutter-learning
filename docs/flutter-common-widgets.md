# Flutter 常用 Widget 新手速查

> 适用环境：Flutter 3.44.x、Dart 3.12.x、Material 3
> 这不是完整的 Widget 字典，而是一份按开发场景组织的入门地图。

## 1. 先建立一个正确认识

Flutter 中几乎所有界面元素都是 Widget：文字、图片、按钮是 Widget，间距、对齐、滚动和页面骨架也是 Widget。

实际开发不是从几百个 Widget 中猜答案，而是不断回答下面几个问题：

1. 页面骨架是什么？
2. 内容横着排、竖着排，还是叠在一起？
3. 子元素怎样占用空间、怎样留白？
4. 内容是否可能超出屏幕，需要滚动吗？
5. 用户能否点击或输入？
6. 数据变化后，哪一部分界面需要重新构建？

一个常见页面可以从外到内拆成：

```text
MaterialApp
└── Scaffold
    ├── AppBar
    └── SafeArea
        └── Padding
            └── Column
                ├── Text
                ├── TextField
                └── Expanded
                    └── ListView
```

### `child` 和 `children`

这是阅读 Widget 树时最先要熟悉的规律：

- `child`：只能放一个直接子 Widget，例如 `Center`、`Padding`、`Container`。
- `children`：可以放多个直接子 Widget，例如 `Row`、`Column`、`Stack`、`ListView`。
- 只有一个 `child` 但想放多个元素时，先用 `Row`、`Column` 或 `Stack` 把它们组合起来。

---

## 2. 新手应优先掌握的核心 Widget

不需要一次记住全部。先熟练下面这些，就足以完成大多数普通页面。

| 目的           | 优先掌握                                                        |
| -------------- | --------------------------------------------------------------- |
| 应用和页面骨架 | `MaterialApp`、`Scaffold`、`AppBar`、`SafeArea`                 |
| 显示内容       | `Text`、`Icon`、`Image`                                         |
| 包裹和留白     | `Container`、`Padding`、`SizedBox`、`Center`                    |
| 横向或纵向布局 | `Row`、`Column`                                                 |
| 分配剩余空间   | `Expanded`、`Flexible`、`Spacer`                                |
| 层叠布局       | `Stack`、`Positioned`                                           |
| 滚动内容       | `ListView.builder`、`GridView.builder`、`SingleChildScrollView` |
| 常见条目       | `Card`、`ListTile`、`Divider`                                   |
| 点击操作       | `FilledButton`、`OutlinedButton`、`TextButton`、`IconButton`    |
| 输入和表单     | `TextField`、`TextFormField`、`Form`                            |
| 本地状态       | `StatefulWidget`、`setState`                                    |
| 路由跳转       | `Navigator`、`MaterialPageRoute`                                |
| 异步界面       | `FutureBuilder`、`StreamBuilder`                                |

---

## 3. 按场景查找 Widget

### 3.1 应用与页面骨架

| Widget         | 用途                           | 常用属性或提示                                                            |
| -------------- | ------------------------------ | ------------------------------------------------------------------------- |
| `MaterialApp`  | Material 应用的根节点          | `theme`、`home`、`routes`、`routerConfig`                                 |
| `CupertinoApp` | iOS 风格应用的根节点           | 不要和 `MaterialApp` 同时作为根节点                                       |
| `Scaffold`     | 一张 Material 页面的大骨架     | `appBar`、`body`、`drawer`、`bottomNavigationBar`、`floatingActionButton` |
| `AppBar`       | 顶部应用栏                     | `title`、`leading`、`actions`                                             |
| `SafeArea`     | 避开刘海、状态栏和系统手势区域 | 页面主体靠近屏幕边缘时常用                                                |
| `Theme`        | 给一棵子树提供局部主题         | 全局主题一般放在 `MaterialApp.theme`                                      |

最小页面骨架：

```dart
MaterialApp(
  theme: ThemeData(
    colorSchemeSeed: Colors.indigo,
    useMaterial3: true,
  ),
  home: Scaffold(
    appBar: AppBar(
      title: const Text('首页'),
    ),
    body: const SafeArea(
      child: Center(
        child: Text('Hello Flutter'),
      ),
    ),
  ),
);
```

> `Scaffold` 通常代表一整张页面，不要给页面中的每个小区域都套一个 `Scaffold`。

### 3.2 布局、尺寸与间距

#### 基础布局

| Widget       | 用途                        | 什么时候用                        |
| ------------ | --------------------------- | --------------------------------- |
| `Row`        | 子元素横向排列              | 一行按钮、头像和昵称              |
| `Column`     | 子元素纵向排列              | 表单、详情页、垂直信息块          |
| `Wrap`       | 空间不足时自动换行          | 标签、Chip、数量不固定的按钮      |
| `Stack`      | 子元素层叠                  | 图片上的角标、悬浮元素            |
| `Positioned` | 指定 `Stack` 中子元素的位置 | 必须作为 `Stack` 的直接子元素使用 |
| `Center`     | 子元素居中                  | 水平和垂直同时居中                |
| `Align`      | 按指定方向对齐              | `Alignment.topRight` 等           |

#### 尺寸和空间

| Widget           | 用途                               | 关键区别                              |
| ---------------- | ---------------------------------- | ------------------------------------- |
| `Padding`        | 给子元素增加内边距                 | 只负责内边距，意图最清晰              |
| `SizedBox`       | 固定尺寸或添加空隙                 | `SizedBox(height: 16)` 很适合表示间距 |
| `Container`      | 尺寸、内外边距、背景和边框等组合   | 功能多，但不要把所有布局都无脑套进它  |
| `Expanded`       | 强制占满 `Row`/`Column` 的剩余空间 | 只能放在 `Row`、`Column` 或 `Flex` 中 |
| `Flexible`       | 可以使用剩余空间，但允许比它更小   | 比 `Expanded` 的约束更宽松            |
| `Spacer`         | 按比例占用弹性空白                 | 只用于 `Row`、`Column` 或 `Flex`      |
| `ConstrainedBox` | 给子元素添加最小/最大尺寸约束      | 限制弹窗、卡片、输入框尺寸            |
| `AspectRatio`    | 保持宽高比                         | 视频、封面图                          |
| `FittedBox`      | 按规则缩放子元素                   | 内容需要缩放进指定区域                |

横向布局示例：

```dart
Row(
  children: [
    const CircleAvatar(
      child: Icon(Icons.person),
    ),
    const SizedBox(width: 12),
    const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('小明'),
          Text(
            '这是一段可能很长的个人简介',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.more_vert),
      tooltip: '更多',
    ),
  ],
);
```

记住两组方向：

- `Row` 的主轴是横向，`Column` 的主轴是纵向。
- `mainAxisAlignment` 控制主轴，`crossAxisAlignment` 控制交叉轴。

层叠布局示例：

```dart
Stack(
  children: [
    const AspectRatio(
      aspectRatio: 16 / 9,
      child: ColoredBox(color: Colors.black12),
    ),
    Positioned(
      top: 8,
      right: 8,
      child: Chip(
        label: const Text('NEW'),
        backgroundColor: Colors.orange.shade100,
      ),
    ),
  ],
);
```

### 3.3 文字、图片和信息展示

| Widget                      | 用途                   | 常用写法或提醒                                      |
| --------------------------- | ---------------------- | --------------------------------------------------- |
| `Text`                      | 普通文字               | `style`、`maxLines`、`overflow`、`textAlign`        |
| `Text.rich` / `RichText`    | 一段文字中使用多种样式 | 简单场景优先 `Text.rich`                            |
| `Icon`                      | Material 图标          | 通常搭配 `Icons.*`                                  |
| `Image.asset`               | 项目内图片             | 先在 `pubspec.yaml` 声明资源                        |
| `Image.network`             | 网络图片               | 处理 `loadingBuilder` 和 `errorBuilder`             |
| `CircleAvatar`              | 圆形头像或首字母       | `backgroundImage`、`child`                          |
| `Card`                      | 有视觉分组的内容卡片   | 常与 `ListTile` 配合                                |
| `ListTile`                  | 标准的一行信息         | `leading`、`title`、`subtitle`、`trailing`、`onTap` |
| `Divider`                   | 水平分隔线             | 列表中也可使用 `ListView.separated`                 |
| `Chip`                      | 标签、筛选项等紧凑信息 | 相关组件还有 `FilterChip`、`ChoiceChip`             |
| `Badge`                     | 小型状态或数量角标     | 可包裹在图标外层                                    |
| `CircularProgressIndicator` | 圆形加载状态           | 不确定进度时不传 `value`                            |
| `LinearProgressIndicator`   | 线性进度               | 确定进度时 `value` 取 0 到 1                        |

网络图片建议至少提供失败状态：

```dart
Image.network(
  imageUrl,
  width: 96,
  height: 96,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return const SizedBox(
      width: 96,
      height: 96,
      child: Icon(Icons.broken_image_outlined),
    );
  },
);
```

### 3.4 列表、网格和滚动

先根据内容类型选择：

| 场景                                    | 推荐 Widget                          |
| --------------------------------------- | ------------------------------------ |
| 少量内容组成的整页偶尔需要滚动          | `SingleChildScrollView` + `Column`   |
| 长列表或数量不确定                      | `ListView.builder`                   |
| 长列表且条目之间有分隔                  | `ListView.separated`                 |
| 网格内容                                | `GridView.builder`                   |
| 一页一页滑动                            | `PageView`                           |
| 下拉刷新                                | `RefreshIndicator` 包裹可滚动 Widget |
| 顶部栏随滚动展开/收起，或混合列表与网格 | `CustomScrollView` + Sliver 系列     |

长列表应使用懒构建：

```dart
ListView.separated(
  itemCount: users.length,
  separatorBuilder: (context, index) => const Divider(height: 1),
  itemBuilder: (context, index) {
    final user = users[index];
    return ListTile(
      leading: CircleAvatar(child: Text(user.name.substring(0, 1))),
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () {},
    );
  },
);
```

网格示例：

```dart
GridView.builder(
  padding: const EdgeInsets.all(16),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 3 / 2,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    return Card(
      child: Center(
        child: Text(products[index].name),
      ),
    );
  },
);
```

几个重要区别：

- `Column` 本身不能滚动，内容超出屏幕时通常改用 `ListView`。
- 数据很多时不要使用 `SingleChildScrollView + Column` 一次性创建全部子元素。
- `ListView(children: [...])` 适合少量、固定条目；大量数据使用 `ListView.builder`。
- `shrinkWrap: true` 会增加布局成本，不要把它当成解决嵌套滚动问题的默认开关。

### 3.5 按钮、点击和手势

#### Material 3 按钮

| Widget                 | 适合的操作                           |
| ---------------------- | ------------------------------------ |
| `FilledButton`         | 页面中最重要的主操作                 |
| `FilledButton.tonal`   | 强调程度低于主操作的次重要操作       |
| `OutlinedButton`       | 次要操作                             |
| `TextButton`           | 低强调操作、对话框操作               |
| `IconButton`           | 只有图标的紧凑操作                   |
| `FloatingActionButton` | 当前页面最主要的悬浮操作             |
| `ElevatedButton`       | 需要阴影强调的按钮；旧项目中也很常见 |

```dart
Wrap(
  spacing: 12,
  runSpacing: 8,
  children: [
    FilledButton(
      onPressed: _save,
      child: const Text('保存'),
    ),
    OutlinedButton(
      onPressed: _preview,
      child: const Text('预览'),
    ),
    TextButton(
      onPressed: _cancel,
      child: const Text('取消'),
    ),
  ],
);
```

#### 自定义点击区域

| Widget            | 用途                               | 提示                             |
| ----------------- | ---------------------------------- | -------------------------------- |
| `InkWell`         | 带 Material 水波纹的点击区域       | 祖先中需要有 `Material`          |
| `GestureDetector` | 点击、双击、长按、拖动、缩放等手势 | 没有默认视觉反馈                 |
| `Dismissible`     | 滑动删除列表项                     | 为每个条目提供稳定且唯一的 `Key` |
| `IgnorePointer`   | 让子树暂时不接收指针事件           | 子树仍正常绘制                   |

如果只是普通操作，优先使用语义和反馈都更完整的标准按钮；确实需要自定义点击区域时再用 `InkWell` 或 `GestureDetector`。

### 3.6 输入、选择与表单

| Widget                 | 用途                             | 常用属性或提醒                                            |
| ---------------------- | -------------------------------- | --------------------------------------------------------- |
| `TextField`            | 单个文本输入                     | `controller`、`decoration`、`keyboardType`、`obscureText` |
| `Form`                 | 组织一组可验证、可保存的表单字段 | 通常配合 `GlobalKey<FormState>`                           |
| `TextFormField`        | 带表单验证能力的文本输入         | `validator`、`onSaved`                                    |
| `Checkbox`             | 多选或开关某个布尔值             | `value`、`onChanged`                                      |
| `RadioGroup` + `Radio` | 从一组选项中单选                 | 新代码优先由 `RadioGroup` 管理组值                        |
| `Switch`               | 打开或关闭一项设置               | 适合立即生效的布尔设置                                    |
| `Slider`               | 从连续范围中选择数值             | `min`、`max`、`divisions`                                 |
| `DropdownMenu`         | 从下拉列表选择一项               | Material 3 新代码优先考虑                                 |
| `Autocomplete`         | 输入时匹配候选项                 | 搜索框、城市和标签选择                                    |

表单验证示例：

```dart
final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: Column(
    children: [
      TextFormField(
        decoration: const InputDecoration(
          labelText: '邮箱',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          final text = value?.trim() ?? '';
          if (text.isEmpty) return '请输入邮箱';
          if (!text.contains('@')) return '邮箱格式不正确';
          return null;
        },
      ),
      const SizedBox(height: 16),
      FilledButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // 验证通过后提交
          }
        },
        child: const Text('提交'),
      ),
    ],
  ),
);
```

`TextEditingController`、`FocusNode` 等对象由 `State` 创建时，通常也要在 `dispose` 中释放：

```dart
@override
void dispose() {
  controller.dispose();
  focusNode.dispose();
  super.dispose();
}
```

### 3.7 导航、标签页和消息反馈

| Widget / API                      | 用途                       |
| --------------------------------- | -------------------------- |
| `Navigator` + `MaterialPageRoute` | 页面入栈、出栈             |
| `NavigationBar`                   | Material 3 底部主导航      |
| `BottomNavigationBar`             | 旧项目中常见的底部导航     |
| `NavigationRail`                  | 平板或桌面端侧边主导航     |
| `Drawer`                          | 从侧面滑出的导航抽屉       |
| `TabBar` + `TabBarView`           | 同一页面内的标签切换       |
| `DefaultTabController`            | 简化标签页控制             |
| `PopScope`                        | 处理系统返回或页面退出     |
| `Hero`                            | 两个路由之间的共享元素动画 |
| `ScaffoldMessenger` + `SnackBar`  | 显示短暂的底部提示         |
| `showDialog` + `AlertDialog`      | 需要用户关注或确认的对话框 |
| `showModalBottomSheet`            | 从底部弹出操作或内容面板   |

打开页面并接收返回值：

```dart
final result = await Navigator.of(context).push<String>(
  MaterialPageRoute(
    builder: (context) => const DetailPage(),
  ),
);
```

关闭当前页面并返回值：

```dart
Navigator.of(context).pop('saved');
```

显示提示：

```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('保存成功'),
  ),
);
```

> 中大型项目经常使用声明式路由或路由包，但理解 `Navigator.push` 和 `pop` 仍是基础。

### 3.8 状态与异步数据

#### `StatelessWidget` 和 `StatefulWidget`

| 类型              | 什么时候用                                                   |
| ----------------- | ------------------------------------------------------------ |
| `StatelessWidget` | 只根据传入参数展示界面，自身不管理可变状态                   |
| `StatefulWidget`  | 需要管理当前选中项、输入状态、加载状态、动画控制器等局部状态 |

最小局部状态示例：

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        setState(() {
          count++;
        });
      },
      child: Text('点击次数：$count'),
    );
  }
}
```

`setState` 的含义是“状态已改变，请重新执行这一小棵 Widget 树的 `build`”，不要把耗时任务放进它的回调中。

#### 异步构建

| Widget                   | 适用场景                              |
| ------------------------ | ------------------------------------- |
| `FutureBuilder`          | 等待一次异步结果，例如一次网络请求    |
| `StreamBuilder`          | 持续接收一连串异步数据                |
| `ValueListenableBuilder` | 监听 `ValueNotifier` 等轻量状态       |
| `AnimatedBuilder`        | 监听 `Listenable`，常用于动画或控制器 |

`FutureBuilder` 示例：

```dart
FutureBuilder<List<User>>(
  future: usersFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (snapshot.hasError) {
      return Center(
        child: Text('加载失败：${snapshot.error}'),
      );
    }

    final users = snapshot.data ?? [];
    if (users.isEmpty) {
      return const Center(
        child: Text('暂无数据'),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].name),
        );
      },
    );
  },
);
```

> 不要在 `build` 中反复调用会创建新 `Future` 的请求方法。通常在 `initState` 中创建并保存 `Future`，或由状态管理层提供它。

### 3.9 动画与视觉处理

新手先掌握隐式动画：只修改目标属性，Flutter 自动完成中间过程。

| Widget                  | 用途                               |
| ----------------------- | ---------------------------------- |
| `AnimatedContainer`     | 自动过渡尺寸、颜色、边距、圆角等   |
| `AnimatedOpacity`       | 淡入淡出                           |
| `AnimatedAlign`         | 平滑改变对齐位置                   |
| `AnimatedSwitcher`      | 两个不同子 Widget 之间切换动画     |
| `TweenAnimationBuilder` | 对任意可插值数值做简单动画         |
| `Hero`                  | 页面之间的共享元素过渡             |
| `ClipRRect`             | 按圆角矩形裁剪                     |
| `Opacity`               | 设置透明度；频繁使用时留意渲染成本 |
| `Transform`             | 平移、旋转、缩放                   |

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 250),
  curve: Curves.easeOut,
  width: selected ? 160 : 100,
  height: 48,
  decoration: BoxDecoration(
    color: selected ? Colors.indigo : Colors.grey,
    borderRadius: BorderRadius.circular(selected ? 24 : 8),
  ),
);
```

当隐式动画无法表达复杂的时间控制、重复、暂停或多个动画联动时，再学习 `AnimationController`、`Tween` 和显式动画。

### 3.10 响应式布局与无障碍

| Widget               | 用途                                 | 提示                        |
| -------------------- | ------------------------------------ | --------------------------- |
| `LayoutBuilder`      | 根据父组件提供的可用尺寸改变布局     | 组件级响应式布局优先考虑    |
| `MediaQuery`         | 获取窗口尺寸、系统内边距、文字缩放等 | 读取整个屏幕或系统信息      |
| `OrientationBuilder` | 根据横屏/竖屏构建不同布局            | 只关心方向时使用            |
| `SafeArea`           | 避开系统遮挡区域                     | 常包裹页面主体              |
| `Semantics`          | 补充辅助功能所需的语义               | 自定义交互组件尤其重要      |
| `Tooltip`            | 为图标操作提供文字说明               | `IconButton.tooltip` 更简洁 |

根据可用宽度切换布局：

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth >= 700) {
      return Row(
        children: [
          const SizedBox(width: 240, child: SideMenu()),
          Expanded(child: content),
        ],
      );
    }

    return content;
  },
);
```

---

## 4. 开发时怎么记住这么多 Widget

答案是：不需要全部背下来。应该记“需求到 Widget 的映射”，而不是背 API 列表。

### 4.1 先记五组问题

遇到界面需求时按顺序问：

```text
要展示什么？
→ Text / Icon / Image / Card / ListTile

要怎样排列？
→ Row / Column / Wrap / Stack

要怎样占空间？
→ Padding / SizedBox / Expanded / Flexible / Align

内容会不会超出？
→ ListView / GridView / SingleChildScrollView / PageView

用户怎样操作，数据怎样变化？
→ Button / TextField / GestureDetector
→ StatefulWidget / FutureBuilder / StreamBuilder
```

只要能描述当前问题，通常就能把候选 Widget 缩小到两三个。

### 4.2 分三个熟练度层级

**第一层：必须凭记忆写出**

`Scaffold`、`Text`、`Padding`、`SizedBox`、`Row`、`Column`、`Expanded`、`ListView.builder`、常用按钮、`TextField`、`StatefulWidget`。

**第二层：记住名字和使用场景**

`Stack`、`Wrap`、`GridView`、`Form`、`FutureBuilder`、`NavigationBar`、`LayoutBuilder`、`AnimatedContainer`。

**第三层：知道需要时去查**

Sliver 系列、复杂动画、自定义滚动、自定义绘制和高级手势。

### 4.3 让 IDE 代替你记参数

- 输入 Widget 名后使用自动补全查看构造参数。
- 把光标放在 Widget 上查看快速文档和类型。
- 使用编辑器的 “Wrap with widget” 快速包裹 `Padding`、`Expanded` 等。
- 看到布局异常时使用 Flutter Inspector 查看 Widget 树和约束。
- 不确定用哪个组件时，按“想实现的行为”搜索官方 Widget catalog，而不是靠猜名字。

真正值得记住的是：

- 它解决什么问题；
- 它接收一个 `child` 还是多个 `children`；
- 它对尺寸、滚动和状态有什么约束；
- 最常用的两三个属性是什么。

### 4.4 用三个小页面练习

比背表格更有效的练习顺序：

1. **个人资料页**：练 `Scaffold`、`Padding`、`Row`、`Column`、`CircleAvatar`、`Expanded`。
2. **商品列表页**：练 `ListView.builder`、`Card`、`ListTile`、加载/空/错误状态。
3. **登录或编辑页**：练 `Form`、`TextFormField`、校验、按钮和键盘。

每完成一次真实布局，常用 Widget 就会自然进入长期记忆。

---

## 5. 新手高频布局问题

### 问题 1：出现黄黑条和 `RenderFlex overflowed`

原因通常是 `Row` 或 `Column` 的内容超过可用空间。

常见处理：

- 一段长文字：用 `Expanded` 包裹，并设置 `maxLines`、`overflow`。
- 垂直内容确实需要滚动：把 `Column` 改为 `ListView`。
- 内容可以换行：把 `Row` 改为 `Wrap`。
- 只是尺寸设计不合理：调整固定宽高和间距，不要盲目加滚动。

### 问题 2：`ListView` 放进 `Column` 后高度报错

给列表一个有界高度，最常见的是：

```dart
Column(
  children: [
    const Header(),
    Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Text(items[index]);
        },
      ),
    ),
  ],
);
```

### 问题 3：`Expanded` 使用后报 ParentData 错误

`Expanded`、`Flexible`、`Spacer` 只能用于 `Row`、`Column` 或 `Flex` 的子树中，并且到对应 `Flex` 祖先的路径上不能夹着不兼容的布局 Widget。

正确：

```dart
Row(
  children: [
    Expanded(child: content),
  ],
);
```

### 问题 4：`Container` 同时设置 `color` 和 `decoration`

不能同时传这两个参数。需要背景色和圆角时，把颜色放进 `BoxDecoration`：

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.circular(12),
  ),
);
```

### 问题 5：状态改了但页面没变化

检查：

- 可变数据是否存放在 `State` 或所用的状态管理对象中；
- 修改局部状态时是否调用了 `setState`；
- 是否直接修改了对象内部值，却没有通知界面；
- 异步回调结束时 Widget 是否还挂载；必要时先判断 `mounted`。

### 问题 6：页面越来越卡

优先检查：

- 长列表是否使用了 `ListView.builder` / `GridView.builder`；
- 是否在 `build` 中发网络请求、读文件或执行大量计算；
- 能写成 `const` 的 Widget 是否漏写了 `const`；
- 是否存在不必要的嵌套滚动和大量 `shrinkWrap: true`；
- 是否让过大的 Widget 子树因一个很小的状态变化而整体重建。

---

## 6. 一个可以直接运行的综合示例

下面这个页面覆盖了页面骨架、间距、输入、弹性布局、懒加载列表、卡片、按钮和局部状态。

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _items = ['学习 Text', '练习 Row 和 Column'];

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _items.add(text);
    });
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget 练习清单'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: '新任务',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _addItem(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton.filled(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add),
                    tooltip: '添加',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _items.isEmpty
                    ? const Center(
                        child: Text('暂无任务'),
                      )
                    : ListView.separated(
                        itemCount: _items.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        },
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: const Icon(
                                Icons.check_circle_outline,
                              ),
                              title: Text(_items[index]),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _items.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.delete_outline),
                                tooltip: '删除',
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

阅读这段代码时，不要逐行背诵。试着从外向内说出每个 Widget 的职责：

```text
应用 → 页面 → 安全区域 → 页面留白 → 垂直布局
→ 输入行 → 列表占据剩余空间 → 每一项显示为卡片
```

---

## 7. 推荐的官方查询入口

- [Flutter Widget catalog](https://docs.flutter.dev/ui/widgets)
- [Flutter 布局入门](https://docs.flutter.dev/ui/layout)
- [理解 Flutter 约束](https://docs.flutter.dev/ui/layout/constraints)
- [滚动组件目录](https://docs.flutter.dev/ui/widgets/scrolling)
- [输入组件目录](https://docs.flutter.dev/ui/widgets/input)
- [Material 组件目录](https://docs.flutter.dev/ui/widgets/material)
- [Flutter API 文档](https://api.flutter.dev/)

最后记住一句话：

> 不必记住所有 Widget；先准确描述当前的布局或交互问题，再从对应类别中选择 Widget。
