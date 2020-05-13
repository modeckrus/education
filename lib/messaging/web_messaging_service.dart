import 'dart:convert';
import 'dart:js' as js;
void messageHandler(payload){
  print('Payload: ' + payload);
  var not = PayloadNotification.fromJson(jsonDecode(payload));
  print(not.notification.title);
}

void initWebMessagingHandler(){
  js.context['messagecallback'] = messageHandler;
  js.context.callMethod('messageInit');
}


class PayloadNotification {
  Data data;
  String from;
  String priority;
  Notification notification;
  String collapseKey;

  PayloadNotification(
      {this.data,
      this.from,
      this.priority,
      this.notification,
      this.collapseKey});

  PayloadNotification.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    from = json['from'];
    priority = json['priority'];
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
    collapseKey = json['collapse_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['from'] = this.from;
    data['priority'] = this.priority;
    if (this.notification != null) {
      data['notification'] = this.notification.toJson();
    }
    data['collapse_key'] = this.collapseKey;
    return data;
  }
}

class Data {
  String gcmNE;
  String googleCATs;
  String googleCAUdt;
  String gcmNotificationSound;
  String googleCACId;
  String gcmNotificationSound2;
  String clickAction;
  String gcmNotificationAndroidChannelId;
  String googleCAE;
  String id;
  String googleCACL;

  Data(
      {this.gcmNE,
      this.googleCATs,
      this.googleCAUdt,
      this.gcmNotificationSound,
      this.googleCACId,
      this.gcmNotificationSound2,
      this.clickAction,
      this.gcmNotificationAndroidChannelId,
      this.googleCAE,
      this.id,
      this.googleCACL});

  Data.fromJson(Map<String, dynamic> json) {
    gcmNE = json['gcm.n.e'];
    googleCATs = json['google.c.a.ts'];
    googleCAUdt = json['google.c.a.udt'];
    gcmNotificationSound = json['gcm.notification.sound'];
    googleCACId = json['google.c.a.c_id'];
    gcmNotificationSound2 = json['gcm.notification.sound2'];
    clickAction = json['click_action'];
    gcmNotificationAndroidChannelId =
        json['gcm.notification.android_channel_id'];
    googleCAE = json['google.c.a.e'];
    id = json['id'];
    googleCACL = json['google.c.a.c_l'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gcm.n.e'] = this.gcmNE;
    data['google.c.a.ts'] = this.googleCATs;
    data['google.c.a.udt'] = this.googleCAUdt;
    data['gcm.notification.sound'] = this.gcmNotificationSound;
    data['google.c.a.c_id'] = this.googleCACId;
    data['gcm.notification.sound2'] = this.gcmNotificationSound2;
    data['click_action'] = this.clickAction;
    data['gcm.notification.android_channel_id'] =
        this.gcmNotificationAndroidChannelId;
    data['google.c.a.e'] = this.googleCAE;
    data['id'] = this.id;
    data['google.c.a.c_l'] = this.googleCACL;
    return data;
  }
}

class Notification {
  String title;
  String body;
  String tag;
  String image;

  Notification({this.title, this.body, this.tag, this.image});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    tag = json['tag'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['tag'] = this.tag;
    data['image'] = this.image;
    return data;
  }
}