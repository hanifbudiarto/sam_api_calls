part of sam_utils;

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
        property.datatype != null &&
        datatype.toLowerCase() == property.datatype!.toLowerCase());
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

    if (device.nodes.length > 0) {
      device.nodes.forEach((node) {
        if (node.isConfig == true) return;

        int nodeCount = 1;
        if (node.array != null) {
          // multiple nodes
          List<String> splittedArr = node.array!.split("-");
          int maxIndex = int.parse(splittedArr[1]);
          int minIndex = int.parse(splittedArr[0]);

          nodeCount = maxIndex - minIndex + 1;
        }

        for (int i = 0; i < nodeCount; i++) {
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

  static bool isVendorSuitable(IotWidget parent, String? model) {
    return parent.compatibleModels.any((compatibleModel) {
      RegExp regex = RegExp(compatibleModel);
      return regex.hasMatch(model!);
    });
  }

  static List<Property> getAllProps(DeviceIot device) {
    List<Property> list = [];
    if (device.nodes.length > 0) {
      device.nodes.forEach((node) {
        if (node.isConfig == true) return;

        int nodeCount = 1;
		int minIndex = 0;
		int maxIndex = 0;
		
        if (node.array != null) {
          // multiple nodes
          List<String> splitArr = node.array!.split("-");
          maxIndex = int.parse(splitArr[1]);
          minIndex = int.parse(splitArr[0]);

          nodeCount = maxIndex - minIndex + 1;
        }		

        for (int i = minIndex; i < maxIndex + 1; i++) {
          node.properties.forEach((prop) {
            Property property = Property.copyFrom(prop);
            if (nodeCount != 1) {
              property.parentId = "${prop.parentId}_${i.toString()}";
              property.name = "${prop.name} ${i.toString()}";
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
    if (validDevice.device.nodes.length > 0) {
      validDevice.device.nodes.forEach((node) {
        if (node.isConfig == true) return;

        int nodeCount = 1;
		int minIndex = 0;
		int maxIndex = 0;
		
        if (node.array != null) {
          // multiple nodes
          List<String> splittedArr = node.array!.split("-");
          int maxIndex = int.parse(splittedArr[1]);
          int minIndex = int.parse(splittedArr[0]);

          nodeCount = maxIndex - minIndex + 1;
        }

        for (int i = minIndex; i < maxIndex + 1; i++) {
          node.properties.forEach((prop) {
            if (isDatatypeAcceptable(selectedIotWidgetElement, prop) &&
                isSettableSuitable(selectedIotWidgetElement, prop) &&
                isRetainedSuitable(selectedIotWidgetElement, prop)) {
              Property property = Property.copyFrom(prop);
              if (nodeCount != 1) {
                property.parentId = "${prop.parentId}_${i.toString()}";
                property.name = "${prop.name} ${i.toString()}";
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
  static String? getPropertyNameWithIndex(Property prop) {
    if (prop.parentId != null && prop.parentId!.contains("_")) {
      List<String> splitParentId = prop.parentId!.split("_");
      return "${prop.name} (${splitParentId[1]})";
    }

    return prop.name;
  }

  static String getNodeIdFromParameter(String parameter) {
    List<String> split = parameter.split("/");

    // node id with underscore
    String nodeId = split[0];
    if (nodeId.contains("_")) {
      List<String> splitNodeId = nodeId.split("_");
      String newNodeId = "";
      bool first = true;
      for (int i = 0; i < splitNodeId.length - 1; i++) {
        if (first)
          first = false;
        else
          newNodeId += "_";

        newNodeId += splitNodeId[i];
      }

      nodeId = newNodeId;
    }
    return nodeId;
  }

  // get resource name from device parameter
  // get humid from sensor/humid
  static String getResourceNameFromDeviceParameter(String parameter) {
    List<String> split = parameter.split("/");

    return split[split.length - 1];
  }

  static Property? getPropertyByDeviceParameter(
      String parameter, DeviceIot? device) {
    String nodeId = getNodeIdFromParameter(parameter);

    if (device != null) {
      Node? node = device.nodes.singleWhereOrNull((node) => node.id == nodeId);
      if (node != null) {
        return node.properties.singleWhereOrNull(
            (prop) => prop.id == getResourceNameFromDeviceParameter(parameter));
      }
    }
    return null;
  }
}
