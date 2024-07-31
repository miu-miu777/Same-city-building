import 'package:flutter/material.dart';

void main() {
  runApp(const Playmate());
}

class Playmate extends StatelessWidget {
  const Playmate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playmate Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // 启动页面
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 延迟2秒后跳转到主页面
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MyPlaymatePage(title: 'Playmate'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const WelcomePage();
  }
}

class MyPlaymatePage extends StatefulWidget {
  const MyPlaymatePage({super.key, required this.title});
  final String title;

  @override
  State<MyPlaymatePage> createState() => _MyPlaymatePageState();
}

class _MyPlaymatePageState extends State<MyPlaymatePage> with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0; // 需要初始化
  late TabController _tabController; // 需要定义

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 初始化 TabController
  }

  @override
  void dispose() {
    _tabController.dispose(); // 释放 TabController 资源
    super.dispose();
  }

  List<Widget> _buildWidgetOptions() {
    return [
      // 第一个页面
      ListView.builder(
        physics: PageScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: index % 2 == 0 ? Colors.red : Colors.green,
            alignment: Alignment.center,
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
      // 第二个页面
      ListView.builder(
        physics: PageScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: index % 2 == 0 ? Colors.yellow : Colors.lightBlue,
            alignment: Alignment.center,
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
      // 第三个页面
      ListView.builder(
        physics: PageScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: index % 2 == 0 ? Colors.teal : Colors.teal,
            alignment: Alignment.center,
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
      if (index != 0) {
        _tabController.index = 0; // 切换到默认的Tab页
      }
    });
  }

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
            Tab(text: '搭子'),
            Tab(text: '附近'),
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
              // 这是第一个页面，显示PageView和PageIndicator
              _buildWidgetOptions()[0],
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
        onTap: (index) {
          _onItemTapped(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '通知',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '我的',
          ),
        ],
      ),
    );
  }
}