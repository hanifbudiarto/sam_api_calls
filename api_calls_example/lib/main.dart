import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:sam_api_calls/contracts/contracts.dart';
import 'package:sam_api_calls/impl/impl.dart';
import 'package:sam_api_calls/logger/logger.dart';
import 'package:sam_api_calls/models/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });

    final String rootCA = '''''';

    final Dio userDio =
        Dio(BaseOptions(baseUrl: "https://staging.iot.samelement.com/sapipublic"));
    userDio.httpClientAdapter =
        IOHttpClientAdapter(onHttpClientCreate: (client) {
      // Don't trust any certificate just because their root cert is trusted.
      final HttpClient client =
          HttpClient(context: SecurityContext(withTrustedRoots: false));
      // You can test the intermediate / root cert here. We just ignore it.
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    });

    final logger = ConsoleLogger(logLevel: 'debug');

    final dataService = DataServiceImpl(
        dio: userDio,
        logger: logger,
        broker: BrokerProperties(
            protocol: "ssl", port: 8883, address: "mqtt.iot.samelement.com"));

    final localService = LocalServiceImpl();

    final Dio authDio = Dio(BaseOptions(baseUrl: "https://staging.iot.samelement.com/sauth"));
    authDio.httpClientAdapter =
        IOHttpClientAdapter(onHttpClientCreate: (client) {
      // Don't trust any certificate just because their root cert is trusted.
      final HttpClient client =
          HttpClient(context: SecurityContext(withTrustedRoots: false));
      // You can test the intermediate / root cert here. We just ignore it.
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    });
    final authService = AuthServiceImpl(
        storage: localService, interceptors: [], dio: authDio, logger: logger);

    final authInterceptor = AuthInterceptor(
        logger: logger,
        authService: authService,
        onRefreshedToken: () async {});
    userDio.interceptors.addAll([authInterceptor]);

    final Dio appDio = Dio(BaseOptions(
        baseUrl: "https://staging.iot.samelement.com/sapipublic"));
    appDio.httpClientAdapter =
        IOHttpClientAdapter(onHttpClientCreate: (client) {
      // Don't trust any certificate just because their root cert is trusted.
      final HttpClient client =
          HttpClient(context: SecurityContext(withTrustedRoots: false));
      // You can test the intermediate / root cert here. We just ignore it.
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    });
    final appInterceptor =
        AppInterceptor(authService: authService, logger: logger);
    appDio.interceptors.addAll([appInterceptor]);

    final appService = AppServiceImpl(dio: appDio, logger: logger);
    final publicService = PublicServiceImpl();

    final BasicAuth appAuth = BasicAuth(username: "BfB0EdwbWGJxhPEDW6FmvcahSWOb1qLK", password: "PTnklLP94Kxm7JscdpvXNKoTL9sXA397CFNzcXIgbvsSSWGgZcKtgzwHBp49Yj7CtsQKdCTgJgWvEGNvndljBC7b7wWobsjkPgqSBn3g5o2VmhpOtsGKU7gsAfZ2JdaQ");
    final appToken =
        await authService.generateAppToken(appAuth.username, appAuth.password);

    final deviceToken = await authService.generateDeviceToken("9W6VRx0ZCDdx8FylmqxobOSg1PbDxhSN", "uVopAVYjQyFYKN3ZjuKUxITUaAR7XKj3jbGv1HbnwqHYZp5XZTRmuF3CzmZCtKvlK3g3PFj4JmXYzgucCiXm1XKOyIvSLJl00oUZdWJz6kmvgA5ZS7O1cMgixDCPk79m");

    // final userToken =
    //     await authService.generateUserToken("hanif@samelement.com", "ABCD1234efgh", appToken.accessToken);

    await authService
        .saveTokens(
            appToken: appToken,
            deviceToken: deviceToken)
        .catchError((e) {
      print(e.toString());
    });

    await appService.getWhiteLabel().then((whitelabel) {
      print(whitelabel.enable);
    });

    await appService.getUserAccountByEmail("hanif@samelemento.com").then((userAccount) {
      print("user account ${userAccount.userFname}");
    });

    await appService.postNewUser(
        UserProfile(
            userId: "",
            userEmail: "hanif@samelement.com",
            userFname: "Hanif",
            userLname: "Budi"),
        "ABCD1234efgh");



    // await dataService.getUserAccount().then((userAccount) {
    //   print(userAccount.userFname);
    // }).catchError((e) {
    //   print(e.toString());
    // });
    //
    // await dataService.getDevices(limit: 300).then((devices) {
    //   print(devices.list.length);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class LocalServiceImpl implements LocalService {
  @override
  Future<bool> clear({required String key}) {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<bool> clearAll() {
    // TODO: implement clearAll
    throw UnimplementedError();
  }

  @override
  Future<LocalStorage> getStorage({String? path}) {
    // TODO: implement getStorage
    throw UnimplementedError();
  }

  @override
  Future<bool> isContainsKey({required String key}) {
    // TODO: implement isContainsKey
    throw UnimplementedError();
  }

  @override
  Future<bool> isStorageInitialized() {
    // TODO: implement isStorageInitialized
    throw UnimplementedError();
  }

  @override
  Future<String?> read({required String key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> write({required String key, required String value}) {
    // TODO: implement write
    throw UnimplementedError();
  }
}
