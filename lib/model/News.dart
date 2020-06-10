import 'dart:convert';

List<News> newsFromJson(String str) => List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
    int adoptType;
    int createTime;
    DataInfoOperator dataInfoOperator;
    int dataInfoState;
    int dataInfoTime;
    int entryWay;
    int id;
    String infoSource;
    int infoType;
    int modifyTime;
    String provinceId;
    String provinceName;
    int pubDate;
    String pubDateStr;
    String sourceUrl;
    String summary;
    String title;
    String ti1Tle;

    News({
        this.adoptType,
        this.createTime,
        this.dataInfoOperator,
        this.dataInfoState,
        this.dataInfoTime,
        this.entryWay,
        this.id,
        this.infoSource,
        this.infoType,
        this.modifyTime,
        this.provinceId,
        this.provinceName,
        this.pubDate,
        this.pubDateStr,
        this.sourceUrl,
        this.summary,
        this.title,
        this.ti1Tle,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        adoptType: json["adoptType"],
        createTime: json["createTime"],
        dataInfoOperator: dataInfoOperatorValues.map[json["dataInfoOperator"]],
        dataInfoState: json["dataInfoState"],
        dataInfoTime: json["dataInfoTime"],
        entryWay: json["entryWay"],
        id: json["id"],
        infoSource: json["infoSource"],
        infoType: json["infoType"],
        modifyTime: json["modifyTime"],
        provinceId: json["provinceId"],
        provinceName: json["provinceName"] == null ? null : json["provinceName"],
        pubDate: json["pubDate"],
        pubDateStr: json["pubDateStr"],
        sourceUrl: json["sourceUrl"],
        summary: json["summary"],
        title: json["title"] == null ? null : json["title"],
        ti1Tle: json["ti1tle"] == null ? null : json["ti1tle"],
    );

    Map<String, dynamic> toJson() => {
        "adoptType": adoptType,
        "createTime": createTime,
        "dataInfoOperator": dataInfoOperatorValues.reverse[dataInfoOperator],
        "dataInfoState": dataInfoState,
        "dataInfoTime": dataInfoTime,
        "entryWay": entryWay,
        "id": id,
        "infoSource": infoSource,
        "infoType": infoType,
        "modifyTime": modifyTime,
        "provinceId": provinceId,
        "provinceName": provinceName == null ? null : provinceName,
        "pubDate": pubDate,
        "pubDateStr": pubDateStr,
        "sourceUrl": sourceUrl,
        "summary": summary,
        "title": title == null ? null : title,
        "ti1tle": ti1Tle == null ? null : ti1Tle,
    };
}

enum DataInfoOperator { EMPTY, YUTING, ZHUOTINGTING, CAOYANG }

final dataInfoOperatorValues = EnumValues({
    "caoyang": DataInfoOperator.CAOYANG,
    "": DataInfoOperator.EMPTY,
    "yuting": DataInfoOperator.YUTING,
    "zhuotingting": DataInfoOperator.ZHUOTINGTING
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
