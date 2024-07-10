part of sam_models;

class BrokerProperties {
  final String address;
  final String protocol;
  final int port;

  BrokerProperties(
      {required this.address, required this.protocol, required this.port});
}
