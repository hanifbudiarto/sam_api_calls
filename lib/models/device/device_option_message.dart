part of sam_models_devices;

class DeviceOptionMessage {
  // rlidsa
  late String rMessage;
  late String lMessage;
  late String iMessage;
  late String dMessage;
  late String aMessage;
  late String sMessage;

  DeviceOptionMessage(
      {this.rMessage: '',
        this.lMessage: '',
        this.iMessage: '',
        this.dMessage: '',
        this.aMessage: '',
        this.sMessage: ''});

  DeviceOptionMessage.fromJson(Map<String, dynamic> json) {
    this.rMessage = json['r_msg'];
    this.lMessage = json['l_msg'];
    this.iMessage = json['i_msg'];
    this.dMessage = json['d_msg'];
    this.aMessage = json['a_msg'];
    this.sMessage = json.containsKey('s_msg') ? json['s_msg'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['r_msg'] = this.rMessage;
    data['l_msg'] = this.lMessage;
    data['i_msg'] = this.iMessage;
    data['d_msg'] = this.dMessage;
    data['a_msg'] = this.aMessage;
    data['s_msg'] = this.sMessage;
    return data;
  }

  void addMessage({required String message, required String prefix}) {
    switch (prefix) {
      case 'r':
        rMessage = message;
        break;
      case 'l':
        lMessage = message;
        break;
      case 'i':
        iMessage = message;
        break;
      case 'd':
        dMessage = message;
        break;
      case 'a':
        aMessage = message;
        break;
      case 's':
        sMessage = message;
        break;
    }
  }
}