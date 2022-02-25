import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:start_app/db/data_db_page.dart';
import 'package:start_app/utils/gg_log_util.dart';

void main() {
  GgLogUtil.init();
  runApp(new MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: DataDbPage(),
    //home: CustomScrollViewRoute(),
  ));
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  int lines;
  bool lintLine = false;

  TestFlowDelegate({this.margin, this.lines});

  @override
  void paintChildren(FlowPaintingContext context) {
//    GgLogUtil.v('消息$lines', tag: 'xwb');

    var x = margin.left;
    var y = margin.top;
    if (lines > 0) {
      lintLine = true;
    }
    print('消息$lines / $lintLine');
    int curLine = 1;
    for (var i = 0; i < context.childCount; i++) {
      var w = x + context.getChildSize(i).width + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        curLine++;
        print('消yy息$lines / $curLine');
        if (lintLine && curLine > lines) {
          break;
        }
        print('消zz息$lines / $curLine');
        x = margin.left;
        y = y + context.getChildSize(i).height + margin.bottom;
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = x + context.getChildSize(i).width + margin.right + margin.left;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }

  //  是否需要重新布局。
  @override
  bool shouldRelayout(FlowDelegate oldDelegate) {
    return super.shouldRelayout(oldDelegate);
  }

  //设置Flow的尺寸
  @override
  Size getSize(BoxConstraints constraints) {
    return super.getSize(constraints);
  }

  //  设置每个child的布局约束条件
  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return super.getConstraintsForChild(i, constraints);
  }
}

class RandomWordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
//      home: RandomWords(),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: buildFlow(),
        ),
      ),
    );
  }

  Flow buildFlow() {
    return Flow(
      delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0), lines: 1),
      children: <Widget>[
        Container(
          width: 30.0,
          height: 40.0,
          color: Color(0xffff0000),
        ),
        Container(
          width: 50.0,
          height: 40.0,
          color: Color(0xff00ff00),
        ),
        Container(
          width: 70.0,
          height: 40.0,
          color: Color(0xff0000ff),
        ),
        Container(
          width: 50.0,
          height: 40.0,
          color: Color(0xffffff00),
        ),
        Container(
          width: 50.0,
          height: 40.0,
          color: Color(0xff00ff00),
        ),
        Container(
          width: 70.0,
          height: 40.0,
          color: Color(0xff0000ff),
        ),
        Container(
          width: 50.0,
          height: 40.0,
          color: Color(0xffffff00),
        ),
        Container(
          width: 50.0,
          height: 40.0,
          color: Color(0xffff0000),
        ),
        Container(
          width: 80.0,
          height: 40.0,
          color: Color(0xffff00ff),
        ),
        Container(
          width: 50.0,
          height: 40.0,
          color: Color(0xffff0000),
        ),
        Container(
          width: 50.0,
          height: 40.0,
          color: Color(0xff0000ff),
        ),
        Container(
          width: 30.0,
          height: 40.0,
          color: Color(0xffff0000),
        ),
        Container(
          width: 50.0,
          height: 40.0,
          color: Color(0xff00ff00),
        ),
        Container(
          width: 70.0,
          height: 40.0,
          color: Color(0xff0000ff),
        ),
      ],
    );
  }
}

class ScrollTest extends StatefulWidget {
  @override
  _ScrollTestState createState() => _ScrollTestState();
}

class _ScrollTestState extends State<ScrollTest> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = ['Tab 1', 'Tab 2'];
    return DefaultTabController(
      length: _tabs.length, // This is the number of tabs.
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title:
                      const Text('Books'), // This is the title in the app bar.
                  pinned: true,
                  expandedHeight: 150.0,
                  // The "forceElevated" property causes the SliverAppBar to show
                  // a shadow. The "innerBoxIsScrolled" parameter is true when the
                  // inner scroll view is scrolled beyond its "zero" point, i.e.
                  // when it appears to be scrolled below the SliverAppBar.
                  // Without this, there are cases where the shadow would appear
                  // or not appear inappropriately, because the SliverAppBar is
                  // not actually aware of the precise position of the inner
                  // scroll views.
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    // These are the widgets to put in each tab in the tab bar.
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: _tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  // This Builder is needed to provide a BuildContext that is
                  // "inside" the NestedScrollView, so that
                  // sliverOverlapAbsorberHandleFor() can find the
                  // NestedScrollView.
                  builder: (BuildContext context) {
                    return SmartRefresher(
                      physics: ClampingScrollPhysics(),
                      controller: refreshController,
                      //允许上拉加载
                      enablePullUp: true,
                      // //允许下拉
                      enablePullDown: true,
                      //控制器
                      onRefresh: () {
                        //刷新回调方法
                        refreshController.refreshCompleted();
                      },
                      onLoading: () {
                        refreshController.loadComplete();
                      },
                      child: CustomScrollView(
                        // The "controller" and "primary" members should be left
                        // unset, so that the NestedScrollView can control this
                        // inner scroll view.
                        // If the "controller" property is set, then this scroll
                        // view will not be associated with the NestedScrollView.
                        // The PageStorageKey should be unique to this ScrollView;
                        // it allows the list to remember its scroll position when
                        // the tab view is not on the screen.
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            // This is the flip side of the SliverOverlapAbsorber
                            // above.
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            // In this example, the inner scroll view has
                            // fixed-height list items, hence the use of
                            // SliverFixedExtentList. However, one could use any
                            // sliver widget here, e.g. SliverList or SliverGrid.
                            sliver: SliverFixedExtentList(
                              // The items in this example are fixed to 48 pixels
                              // high. This matches the Material Design spec for
                              // ListTile widgets.
                              itemExtent: 48.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  // This builder is called for each child.
                                  // In this example, we just number each list item.
                                  return ListTile(
                                    title: Text('Item $index'),
                                  );
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
