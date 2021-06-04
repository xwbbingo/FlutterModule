import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:start_app/router/route_util.dart';

/// WebView 加载网页页面
class WebViewScreen extends StatefulWidget {
  /// 标题
  String title;

  /// 链接
  String url;

  WebViewScreen({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoad = true;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

//  void _onPopSelected(String value) {
//    String _title = widget.title;
//    switch (value) {
//      case "browser":
//        RouteUtil.launchInBrowser(widget.url, title: _title);
//        break;
//      case "share":
//        String _url = widget.url;
//        Share.share('$_title : $_url');
//        break;
//      default:
//        break;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        elevation: 0.4,
        title: Text(widget.title),
        bottom: PreferredSize(
          child: SizedBox(
            height: 2,
            child: isLoad ? LinearProgressIndicator() : Container(),
          ),
          preferredSize: Size.fromHeight(2),
        ),
        actions: <Widget>[
          IconButton(
            // tooltip: '用浏览器打开',
            icon: Icon(Icons.language, size: 20.0),
            onPressed: () {
              RouteUtil.launchInBrowser(widget.url, title: widget.title);
            },
          ),
          IconButton(
            // tooltip: '分享',
            icon: Icon(Icons.share, size: 20.0),
            onPressed: () {
              //Share.share('${widget.title} : ${widget.url}');
            },
          ),
//          new PopupMenuButton(
//            padding: const EdgeInsets.all(0.0),
//            onSelected: _onPopSelected,
//            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
//              new PopupMenuItem<String>(
//                  value: "browser",
//                  child: ListTile(
//                      contentPadding: EdgeInsets.all(0.0),
//                      dense: false,
//                      title: new Container(
//                        alignment: Alignment.center,
//                        child: new Row(
//                          children: <Widget>[
//                            Icon(
//                              Icons.language,
//                              color: Colours.gray_66,
//                              size: 22.0,
//                            ),
//                            Gaps.hGap10,
//                            Text('浏览器打开')
//                          ],
//                        ),
//                      ))),
//              new PopupMenuItem<String>(
//                  value: "share",
//                  child: ListTile(
//                      contentPadding: EdgeInsets.all(0.0),
//                      dense: false,
//                      title: new Container(
//                        alignment: Alignment.center,
//                        child: new Row(
//                          children: <Widget>[
//                            Icon(
//                              Icons.share,
//                              color: Colours.gray_66,
//                              size: 22.0,
//                            ),
//                            Gaps.hGap10,
//                            Text('分享')
//                          ],
//                        ),
//                      ))),
//            ],
//          )
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
      hidden: true,
    );
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
