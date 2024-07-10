part of sam_models_analytics;

class MapSettings {
  final String markerIcon;
  final String feedbackIcon;
  final bool showFeedback;
  final String locationSource;

  const MapSettings(
      {this.markerIcon = 'default_marker.png',
      this.feedbackIcon = 'default_feedback.gif',
      this.showFeedback = false,
      this.locationSource = 'static'});

  MapSettings.fromJson(Map<String, dynamic> json)
      : this.markerIcon = ifNullReturnEmpty(json['marker_icon']),
        this.feedbackIcon = ifNullReturnEmpty(json['feedback_icon']),
        this.showFeedback = json['show_feedback'] == true,
        this.locationSource = ifNullReturnEmpty(json['location_source']);

  Map<String, dynamic> toJson() => {
        'marker_icon': this.markerIcon,
        'feedback_icon': this.feedbackIcon,
        'show_feedback': this.showFeedback,
        'location_source': this.locationSource
      };
}
