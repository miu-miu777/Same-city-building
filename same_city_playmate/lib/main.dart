import 'package:flutter/material.dart';

void main() {
  runApp(MyApp_kqy());
}

class MyApp_kqy extends StatelessWidget {
  const MyApp_kqy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playmate Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen_kqy(), // 启动页面
    );
  }
}

class WelcomePage_kqy extends StatelessWidget {
  const WelcomePage_kqy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '欢迎',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SplashScreen_kqy extends StatefulWidget {
  const SplashScreen_kqy({super.key});

  @override
  State<SplashScreen_kqy> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen_kqy> {
  @override
  void initState() {
    super.initState();
    // 延迟2秒后跳转到主页面
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MyHomePage_kqy(title: 'MyHome'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const WelcomePage_kqy();
  }
}

class MyHomePage_kqy extends StatefulWidget {
  const MyHomePage_kqy({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage_kqy> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage_kqy> with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0; // 需要初始化
  late TabController _tabController; // 需要定义

  @override
  void initState() {
    super.initState();
    // 初始化 TabController length规定顶部切换的页数
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // 释放 TabController 资源
    super.dispose();
  }


//底部导航栏链接的页面
  List<Widget> _buildWidgetOptions() {
    return [
      // 首页
      FindVideo_kqy(),

      //搭子
      ListView.builder(
        physics: PageScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: index % 2 == 0 ? Colors.red : Colors.lightBlue,
            alignment: Alignment.center,
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
      //+
      ListView.builder(
        physics: PageScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: index % 2 == 0 ? Colors.yellow : Colors.white54,
            alignment: Alignment.center,
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
      // 消息页
      ListView.builder(
        physics: PageScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: index % 2 == 0 ? Colors.purpleAccent : Colors.lightBlue,
            alignment: Alignment.center,
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
      // 我的页面
      ProfilePage_kqy(),
    ];
  }

  void _onItemTapped_kqy(int index) {
    setState(() {
      _bottomNavIndex = index;
      if (index != 0) {
        _tabController.index = 0; // 切换到默认的Tab页
      }
    });
  }
  // _kqy
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 去掉标题
        toolbarHeight: kToolbarHeight, // 设置顶部导航栏的高度
        bottom: _bottomNavIndex == 0
            ? TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '发现'),
            Tab(text: '直播'),
            Tab(text: '附近视频'),
            Tab(text: '附近直播'),
          ],
        )
            : null,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _bottomNavIndex == 0
            ? [
          TabBarView(
            controller: _tabController,
            children: [
              // 这是第一个页面即首页，显示PageView和PageIndicator
              _buildWidgetOptions()[0],

              //直播页
              SizedBox.expand(
                child: Container(
                  color: Colors.white,
                  child: Center(child: Text('欢迎')),
                ),
              ),

              //附近视频页 --用发现页先代替 因为还没确定定位的事情
              FindVideo_kqy(),

              //附近直播页
              SizedBox.expand(
                child: Container(
                  color: Colors.white,
                  child: Center(child: Text('欢迎')),
                ),
              ),

            ],
          ),
        ]
            : _buildWidgetOptions(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        unselectedItemColor: Colors.grey, // 未选中项的颜色
        selectedItemColor: Colors.yellow, // 选中项的颜色
        onTap: (index) {
          _onItemTapped_kqy(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: '搭子',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            label: '发布视频',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '通知',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}

//发现页存储——kqy
class VideoNode {
  final String videoUrl;
  VideoNode? prev;
  VideoNode? next;

  VideoNode(this.videoUrl);
}

class VideoList {
  VideoNode? head;
  VideoNode? tail;
  int length = 0;

  void add(String videoUrl) {
    final newNode = VideoNode(videoUrl);
    if (head == null) {
      head = newNode;
      tail = newNode;
    } else {
      tail!.next = newNode;
      newNode.prev = tail;
      tail = newNode;
    }
    length++;
  }

  void extend(List<String> newVideos) {
    for (var video in newVideos) {
      add(video);
    }
  }

  VideoNode? getNodeAt(int index) {
    if (index < 0 || index >= length) return null;
    VideoNode? current = head;
    for (int i = 0; i < index; i++) {
      current = current?.next;
    }
    return current;
  }
}

class VideoController {
  VideoList videoList = VideoList();
  VideoNode? currentNode;

  VideoController() {
    // 初始化视频列表
    List<String> initialVideos = List.generate(10, (index) => '视频 $index');
    for (var video in initialVideos) {
      videoList.add(video);
    }
    currentNode = videoList.head;
  }

  String getCurrentVideoUrl() {
    return currentNode?.videoUrl ?? '';
  }

  void loadMoreVideos() {
    List<String> newVideos = List.generate(10, (index) => '视频 ${videoList.length + index}');
    videoList.extend(newVideos);
  }

  void moveToNext() {
    if (currentNode?.next != null) {
      currentNode = currentNode?.next;
    } else {
      // 如果到达尾部，加载更多视频
      loadMoreVideos();
      currentNode = videoList.getNodeAt(videoList.length - 10); // 回到新的第十个视频
    }
  }
}

//发现页——kqy
class FindVideo_kqy extends StatefulWidget {
  @override
  _FindVideoState_kqy createState() => _FindVideoState_kqy();
}

class _FindVideoState_kqy extends State<FindVideo_kqy> {
  PageController _pageController = PageController();
  VideoController _videoController = VideoController();
  int _videoCount = 10;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    if (_pageController.page!.toInt() == _videoCount - 1) {
      // 如果滚动到倒数第一个视频，加载更多
      setState(() {
        _videoController.loadMoreVideos();
        _videoCount = _videoController.videoList.length;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _videoCount,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                color: Colors.black,
                child: Center(
                  child: Text(
                    '视频播放区域 ${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                    SizedBox(height: 16),
                    IconButton(
                      icon: Icon(Icons.thumb_up, color: Colors.white),
                      onPressed: () {
                        // 点赞按钮点击事件
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.comment, color: Colors.white),
                      onPressed: () {
                        // 评论按钮点击事件
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '用户名 ${index + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '文案内容 ${index + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }
}


//个人信息页——kqy
class ProfilePage_kqy extends StatefulWidget {
  @override
  _ProfilePageState_kqy createState() => _ProfilePageState_kqy();
}

class _ProfilePageState_kqy extends State<ProfilePage_kqy> {
  bool _isFavorites = true; // 初始显示喜欢
  //  kqy
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // 点击编辑按钮后的处理逻辑
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // 使用 center 对齐整个列的内容
          children: [
            // 头像
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.png'), // 替换为实际的头像图片路径
            ),
            SizedBox(height: 16),
            // 用户名
            Text(
              '张三', // 替换为实际的用户名
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // 账号
            Text(
              'z123456om', // 替换为实际的账号
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            // 个人简介
            Text(
              '个人简介：这里是个人简介的描述，可以根据需要进行调整。',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            // 喜欢和收藏切换
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isFavorites = true;
                    });
                  },
                  child: Text('喜欢'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isFavorites = false;
                    });
                  },
                  child: Text('收藏'),
                ),
              ],
            ),
            SizedBox(height: 16),
            // 显示喜欢或收藏
            AnimatedCrossFade(
              firstChild: _buildFavoritesSection(),
              secondChild: _buildCollectionsSection(),
              crossFadeState: _isFavorites ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesSection() {
    return Text(
      '这里是喜欢的内容。',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildCollectionsSection() {
    return Text(
      '这里是收藏的内容。',
      style: TextStyle(fontSize: 16),
    );
  }
}
