import 'package:flutter/material.dart';

// 程序的入口函数
void main() {
  runApp(MyApp()); // 启动应用，运行 MyApp 组件
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoPage(), // 设置应用的首页为 VideoPage 组件
    );
  }
}

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 视频播放区域
          Container(
            color: Colors.black, // 背景颜色，实际使用中可以替换为视频播放组件
            child: Center(
              child: Text(
                '视频播放区域', // 这是一个占位符文本，表示视频播放区域
                style: TextStyle(color: Colors.white), // 文本颜色为白色
              ),
            ),
          ),
          // 右侧控件区域
          Positioned(
            right: 16, // 距离右边界16像素
            top: MediaQuery.of(context).size.height * 0.3, // 距离顶部30%的高度位置
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30, // 头像的半径为30像素
                  backgroundImage: AssetImage('assets/avatar.png'), // 设置头像的图片资源
                ),
                SizedBox(height: 16), // 头像和点赞按钮之间的间距为16像素
                IconButton(
                  icon: Icon(Icons.thumb_up, color: Colors.white), // 点赞图标，颜色为白色
                  onPressed: () {
                    // 点赞按钮点击事件
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment, color: Colors.white), // 评论图标，颜色为白色
                  onPressed: () {
                    // 评论按钮点击事件
                  },
                ),
              ],
            ),
          ),
          // 左下角用户名和文案区域
          Positioned(
            left: 16, // 距离左边界16像素
            bottom: 16, // 距离底部16像素
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 子元素从左对齐
              children: [
                Text(
                  '用户名', // 用户名文本
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // 白色，20像素，粗体
                ),
                SizedBox(height: 8), // 用户名和文案之间的间距为8像素
                Text(
                  '文案内容', // 文案文本
                  style: TextStyle(color: Colors.white, fontSize: 16), // 白色，16像素
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}