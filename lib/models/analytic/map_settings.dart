class MapSettings {
  String markerIcon;
  String feedbackIcon;
  bool showFeedback;
  String locationSource;

  MapSettings(
      {this.markerIcon = "default_marker.png",
        this.feedbackIcon = "default_feedback.gif",
        this.showFeedback = false,
        this.locationSource = "static"});

  factory MapSettings.fromJson(Map<String, dynamic> json) {
    return MapSettings(
        markerIcon: json["marker_icon"],
        feedbackIcon: json["feedback_icon"],
        showFeedback: json["show_feedback"],
        locationSource: json["location_source"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["marker_icon"] = this.markerIcon;
    data["feedback_icon"] = this.feedbackIcon;
    data["show_feedback"] = this.showFeedback;
    data["location_source"] = this.locationSource;
    return data;
  }
}