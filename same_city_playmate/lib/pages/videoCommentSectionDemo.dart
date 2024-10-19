//显示评论对话框
//void _showCommentDialog() {
//  showDialog(
//    context: context,
//    builder: (BuildContext context) {
//      return AlertDialog(
//        title: Text('发表评论'),
//        content: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: [
//            Row(
//              children: [
//                CircleAvatar(
//                  radius: 20,
//                  backgroundImage: AssetImage('assets/headPicture.png'), // 用户头像
//                ),
//                SizedBox(width: 10),
//                Expanded(
//                  child: Text(
//                    '用户名', // 显示用户名
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                ),
//              ],
//            ),
//            SizedBox(height: 10),
//            TextField(
//              // controller: _commentController,
//              maxLines: null, // 允许多行
//              decoration: InputDecoration(
//                hintText: '请输入评论...',
//                border: OutlineInputBorder(),
//              ),
//            ),
//          ],
//        ),
//        actions: [
//          TextButton(
//            onPressed: () {
//              Navigator.of(context).pop(); // 关闭对话框
//            },
//            child: Text('取消'),
//          ),
//          TextButton(
//            onPressed: () {
//              String comment = _commentController.text;
//              // 处理评论发送逻辑
//              _showSnackBar('评论内容: $comment');
//              _commentController.clear(); // 清空输入框
//              Navigator.of(context).pop(); // 关闭对话框
//            },
//            child: Text('发送'),
//          ),
//        ],
//      );
//    },
//  );
//}
//
//UI