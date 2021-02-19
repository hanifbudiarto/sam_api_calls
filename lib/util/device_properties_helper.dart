import 'package:sam_api_calls/models/dashboard/dashboard.dart';
import 'package:sam_api_calls/models/device/device.dart';

class DevicePropertiesHelper {
  static bool isVendorDeviceValid(
      IotWidgetElement selectedIotWidgetElement, Property property) {
    if (selectedIotWidgetElement.acceptedParameters
        .contains("${property.parentId}/${property.id}")) {
      return true;
    }

    return false;
  }

  static bool isDatatypeAcceptable(
      IotWidgetElement selectedIotWidgetElement, Property property) {
    // cek apakah di selectedIotWidgetsElement, accepted datatype nya sesuai dengan datatype property device
    return selectedIotWidgetElement.acceptedParameters.any((datatype) =>
        datatype != null &&
        property != null &&
        property.datatype != null &&
        datatype.toLowerCase() == property.datatype.toLowerCase());
  }

  static bool isSettableSuitable(
      IotWidgetElement selectedIotWidgetElement, Property property) {
    // if widget settable is false, it can also received resource with settable true
    // if widget settable is true, it can't receive resource with settable false, only true
    return selectedIotWidgetElement.settable == false ||
        selectedIotWidgetElement.settable == property.settable;
  }

  static bool isRetainedSuitable(
      IotWidgetElement selectedIotWidgetElement, Property property) {
    return selectedIotWidgetElement.retained == property.retained;
  }

  static List<ValidDevice> getValidDevices(IotWidget selectedParentWidget,
      IotWidgetElement selectedIotWidgetElement, List<DeviceIot> devices) {
    List<ValidDevice> validDevices = [];

    devices.forEach((device) {
      validDevices.add(ValidDevice(
          id: device.id,
          device: device,
          valid: containValidProperty(
              selectedParentWidget, selectedIotWidgetElement, device)));
    });

    validDevices.sort((a, b) {
      // minus make a before b
      // plus make a after b
      // 0 if a == b

      if (a.valid && !b.valid) return 0;
      if (!a.valid && b.valid) return 1;

      return a.device.name.toLowerCase().compareTo(b.device.name.toLowerCase());
    });

    return validDevices;
  }

  static bool isDatatypeSettableRetainedSuitable(
      IotWidgetElement element, Property prop) {
    if (element.acceptedParameters.any((element) => element.contains("/")))
      return true;

    return isDatatypeAcceptable(element, prop) &&
        isSettableSuitable(element, prop) &&
        isRetainedSuitable(element, prop);
  }

  static bool containValidProperty(IotWidget selectedParentWidget,
      IotWidgetElement selectedIotWidgetElement, DeviceIot device) {
    bool valid = false;

    if (device != null && device.nodes != null && device.nodes.length > 0) {
      device.nodes.forEach((node) {
        if (node.isConfig == true) return;

        int nodeCount = 1;
        if (node.array != null) {
          // multiple nodes
          List<String> splittedArr = node.array.split("-");
          int maxIndex = int.parse(splittedArr[1]);
          int minIndex = int.parse(splittedArr[0]);

          nodeCount = maxIndex - minIndex + 1;
        }

        for (int i = 0; i < nodeCount; i++) {
          if (node.properties == null) continue;

          node.properties.forEach((prop) {
            if (isDatatypeSettableRetainedSuitable(
                    selectedIotWidgetElement, prop) &&
                isVendorSuitable(selectedParentWidget, device.model)) {
              valid = true;
            }
          });
        }
      });
    }

    return valid;
  }

  static bool isVendorSuitable(IotWidget parent, String model) {
    return parent.compatibleModels.any((compatibleModel) {
      RegExp regex = RegExp(compatibleModel);
      return regex.hasMatch(model);
    });
  }

