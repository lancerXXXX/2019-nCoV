import 'dart:ui';

import 'package:disease/model/Epidemi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:disease/api/api.dart';
import 'dart:convert' as convert;

import 'package:flutter_swiper/flutter_swiper.dart';

class EpidemicMap extends StatefulWidget {
  EpidemicMap({Key key}) : super(key: key);

  @override
  _EpidemicMapState createState() => _EpidemicMapState();
}

/// 用于管理状态
class ExpandState {
  bool isOpen;
  var index;

  ExpandState(this.index, this.isOpen);
}

class _EpidemicMapState extends State<EpidemicMap> {
  Future _getEpidemic;
  bool _isExpanded = false;
  int panelIndex1 = -1;
  int name = 0;
  Epidemi epidemic;
  Container ContainerWidget;

  Widget swiperWidget;
  Widget swiperWidget1;
  Widget swiperWidget2;
  Widget swiperWidget3;

  List<Widget> swiperWidgets = List(4);

  Color backgroundColor = Color(0xffe0c3fc);

  @override
  void initState() {
    super.initState();
    _getEpidemic = getEpidemic();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getEpidemic,
        builder: (context, snap) {
          if (snap.hasData) {
            epidemic = epidemiFromJson(convert.jsonEncode(snap.data));
            _swiperWidget(
                0, epidemic, context, epidemic.data.desc.foreignTrendChart);
            _swiperWidget(1, epidemic, context,
                epidemic.data.desc.importantForeignTrendChart);
            _swiperWidget(
                2, epidemic, context, epidemic.data.desc.quanguoTrendChart);
            _swiperWidget(
                3, epidemic, context, epidemic.data.desc.hbFeiHbTrendChart);
            // _expansionPanelListWidget(epidemic);
            ContainerWidget = buildContainer(epidemic);
            return Scaffold(
              appBar: AppBar(
                title: Text("疫情地图", style: TextStyle(color: Colors.black)),
                centerTitle: true,
                backgroundColor: backgroundColor,
              ),
              body: ContainerWidget,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  epidemic = epidemiFromJson(
                      convert.jsonEncode(await Api.epidemi({})));
                  setState(() {
                    epidemic = epidemic;
                    _swiperWidget(0, epidemic, context,
                        epidemic.data.desc.foreignTrendChart);
                    _swiperWidget(1, epidemic, context,
                        epidemic.data.desc.importantForeignTrendChart);
                    _swiperWidget(2, epidemic, context,
                        epidemic.data.desc.quanguoTrendChart);
                    _swiperWidget(3, epidemic, context,
                        epidemic.data.desc.hbFeiHbTrendChart);
                    ContainerWidget = buildContainer(epidemic);
                  });
                },
                backgroundColor: backgroundColor,
                tooltip: 'Increment',
                child: Icon(Icons.refresh),
              ),
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        });
  }

  Container buildContainer(Epidemi epidemic) {
    return Container(
      // color: Color(background),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            Color(0xff8EC5FC),
            Color(0xffE0C3FC),
          ])),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true, //true 滑动到底部
          padding: EdgeInsets.all(0.0),
          physics: BouncingScrollPhysics(), //滑动到底部回弹效果
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5.0),
              ),
              _returnDate(),
              _returnNumberCard(),
              _returnMapCards(),
              _returnVirusInfoCard()
            ],
          )),
    );
  }

  Widget _returnDate() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0),
        ),
        Text(
          "截止",
          style: TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
        Text(
          DateTime.fromMillisecondsSinceEpoch(epidemic.data.desc.modifyTime)
              .toString()
              .substring(0, 19),
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        Text(
          "全国以及全球统计：",
          style: TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
      ],
    );
  }

  void _swiperWidget(int num, Epidemi epidemi, BuildContext context,
      List<ForeignTrendChart> charList) {
    swiperWidgets[num] = Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 50),
      child: ConstrainedBox(
        child: Swiper(
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              charList[index].imgUrl,
              fit: BoxFit.fill,
            );
          },
          itemCount: epidemic.data.desc.foreignTrendChart.length,
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  activeColor: Color.fromRGBO(255, 53, 39, 1),
                  size: 5.0,
                  color: Color.fromRGBO(203, 206, 213, 1),
                  activeSize: 5.0)),
        ),
        constraints: BoxConstraints.loose(
            Size(MediaQuery.of(context).size.width, 180.0)),
      ),
    );
  }

  Future getEpidemic() async {
    return await Api.epidemi({});
  }

  Widget _returnNumberItem(String num, Color color, String name, int comp1) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              num,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 18.0),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(name, style: TextStyle(color: Colors.grey, fontSize: 12.0))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            comp1 >= 0
                ? Icon(Icons.trending_up, color: Colors.red[900], size: 15.0)
                : Icon(Icons.trending_down,
                    color: Colors.green[900], size: 15.0),
            Text(
              comp1.toString(),
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 10.0),
            )
          ],
        ),
      ],
    );
  }

  Widget _returnMapCard(String title, Widget widget) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
            child: Text("$title:",
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: CupertinoContextMenu(
              child: widget,
              actions: <Widget>[
                CupertinoContextMenuAction(
                  child: Text(title,style: TextStyle(fontSize: 13.0),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _returnMapCards() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              _returnMapCard('疫情地图', Image.network(epidemic.data.desc.imgUrl)),
              _returnMapCard('全球与中国疫情趋势趋势', swiperWidgets[0]),
              _returnMapCard('全球重点疫区趋势图', swiperWidgets[1]),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              _returnMapCard('全国趋势图', swiperWidgets[2]),
              _returnMapCard('对比湖北趋势图', swiperWidgets[3]),
            ],
          ),
        )
      ],
    );
  }

  _returnNumberCard() {
    return Card(
      elevation: 0,
      color: Color(0xaaffffff),
      margin: EdgeInsets.all(10),
      child: Expanded(
          child: Column(
        children: <Widget>[
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: <Widget>[
              _returnNumberItem(epidemic.data.desc.confirmedCount.toString(),
                  Colors.orange, '确诊病例', epidemic.data.desc.confirmedIncr),
              _returnNumberItem(epidemic.data.desc.seriousCount.toString(),
                  Colors.red[800], '重症病例', epidemic.data.desc.seriousIncr),
              _returnNumberItem(epidemic.data.desc.deadCount.toString(),
                  Colors.redAccent, '死亡人数', epidemic.data.desc.deadIncr),
              _returnNumberItem(epidemic.data.desc.curedCount.toString(),
                  Colors.green, '治愈人数', epidemic.data.desc.curedIncr),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: <Widget>[
              _returnNumberItem(
                  epidemic.data.desc.foreignStatistics.confirmedCount
                      .toString(),
                  Colors.orange,
                  '确诊病例',
                  epidemic.data.desc.foreignStatistics.confirmedIncr),
              _returnNumberItem(
                  epidemic.data.desc.foreignStatistics.curedCount.toString(),
                  Colors.red[800],
                  '重症病例',
                  epidemic.data.desc.foreignStatistics.curedIncr),
              _returnNumberItem(
                  epidemic.data.desc.foreignStatistics.deadCount.toString(),
                  Colors.redAccent,
                  '死亡人数',
                  epidemic.data.desc.foreignStatistics.deadIncr),
              _returnNumberItem(
                  epidemic.data.desc.foreignStatistics.curedCount.toString(),
                  Colors.redAccent,
                  '治愈人数',
                  epidemic.data.desc.foreignStatistics.curedIncr),
            ],
          )
        ],
      )),
    );
  }

  _returnVirusInfoCard() {
    //查看病毒信息
    return FlatButton(
      color: Color(0xffE0C3FC),
        child: Container(
          child: Text('点击查看病毒信息'),
        ),
        onPressed: () {
          showBottomSheet(
            backgroundColor: Color(0x00000000),
            context: context,
            builder: (BuildContext context) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX:10.0,
                  sigmaY:10.0
                ),
                              child: Card(
                  elevation: 0,
                  color: Color(0x88ffffff),
                  margin: EdgeInsets.only(left: 20,right:20),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          Image.asset(
                            "assets/images/bat.png",
                            width: 16.0,
                            height: 16.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                          ),
                          Text("传染源：",
                              style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Text(
                            epidemic.data.desc.note2.substring(
                                  epidemic.data.desc.note2.indexOf("：") + 1,
                                  epidemic.data.desc.note2.length),
                          ))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          Image.asset("assets/images/viruses.png",
                              width: 16.0, height: 16.0),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                          ),
                          Text("病毒：",
                              style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Text(epidemic.data.desc.note1.substring(
                                    epidemic.data.desc.note1.indexOf("：") + 1,
                                    epidemic.data.desc.note1.length)))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          Image.asset("assets/images/route.png",
                              width: 16.0, height: 16.0),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                          ),
                          Text("传播途径：",
                              style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(epidemic.data.desc.note3.substring(
                                  epidemic.data.desc.note3.indexOf("：") + 1,
                                  epidemic.data.desc.note3.length)),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          Image.asset("assets/images/person.png",
                              width: 16.0, height: 16.0),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                          ),
                          Text("易感人群：",
                              style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Text(epidemic.data.desc.remark1.substring(
                                    epidemic.data.desc.remark1.indexOf("：") + 1,
                                    epidemic.data.desc.remark1.length)))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          Image.asset("assets/images/waiting.png",
                              width: 16.0, height: 16.0),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                          ),
                          Text("潜伏期：",
                              style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Text(epidemic.data.desc.remark2.substring(
                                    epidemic.data.desc.remark2.indexOf("：") + 1,
                                    epidemic.data.desc.remark2.length)))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          Image.asset("assets/images/host.png",
                              width: 16.0, height: 16.0),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                          ),
                          Text("宿主：",
                              style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Text(epidemic.data.desc.remark3.substring(
                                    epidemic.data.desc.remark3.indexOf("：") + 1,
                                    epidemic.data.desc.remark3.length)))
                        ],
                      )
                    ],
                  ),
                                ),
                ),
              );
            },
          );
        });
  }
}
