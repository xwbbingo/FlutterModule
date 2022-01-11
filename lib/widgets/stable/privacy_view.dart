import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/commonui/widget/web_view_page.dart';

typedef OnTapCallback = void Function(String key);

///《用户协议》和《隐私政策》
class PrivacyView extends StatefulWidget {
  final String data;
  final List<String> keys;
  final TextStyle style;
  final TextStyle keyStyle;
  final OnTapCallback onTapCallback;

  const PrivacyView(
      {Key key,
      @required this.data,
      @required this.keys,
      this.style,
      this.keyStyle,
      this.onTapCallback})
      : super(key: key);

  @override
  _PrivacyViewState createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  List<String> _list = [];

  @override
  void initState() {
    super.initState();
    _split();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <InlineSpan>[
            ..._list.map((e) {
              if (widget.keys.contains(e)) {
                return TextSpan(
                    text: '$e',
                    style: widget.keyStyle ??
                        TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        widget.onTapCallback.call(e);
                      });
              } else {
                return TextSpan(text: '$e', style: widget.style);
              }
            }).toList(),
          ]),
    );
  }

  void _split() {
    int startIndex = 0;
    Map<String, dynamic> _index;
    while ((_index = _nextIndex(startIndex)) != null) {
      int i = _index['index'];
      String sub = widget.data.substring(startIndex, i);
      if (sub.isNotEmpty) {
        _list.add(sub);
      }
      _list.add(_index['key']);
      startIndex = i + (_index['key'] as String).length;
    }
  }

  Map<String, dynamic> _nextIndex(int startIndex) {
    int currentIndex = widget.data.length;
    String key;
    widget.keys.forEach((element) {
      int index = widget.data.indexOf(element, startIndex);
      if (index != -1 && index < currentIndex) {
        currentIndex = index;
        key = element;
      }
    });
    if (key == null) {
      return null;
    }
    return {'key': '$key', 'index': currentIndex};
  }
}

class PrivacyUtil {
  static String _data = "亲爱的xxxx用户，感谢您信任并使用xxxxAPP！\n" +
      " \n" +
      "xxxx十分重视用户权利及隐私政策并严格按照相关法律法规的要求，对《用户协议》和《隐私政策》进行了更新,特向您说明如下：\n" +
      "1.为向您提供更优质的服务，我们会收集、使用必要的信息，并会采取业界先进的安全措施保护您的信息安全；\n" +
      "2.基于您的明示授权，我们可能会获取设备号信息、包括：设备型号、操作系统版本、设备设置、设备标识符、MAC（媒体访问控制）地址、IMEI（移动设备国际身份码）、广告标识符（“IDFA”与“IDFV”）、集成电路卡识别码（“ICCD”）、软件安装列表。我们将使用三方产品（友盟、极光等）统计使用我们产品的设备数量并进行设备机型数据分析与设备适配性分析。（以保障您的账号与交易安全），且您有权拒绝或取消授权；\n" +
      "3.您可灵活设置伴伴账号的功能内容和互动权限，您可在《隐私政策》中了解到权限的详细应用说明；\n" +
      "4.未经您同意，我们不会从第三方获取、共享或向其提供您的信息；\n" +
      "5.您可以查询、更正、删除您的个人信息，我们也提供账户注销的渠道。\n" +
      " \n" +
      "请您仔细阅读并充分理解相关条款，其中重点条款已为您黑体加粗标识，方便您了解自己的权利。如您点击“同意”，即表示您已仔细阅读并同意本《用户协议》及《隐私政策》，将尽全力保障您的合法权益并继续为您提供优质的产品和服务。如您点击“不同意”，将可能导致您无法继续使用我们的产品和服务。";

  static void showPrivacyDialog(BuildContext mContext) {
    showGeneralDialog(
        context: mContext,
        //同意申请权限,不同意直接退出
        barrierDismissible: false,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Center(
            child: Material(
              child: Container(
                height: MediaQuery.of(context).size.height * .6,
                width: MediaQuery.of(context).size.width * .8,
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Text(
                        '用户隐私政策概要',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SingleChildScrollView(
                        child: PrivacyView(
                          data: _data,
                          keys: ['《用户协议》', '《隐私政策》'],
                          keyStyle: TextStyle(color: Colors.red),
                          onTapCallback: (String key) {
                            if (key == '《用户协议》') {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return WebViewPage(
                                    title: key, url: 'https://flutter.dev');
                              }));
                            } else if (key == '《隐私政策》') {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return WebViewPage(
                                    title: key, url: 'https://www.baidu.com');
                              }));
                            }
                          },
                        ),
                      ),
                    )),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            child: Container(
                                alignment: Alignment.center,
                                child: Text('不同意')),
                            onTap: () {},
                          )),
                          VerticalDivider(
                            width: 1,
                          ),
                          Expanded(
                              child: GestureDetector(
                            child: Container(
                                alignment: Alignment.center,
                                color: Theme.of(context).primaryColor,
                                child: Text('同意')),
                            onTap: () {},
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
