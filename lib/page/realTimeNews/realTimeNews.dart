import 'dart:ui';

import 'package:disease/api/api.dart';
import 'package:disease/components/Browser.dart';
import 'package:disease/model/EpidemicDetail.dart';
import 'package:disease/model/News.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:lpinyin/lpinyin.dart';
import 'package:nav_router/nav_router.dart';

class RealTimeNews extends StatefulWidget {
  RealTimeNews({Key key}) : super(key: key);

  @override
  _RealTimeNewsState createState() => _RealTimeNewsState();
}

class _RealTimeNewsState extends State<RealTimeNews>
    with TickerProviderStateMixin {
  List<Widget> tableListWidget = new List(); //数据表格table组件
  Future _getDatas; //多个请求结婚
  int flag = 100000; //表格是否隐藏
  List<Widget> newsListWidget = new List(); //新闻列表组件
  AnimationController _controller;
  AnimationController _controllerNews;
  Animation<double> _animation;
  Animation<double> _animationNews;
  bool TableisExpand = false;
  bool newsIsExpand = false;
  ScrollController scrollController = ScrollController();
  Color backgroundColor = Color(0xffe0c3fc);
  Color lightWhite=Color(0x88ffffff);

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.1, end: 1.0).animate(_controller);
    _controllerNews = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    _animationNews = Tween(begin: 0.01, end: 1.0).animate(_controllerNews);
    _getDatas = getDatas();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getDatas,
        builder: (context, snap) {
          if (snap.hasData) {
            ///构建table
            _tableWidget(snap);

            ///构建新闻列表
            _newsWidget(snap, context);

            return Scaffold(
                appBar: AppBar(
                  title: Text("实时疫情", style: TextStyle(color: Colors.black)),
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
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, bottom: 15),
                        child: Text(
                          "数据来自官方通报 全国与各省通报数据可能存在差异:",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: lightWhite,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "省市",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "确诊",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "治愈",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "死亡",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 2),
                                ),
                              ],
                            ),
                            SizeTransition(
                              sizeFactor: _animation,
                              child: Column(
                                children: tableListWidget,
                              ),
                            ),
                            FlatButton(
                              child: Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                if (TableisExpand) {
                                  _controller.reset();
                                  TableisExpand = false;
                                  scrollController.jumpTo(
                                      scrollController.position.minScrollExtent);
                                } else {
                                  _controller.forward();
                                  TableisExpand = true;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Card(
                          color: lightWhite,
                          elevation: 0,
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: newsListWidget,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ));
          } else {
            return Center(
              child: Text(""),
            );
          }
        });
  }

  void _tableWidget(AsyncSnapshot snap) {
    final epidemicDetail =
        epidemicDetailFromJson(convert.jsonEncode(snap.data[1]));
    List<Newslist> newslist = epidemicDetail.newslist;
    tableListWidget.clear();
    for (var i = 0; i < newslist.length; i++) {
      List<Widget> cityListWidget = new List();
      for (var item in newslist[i].cities) {
        Widget cityWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 2),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    InkWell(
                        child: Row(
                          children: <Widget>[
                            Text(
                              item.cityName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
//                                color: Colors.white70,
                              ),
                            ),
                            Padding(
                              child: Icon(Icons.keyboard_arrow_right,
                                  size: 16.0, color: Colors.white70),
                              padding: EdgeInsets.only(top: 3),
                            )
                          ],
                        ),
                        onTap: () {
                          String text = "";
                          if (newslist[i].provinceShortName == "陕西") {
                            text = PinyinHelper.getPinyin(
                                    newslist[i].provinceShortName,
                                    separator: "",
                                    format: PinyinFormat.WITHOUT_TONE) +
                                "s";
                          } else {
                            text = PinyinHelper.getPinyinE(
                                newslist[i].provinceShortName,
                                separator: "",
                                format: PinyinFormat.WITHOUT_TONE);
                            if (text == "xicang") {
                              text = "xizang";
                            }
                          }
                          routePush(
                              Browser(
                                url:
                                    "https://news.sina.cn/project/fy2020/yq_province.shtml?province=" +
                                        text,
                                title: newslist[i].provinceShortName,
                              ),
                              RouterType.scale);
                        })
                  ],
                ),
              ),
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(
                      item.confirmedCount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0),
                    )
                  ],
                ),
              ),
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(
                      item.curedCount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0),
                    )
                  ],
                ),
              ),
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(
                      item.deadCount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0),
                    )
                  ],
                ),
              ),
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2),
            ),
          ],
        );
        cityListWidget.add(cityWidget);
      }
      Widget tableWidget = Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 2),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.black12,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_drop_down,
                              size: 16,
                            ),
                            Text(
                              newslist[i].provinceShortName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if (flag == i) {
                      flag = 100000;
                      setState(() {
                        flag = flag;
                      });
                    } else {
                      setState(() {
                        flag = i;
                      });
                    }
                  },
                ),
                flex: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        newslist[i].confirmedCount.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.0),
                      )
                    ],
                  ),
                ),
                flex: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        newslist[i].curedCount.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.0),
                      )
                    ],
                  ),
                ),
                flex: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[50],
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        newslist[i].deadCount.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.0),
                      )
                    ],
                  ),
                ),
                flex: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 2),
          ),
          Visibility(
              visible: i == flag,
              child: Column(
                children: cityListWidget,
              ))
        ],
      );
      tableListWidget.add(tableWidget);
    }
  }

  void _newsWidget(AsyncSnapshot snap, BuildContext context) {
    ///构建新闻列表
    final news = newsFromJson(convert.jsonEncode(snap.data[0]));
    newsListWidget.clear();

    for (int i = 0; i < 50; i++) {
      Widget newsWidget = InkWell(
        child: Card(
          borderOnForeground: false,
          elevation: 0.0,
          color: Color(0x88ffffff),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text(
                  news[i].title == null ? "" : news[i].title,
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              ),
              Padding(
                child: Text(
                  news[i].summary == null ? "" : news[i].summary,
                  style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    child: Text(
                      DateTime.fromMillisecondsSinceEpoch(news[i].pubDate)
                          .toString()
                          .substring(0, 19),
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.only(right: 10, bottom: 6),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      news[i].provinceName == null ? "" : news[i].provinceName,
                      style: TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    child: Text(
                      news[i].infoSource == null ? "" : news[i].infoSource,
                      style: TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        onTap: () {
          ///更具数据返回的链接，跳转到web页面
          routePush(
              Browser(
                url: news[i].sourceUrl,
                title: "新闻详情",
              ),
              RouterType.scale);
        },
      );
      newsListWidget.add(newsWidget);
    }
  }

  ///构建多个请求集合
  Future getDatas() async {
    return Future.wait([getNewNews(), getPneumonia()]);
  }

  ///获取最新的消息
  Future getNewNews() async {
    return await Api.newNews({});
  }

  ///获取最新的疫情统计数据
  Future getPneumonia() async {
    return await Api.pneumonia({});
  }
}