  static List<Property> getAllProps(DeviceIot device) {
    List<Property> list = [];
    if (device != null && device.nodes != null && device.nodes.length > 0) {
      device.nodes.forEach((node) {
        if (node.isConfig == true) return;

        int nodeCount = 1;
        if (node.array != null) {
          // multiple nodes
          List<String> splittedArr = node.array.split("-");
          int maxIndex = int.parse(splittedArr[1]);
          int minIndex = int.parse(splittedArr[0]);

          nodeCount = maxIndex - minIndex + 1;
        }

        for (int i = 0; i < nodeCount; i++) {
          if (node.properties == null) continue;

          node.properties.forEach((prop) {
            Property property = Property.copyFrom(prop);
            if (nodeCount != 1) {
              property.parentId = "${prop.parentId}_${i.toString()}";
            }
            list.add(property);
          });
        }
      });
    }
    return list;
  }

  static List<Property> getValidProps(
      IotWidgetElement selectedIotWidgetElement, ValidDevice validDevice) {
    List<Property> list = [];
    if (validDevice != null &&
        validDevice.device != null &&
        validDevice.device.nodes != null &&
        validDevice.device.nodes.length > 0) {
      validDevice.device.nodes.forEach((node) {
        if (node.isConfig == true) return;

        int nodeCount = 1;
        if (node.array != null) {
          // multiple nodes
          List<String> splittedArr = node.array.split("-");
          int maxIndex = int.parse(splittedArr[1]);
          int minIndex = int.parse(splittedArr[0]);

          nodeCount = maxIndex - minIndex + 1;
        }

        for (int i = 0; i < nodeCount; i++) {
          if (node.properties == null) continue;

          node.properties.forEach((prop) {
            if (isDatatypeAcceptable(selectedIotWidgetElement, prop) &&
                isSettableSuitable(selectedIotWidgetElement, prop) &&
                isRetainedSuitable(selectedIotWidgetElement, prop)) {
              Property property = Property.copyFrom(prop);
              if (nodeCount != 1) {
                property.parentId = "${prop.parentId}_${i.toString()}";
              }
              list.add(property);
            } else if (isVendorDeviceValid(selectedIotWidgetElement, prop)) {
              list.add(prop);
            }
          });
        }
      });
    }

    return list;
  }

  // weird naming because of the API
  static String getPropertyNameWithIndex(Property prop) {
    if (prop.parentId != null && prop.parentId.contains("_")) {
      List<String> splittedParentId = prop.parentId.split("_");
      return "${prop.name} (${splittedParentId[1]})";
    }

    return prop.name;
  }

  static String getNodeIdFromParameter(String parameter) {
    List<String> splitted = parameter.split("/");

    // node id with underscore
    String nodeId = splitted[0];
    if (nodeId.contains("_")) {
      List<String> splittedNodeId = nodeId.split("_");
      String newNodeId = "";
      bool first = true;
      for (int i = 0; i < splittedNodeId.length - 1; i++) {
        if (first)
          first = false;
        else
          newNodeId += "_";

        newNodeId += splittedNodeId[i];
      }

      nodeId = newNodeId;
    }
    return nodeId;
  }

  // get resource name from device parameter
  // get humid from sensor/humid
  static String getResourceNameFromDeviceParameter(String parameter) {
    List<String> splitted = parameter.split("/");

    return splitted[splitted.length - 1];
  }

  static Property getPropertyByDeviceParameter(
      String parameter, DeviceIot device) {
    String nodeId = getNodeIdFromParameter(parameter);
    device.nodes.forEach((node) {});

    return device.nodes
        .singleWhere((node) => node.id == nodeId)
        .properties
        .singleWhere(
            (prop) => prop.id == getResourceNameFromDeviceParameter(parameter));
  }

  static bool deviceIsVendor(DeviceIot device) {
    List<String> modelVendorCollection = [
      "ELITECH-WSDPRO",
      "wscales-elitech",
      "ELITECH-BT5050",
      "CMS50D-BT"
    ];
    return modelVendorCollection
        .any((element) => element.toLowerCase() == device.model.toLowerCase());
  }
}
