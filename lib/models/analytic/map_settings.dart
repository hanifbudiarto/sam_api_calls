part of sam_models_analytics;

class MapSettings {
  late final String markerIcon;
  late final String feedbackIcon;
  late final bool showFeedback;
  late final String locationSource;

  MapSettings(
      {this.markerIcon = 'default_marker.png',
        this.feedbackIcon = 'default_feedback.gif',
        this.showFeedback = false,
        this.locationSource = 'static'});

  MapSettings.fromJson(Map<String, dynamic> json) {
    this.markerIcon = json['marker_icon'];
    this.feedbackIcon = json['feedback_icon'];
    this.showFeedback = json['show_feedback'];
    this.locationSource = json['location_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marker_icon'] = this.markerIcon;
    data['feedback_icon'] = this.feedbackIcon;
    data['show_feedback'] = this.showFeedback;
    data['location_source'] = this.locationSource;
    return data;
  }
}