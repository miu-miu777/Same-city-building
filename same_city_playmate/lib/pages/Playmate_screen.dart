// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   // 用于存储颜色块数据的列表
//   List<Color> _colors = List.generate(10, (index) => _getColor(index));
//   ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     // 监听滚动事件
//     _scrollController.addListener(_onScroll);
//   }
//
//   @override
//   void dispose() {
//     // 释放滚动控制器
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   // 滚动监听方法
//   void _onScroll() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//       // 当滚动到底部时，加载更多颜色块
//       setState(() {
//         _colors.addAll(List.generate(2, (index) => _getColor(_colors.length + index)));
//       });
//     }
//   }
//
//   // 生成颜色块
//   static Color _getColor(int index) {
//     return Color((index * 0xFFFFFF / 20).toInt() | 0xFF000000);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dynamic Color Blocks ListView'),
//       ),
//       body: ListView.builder(
//         controller: _scrollController,
//         itemCount: _colors.length,
//         itemBuilder: (context, index) {
//           return Container(
//             height: MediaQuery.of(context).size.height, // 设置为屏幕的高度
//             color: _colors[index],
//           );
//         },
//       ),
//     );
//   }
// }