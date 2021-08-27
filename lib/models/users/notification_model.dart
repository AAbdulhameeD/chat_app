/// to : "c0j5B9m7Qk6m8PP1kaMNcN:APA91bHvM16yTLvbXNLm1kNhocc5vs30FVLuw44cma6LKUicyqPUaPYAwpHDxhdzFOx7vNJ5r79OQ4aLWp6FVkjydi2Ce8wzRkS86mg-V_E_YKPj5yVAgi1TqODIwugcFhUtM_-lvF7J"
/// notification : {"title":"a message from ahmed abdulhamed","body":"testing body from postman","sound":"default"}
/// android : {"priority":"HIGH","notification":{"notification_priority":"PRIORITY_MAX","sound":"default","default_sound":true,"default_vibrate_timings":true,"default_light_settings":true},"data":{"type":"order","id":"87","click_action":"FLUTTER_NOTIFICATION_CLICK"}}

class NotificationModel {
  String? to;
  AndroidNotification? androidNotification;
  Android? android;

  NotificationModel({this.to});

  NotificationModel.fromJson(dynamic json) {
    to = json["to"];
    androidNotification = json["notification"] != null
        ? AndroidNotification.fromJson(json["notification"])
        : null;
    android =
    json["android"] != null ? Android.fromJson(json["android"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["to"] = to;
    if (androidNotification != null) {
      map["notification"] = androidNotification!.toJson();
    }
    if (android != null) {
      map["android"] = android!.toJson();
    }
    return map;
  }
}

/// priority : "HIGH"
/// notification : {"notification_priority":"PRIORITY_MAX","sound":"default","default_sound":true,"default_vibrate_timings":true,"default_light_settings":true}
/// data : {"type":"order","id":"87","click_action":"FLUTTER_NOTIFICATION_CLICK"}

class Android {
  String? priority;
  NotificationSettings? notification;
  Data? data;

  Android({this.priority});

  Android.fromJson(dynamic json) {
    priority = json["priority"];
    notification = json["notification"] != null
        ? NotificationSettings.fromJson(json["notification"])
        : null;
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["priority"] = priority;
    if (notification != null) {
      map["notification"] = notification!.toJson();
    }
    if (data != null) {
      map["data"] = data!.toJson();
    }
    return map;
  }
}

/// type : "order"
/// id : "87"
/// click_action : "FLUTTER_NOTIFICATION_CLICK"

class Data {
  String type = "order";
  String id = "87";
  String clickAction = "FLUTTER_NOTIFICATION_CLICK";

  Data({String? type, String? id, String? clickAction}) {
    type = type;
    id = id;
    clickAction = clickAction;
  }

  Data.fromJson(dynamic json) {
    type = json["type"];
    id = json["id"];
    clickAction = json["click_action"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["id"] = id;
    map["click_action"] = clickAction;
    return map;
  }
}

/// notification_priority : "PRIORITY_MAX"
/// sound : "default"
/// default_sound : true
/// default_vibrate_timings : true
/// default_light_settings : true

class NotificationSettings {
  String? notificationPriority = "PRIORITY_MAX";
  String? sound = "default";
  bool? defaultSound = true;
  bool? defaultVibrateTimings = true;
  bool? defaultLightSettings = true;

  NotificationSettings(
      { this.notificationPriority,
        this.sound,
        this.defaultSound,
        this.defaultVibrateTimings,
        this.defaultLightSettings});

  NotificationSettings.fromJson(dynamic json) {
    notificationPriority = json["notification_priority"];
    sound = json["sound"];
    defaultSound = json["default_sound"];
    defaultVibrateTimings = json["default_vibrate_timings"];
    defaultLightSettings = json["default_light_settings"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["notification_priority"] = notificationPriority;
    map["sound"] = sound;
    map["default_sound"] = defaultSound;
    map["default_vibrate_timings"] = defaultVibrateTimings;
    map["default_light_settings"] = defaultLightSettings;
    return map;
  }
}

/// title : "a message from ahmed abdulhamed"
/// body : "testing body from postman"
/// sound : "default"

class AndroidNotification {
  String? title = "a message from ahmed abdulhamed";
  String? body = "testing body from postman";
  String? sound = "default";

  AndroidNotification({
    this.title,
    this.body,
    this.sound,
  });

  AndroidNotification.fromJson(dynamic json) {
    title = json["title"];
    body = json["body"];
    sound = json["sound"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["body"] = body;
    map["sound"] = sound;
    return map;
  }
}
