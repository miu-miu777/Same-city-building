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
//       title: 'Profile Page',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: ProfilePage_kqy(),
//     );
//   }
// }
//
// class ProfilePage_kqy extends StatefulWidget {
//   @override
//   _ProfilePageState_kqy createState() => _ProfilePageState_kqy();
// }
//
// class _ProfilePageState_kqy extends State<ProfilePage_kqy> {
//   String _currentTab = '喜欢';
//
//   void _onTabChanged(String tab) {
//     setState(() {
//       _currentTab = tab;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // 背景图层（只显示在上半部分）
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             height: 250, // 根据需要设置背景高度
//             child: Image.asset(
//               'assets/bei.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//           // 内容层
//           SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // 头像
//                   Center(
//                     child: Stack(
//                       alignment: Alignment.bottomRight,
//                       children: [
//                         CircleAvatar(
//                           radius: 50,
//                           backgroundImage: AssetImage('assets/headPicture.png'), // 头像照片
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.grey, width: 2),
//                           ),
//                           child: IconButton(
//                             icon: Icon(Icons.camera_alt, color: Colors.black),
//                             onPressed: () {
//                               // 处理点击事件
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // 用户名
//                   Center(
//                     child: Text(
//                       '九与鸟  ID:123456',
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   // 简介
//                   Center(
//                     child: Text(
//                       '本人是一名爱鸟人士，经营一家宠物店',
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   // 关注数
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildStatColumn('关注', '100'),
//                       _buildStatColumn('粉丝', '200'),
//                       _buildStatColumn('作品', '300'),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // 按钮
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // 处理点击事件
//                           },
//                           child: Text('编辑个人资料'),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // 喜欢收藏导航栏
//                   Container(
//                     margin: EdgeInsets.only(bottom: 16),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildNavItem('喜欢'),
//                         _buildNavItem('收藏'),
//                       ],
//                     ),
//                   ),
//                   // 色块布局
//                   Container(
//                     height: 700, // 设置色块布局的高度，避免与其他内容重叠
//                     child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 8.0,
//                         mainAxisSpacing: 8.0,
//                       ),
//                       itemCount: 12, // 8行3列总共24个色块
//                       itemBuilder: (context, index) {
//                         return Container(
//                           color: _currentTab == '喜欢'
//                               ? Colors.primaries[index % Colors.primaries.length]
//                               : Colors.accents[index % Colors.accents.length],
//                           height: 100, // 设置色块的高度
//                           width: double.infinity, // 使色块宽度填充满列
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatColumn(String title, String value) {
//     return Expanded(
//       child: Column(
//         children: [
//           Text(
//             value,
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           Text(title, style: TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavItem(String title) {
//     return GestureDetector(
//       onTap: () => _onTabChanged(title),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: _currentTab == title ? Colors.black : Colors.grey,
//             ),
//           ),
//           if (_currentTab == title)
//             Container(
//               margin: EdgeInsets.only(top: 4),
//               width: 20,
//               height: 2,
//               color: Colors.black,
//             ),
//         ],
//       ),
//     );
//   }
// }
