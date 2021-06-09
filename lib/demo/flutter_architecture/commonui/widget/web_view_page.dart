import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'file:///E:/FlutterProject/start_app/lib/demo/flutter_architecture/commonui/common_util.dart';

import '../common_style.dart';

typedef OnWillPop = void Function(BuildContext context);

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  final OnWillPop onWillPop;

  const WebViewPage({Key key, this.title, this.url, this.onWillPop: null})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewState();
  }
}

class _WebViewState extends State<WebViewPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: widget.onWillPop != null
            ? null
            : AppBar(
                centerTitle: true,
                title: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: YZStyle.normalTextWhite,
                ),
                actions: <Widget>[
                  PopupMenuButton(
                    padding: const EdgeInsets.all(0.0),
                    onSelected: _onPopSelected,
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuItem<String>>[
                      _getPopupMenuItem('browser', Icons.language, '浏览器打开'),
                      _getPopupMenuItem('share', Icons.share, '分享'),
                    ],
                  ),
                ],
              ),
        body: Stack(
          children: <Widget>[
            _buildWebView(),
            CommonUtil.getLoading(context, _isLoading),
          ],
        ),
      ),
      onWillPop: () {
        if (widget.onWillPop != null) {
          widget.onWillPop(context);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
    );
  }

  Widget _buildWebView() {
    return WebView(
      onWebViewCreated: (WebViewController webViewController) {},
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (url) {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  PopupMenuItem _getPopupMenuItem(String value, IconData icon, String title) {
    return PopupMenuItem<String>(
      value: value,
      child: ListTile(
        contentPadding: EdgeInsets.all(0.0),
        dense: false,
        title: Container(
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Color(YZColors.textColor),
                size: 22.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                title,
                style: YZStyle.middleText,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onPopSelected(String value) {
    switch (value) {
      case "browser":
        _launchInBrowser(widget.url, title: widget.title);
        break;
      case 'share':
        //ShareUtil.share(widget.url);
        break;
    }
  }

  Future<Null> _launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
