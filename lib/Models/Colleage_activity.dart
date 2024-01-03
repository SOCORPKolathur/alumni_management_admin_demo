class ColleageActivityModel {
  String? id;
  String? title;
  String? date;
  List<String>? views;
  List<String>? registeredUsers;
  num? timestamp;
  String? description;
  String? imgUrl;
  String? location;
  String? time;
  String? activityYear;
  String? activityDep;
  String? activityType;

  ColleageActivityModel(
      {this.id, this.title,this.date, this.views,this.registeredUsers, this.description, this.imgUrl, this.timestamp,
        this.activityDep,this.activityType,this.activityYear,
        this.location, this.time});

  ColleageActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    activityType = json['activityType'];
    activityDep = json['activityDep'];
    activityYear = json['activityYear'];
    if (json['views'] != null) {
      views = <String>[];
      json['views'].forEach((v) {
        views!.add(v);
      });
    }
    if (json['registeredUsers'] != null) {
      registeredUsers = <String>[];
      json['registeredUsers'].forEach((v) {
        registeredUsers!.add(v);
      });
    }
    timestamp = json['timestamp'];
    description = json['subtitle'];
    imgUrl = json['img'];
    location = json['location'];
    time = json['uploadTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['activityType'] = this.activityType;
    data['activityDep'] = this.activityDep;
    data['activityYear'] = this.activityYear;
    if (this.views != null) {
      data['views'] = this.views!.map((v) => v).toList();
    }
    if (this.registeredUsers != null) {
      data['registeredUsers'] = this.registeredUsers!.map((v) => v).toList();
    }
    data['timestamp'] = this.timestamp;
    data['subtitle'] = this.description;
    data['img'] = this.imgUrl;
    data['location'] = this.location;
    data['uploadTime'] = this.time;
    return data;
  }

  String getIndex(int index,int row) {
    switch (index) {
      case 0:
        return (row + 1).toString();
      case 1:
        return date!;
      case 2:
        return time!;
      case 3:
        return location!.toString();
      case 4:
        return description!;
      case 5:
        return activityType!;
      case 6:
        return activityDep!;
      case 7:
        return activityYear!;

    }
    return '';
  }
}
