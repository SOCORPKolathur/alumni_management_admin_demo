class JobPostModel {
  String? id;
  String? title;
  String? date;
  List<String>? views;
  List<String>? registeredUsers;
  num? timestamp;
  String? description;
  String? imgUrl;
  String? location;
  String? quvalification;
  String? positions;
  bool? verify;
  String? time;
  String? userName;
  String? UserOccupation;
  String? Batch;

  JobPostModel(
      {this.id, this.title,this.date, this.views,this.registeredUsers, this.description, this.imgUrl, this.timestamp, this.location,
        this.time,this.positions,this.quvalification,this.verify,this.userName,this.UserOccupation,this.Batch});

  JobPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    time = json['uploadTime'];
    userName = json['userName'];
    UserOccupation = json['UserOccupation'];
    Batch = json['Batch'];
    time = json['uploadTime'];
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
    positions = json['positions'];
    quvalification = json['quvalification'];
    verify = json['verify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['Batch'] = this.Batch;
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
    data['quvalification'] = this.quvalification;
    data['positions'] = this.positions;
    data['verify'] = this.verify;
    data['userName'] = this.userName;
    data['UserOccupation'] = this.UserOccupation;
    return data;
  }

  String getIndex(int index,int row) {
    switch (index) {
      case 0:
        return (row + 1).toString();
      case 1:
        return title!;
      case 2:
        return userName!;
      case 3:
        return date!;
      case 4:
        return time!;
      case 5:
        return location!.toString();
      case 6:
        return description!;
    }
    return '';
  }
}
