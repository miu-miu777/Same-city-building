import 'package:flutter/material.dart';

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
//       home: ProfilePage(),
//     );
//   }
// }

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowing = false; // 关注状态

  final String backgroundImage = 'https://via.placeholder.com/800x400'; // 背景图URL
  final String avatarImage = 'https://via.placeholder.com/80'; // 头像图URL
  final String username = '用户名';
  final String userId = '用户ID';
  final int likesCount = 123;
  final int followersCount = 456;
  final int followingCount = 78;
  final String signature = '这是一段个性签名';
  final int worksCount = 5;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing; // 切换关注状态
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 背景图
            Image.network(
              backgroundImage,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            // 内容部分
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10), // 留出返回键的位置
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black), // 改为黑色
                        onPressed: () {
                          Navigator.pop(context); // 返回上一页
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8), // 为头像留出一些空间
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(avatarImage),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text(userId, style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 66),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('$likesCount', style: TextStyle(fontSize: 24, color: Colors.black)),
                          Text('获赞数', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('$followersCount', style: TextStyle(fontSize: 24, color: Colors.black)),
                          Text('粉丝', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('$followingCount', style: TextStyle(fontSize: 24, color: Colors.black)),
                          Text('关注', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(signature, style: TextStyle(color: Colors.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 居中对齐
                    children: [
                      SizedBox(
                        width: 160, // 增大按钮宽度
                        child: ElevatedButton(
                          onPressed: toggleFollow,
                          child: Text(isFollowing ? '已关注' : '关注'),
                        ),
                      ),
                      SizedBox(width: 40), // 减少间距
                      SizedBox(
                        width: 160, // 增大按钮宽度
                        child: ElevatedButton(
                          onPressed: () {
                            // 处理私信逻辑
                          },
                          child: Text('私信'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('作品', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true, // 使 GridView 可以嵌套在 Column 中
                    physics: NeverScrollableScrollPhysics(), // 防止 GridView 滚动
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemCount: worksCount,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Center(child: Text('作品 ${index + 1}')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
