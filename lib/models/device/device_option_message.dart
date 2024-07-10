part of sam_models_devices;

class DeviceOptionMessage {
  // rlidsa
  final String rMessage;
  final String lMessage;
  final String iMessage;
  final String dMessage;
  final String aMessage;
  final String sMessage;

  const DeviceOptionMessage(
      {this.rMessage = '',
      this.lMessage = '',
      this.iMessage = '',
      this.dMessage = '',
      this.aMessage = '',
      this.sMessage = ''});

  DeviceOptionMessage.fromJson(Map<String, dynamic> json)
      : this.rMessage = ifNullReturnEmpty(json['r_msg']),
        this.lMessage = ifNullReturnEmpty(json['l_msg']),
        this.iMessage = ifNullReturnEmpty(json['i_msg']),
        this.dMessage = ifNullReturnEmpty(json['d_msg']),
        this.aMessage = ifNullReturnEmpty(json['a_msg']),
        this.sMessage =
            json.containsKey('s_msg') ? ifNullReturnEmpty(json['s_msg']) : '';

  Map<String, dynamic> toJson() => {
        'r_msg': this.rMessage,
        'l_msg': this.lMessage,
        'i_msg': this.iMessage,
        'd_msg': this.dMessage,
        'a_msg': this.aMessage,
        's_msg': this.sMessage
      };

  DeviceOptionMessage replaceMessage(
      {required DeviceOptionMessage optionMessage,
      required String message,
      required String prefix}) {
    switch (prefix) {
      case 'r':
        return DeviceOptionMessage(
            rMessage: message,
            aMessage: optionMessage.aMessage,
            dMessage: optionMessage.dMessage,
            iMessage: optionMessage.iMessage,
            lMessage: optionMessage.lMessage,
            sMessage: optionMessage.sMessage);
      case 'l':
        return DeviceOptionMessage(
            rMessage: optionMessage.rMessage,
            aMessage: optionMessage.aMessage,
            dMessage: optionMessage.dMessage,
            iMessage: optionMessage.iMessage,
            lMessage: message,
            sMessage: optionMessage.sMessage);
      case 'i':
        return DeviceOptionMessage(
            rMessage: optionMessage.rMessage,
            aMessage: optionMessage.aMessage,
            dMessage: optionMessage.dMessage,
            iMessage: message,
            lMessage: optionMessage.lMessage,
            sMessage: optionMessage.sMessage);
      case 'd':
        return DeviceOptionMessage(
            rMessage: optionMessage.rMessage,
            aMessage: optionMessage.aMessage,
            dMessage: message,
            iMessage: optionMessage.iMessage,
            lMessage: optionMessage.lMessage,
            sMessage: optionMessage.sMessage);
      case 'a':
        return DeviceOptionMessage(
            rMessage: optionMessage.rMessage,
            aMessage: message,
            dMessage: optionMessage.dMessage,
            iMessage: optionMessage.iMessage,
            lMessage: optionMessage.lMessage,
            sMessage: optionMessage.sMessage);
      case 's':
        return DeviceOptionMessage(
            rMessage: optionMessage.rMessage,
            aMessage: optionMessage.aMessage,
            dMessage: optionMessage.dMessage,
            iMessage: optionMessage.iMessage,
            lMessage: optionMessage.lMessage,
            sMessage: message);
    }

    return optionMessage;
  }
}
