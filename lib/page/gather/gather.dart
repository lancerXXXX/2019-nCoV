import 'package:disease/components/Browser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

class gather extends StatefulWidget {
  gather({Key key}) : super(key: key);

  @override
  _gatherState createState() => _gatherState();
}

class _gatherState extends State<gather> {
  Color backgroundColor = Color(0xffe0c3fc);
  Color lightWhite=Color(0x88ffffff);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "我的",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: backgroundColor,
        ),
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            Color(0xff8EC5FC),
            Color(0xffE0C3FC),
          ])),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Card(
                            color: lightWhite,
                              elevation: 0,
                              margin: EdgeInsets.only(
                                  left: 10, right: 5, top: 10, bottom: 20),
                              child: Container(
                                  height: 100,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('城市相关'),
                                  ))),
                          onTap: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Text('城市相关'),
                                    content: Column(
                                      children: <Widget>[
                                        Text('该城市相关应用下载'),
                                        Image.asset('assets/images/erweima.png')
                                      ],
                                    ),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text('确定'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        )),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Card(
                            color: lightWhite,
                              elevation: 0,
                              margin: EdgeInsets.only(
                                  left: 5, right: 10, top: 10, bottom: 20),
                              child: Container(
                                  height: 100,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('可就诊医院'),
                                  ))),
                          onTap: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Text('可就诊医院'),
                                    content: Column(
                                      children: <Widget>[
                                        Text('医院A'),
                                        Text('医院B'),
                                        Text('医院C'),
                                        Text('医院D'),
                                        Text('医院E'),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text('确定'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        ))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Card(
                              elevation: 0,
                              color: lightWhite,
                              margin: EdgeInsets.only(
                                  left: 10, right: 5, top: 10, bottom: 20),
                              child: Container(
                                  height: 100,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('城市选择'),
                                  ))),
                          onTap: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Text('城市选择'),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text('确定'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        )),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Card(
                              elevation: 0,
                              color: lightWhite,
                              margin: EdgeInsets.only(
                                  left: 5, right: 10, top: 10, bottom: 20),
                              child: Container(
                                  height: 100,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('关于'),
                                  ))),
                          onTap: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Text('我的城市'),
                                    content: Column(
                                      children: <Widget>[
                                        Text('该城市相关应用下载'),
                                        Image.asset('assets/images/erweima.png')
                                      ],
                                    ),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text('确定'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                        ))
                  ],
                ),
              ),
              Expanded(
                  flex: 4,
                  child: ListView(shrinkWrap: true, children: <Widget>[
                    InkWell(
                      child: Card(
                          color: Colors.cyan[50],
                          child: Padding(
                            child: Text(
                              "丁香园",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          )),
                      onTap: () {
                        routePush(
                            Browser(
                              url: "https://3g.dxy.cn/newh5/view/pneumonia",
                              title: "丁香园",
                            ),
                            RouterType.scale);
                      },
                    ),
                    InkWell(
                      child: Card(
                          color: Colors.teal[50],
                          child: Padding(
                            child: Text(
                              "新浪",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          )),
                      onTap: () {
                        routePush(
                            Browser(
                              url: "https://news.sina.cn/zt_d/yiqing0121",
                              title: "新浪",
                            ),
                            RouterType.scale);
                      },
                    ),
                    InkWell(
                      child: Card(
                          color: Colors.amber[200],
                          child: Padding(
                            child: Text(
                              "梅斯",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          )),
                      onTap: () {
                        routePush(
                            Browser(
                              url: "http://m.medsci.cn/wh.asp",
                              title: "梅斯",
                            ),
                            RouterType.scale);
                      },
                    ),
                    InkWell(
                      child: Card(
                          color: Colors.teal[200],
                          child: Padding(
                            child: Text(
                              "知乎",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          )),
                      onTap: () {
                        routePush(
                            Browser(
                              url: "https://www.zhihu.com/special/19681091",
                              title: "知乎",
                            ),
                            RouterType.scale);
                      },
                    ),
                    InkWell(
                      child: Card(
                          color: Colors.purple[50],
                          child: Padding(
                            child: Text(
                              "第一财经",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          )),
                      onTap: () {
                        routePush(
                            Browser(
                              url: "https://m.yicai.com/news/100476965.html",
                              title: "第一财经",
                            ),
                            RouterType.scale);
                      },
                    ),
                    InkWell(
                      child: Card(
                          color: Colors.orange[50],
                          child: Padding(
                            child: Text(
                              "腾讯",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          )),
                      onTap: () {
                        routePush(
                            Browser(
                              url: "https://news.qq.com/zt2020/page/feiyan.htm",
                              title: "腾讯",
                            ),
                            RouterType.scale);
                      },
                    ),
                    InkWell(
                      child: Card(
                          color: Colors.lime[50],
                          child: Padding(
                            child: Text(
                              "夸克",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          )),
                      onTap: () {
                        routePush(
                            Browser(
                              url:
                                  "https://broccoli.uc.cn/apps/pneumonia/routes/index",
                              title: "夸克",
                            ),
                            RouterType.scale);
                      },
                    ),
                    InkWell(
                      child: Card(
                          color: Colors.indigo[50],
                          child: Padding(
                            child: Text(
                              "百度",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          )),
                      onTap: () {
                        routePush(
                            Browser(
                              url:
                                  "https://voice.baidu.com/act/newpneumonia/newpneumonia",
                              title: "百度",
                            ),
                            RouterType.scale);
                      },
                    ),
                    InkWell(
                      child: Card(
                          color: Colors.indigo[50],
                          child: Padding(
                            child: Text(
                              "阿里健康",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          )),
                      onTap: () {
                        routePush(
                            Browser(
                              url:
                                  "https://alihealth.taobao.com/medicalhealth/influenzamap?spm=a2oua.wuhaninfo.more.wenzhen&chInfo=spring2020-stay-in",
                              title: "阿里健康",
                            ),
                            RouterType.scale);
                      },
                    ),
                  ]))
            ],
          ),
        ));
  }
}
