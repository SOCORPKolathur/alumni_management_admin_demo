class EventsModel {
  String? id;
  String? title;
  String? date;
  List<String>? views;
  List<String>? registeredUsers;
  num? timestamp;
  num? timestampmain;
  String? description;
  String? imgUrl;
  String? location;
  String? time;

  EventsModel(
      {this.id, this.title,this.date, this.views,this.registeredUsers, this.description, this.imgUrl, this.timestamp,this.timestampmain, this.location, this.time});

  EventsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
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
    timestampmain = json['timestampmain'];
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
    if (this.views != null) {
      data['views'] = this.views!.map((v) => v).toList();
    }
    if (this.registeredUsers != null) {
      data['registeredUsers'] = this.registeredUsers!.map((v) => v).toList();
    }
    data['timestamp'] = this.timestamp;
    data['timestampmain'] = this.timestampmain;
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
    }
    return '';
  }
}
