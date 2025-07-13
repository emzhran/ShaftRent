import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/repository/auth_repository.dart';
import 'package:shaftrent/data/repository/car_repository.dart';
import 'package:shaftrent/data/repository/history_order_repository.dart';
import 'package:shaftrent/data/repository/maps_repository.dart';
import 'package:shaftrent/data/repository/message_repository.dart';
import 'package:shaftrent/data/repository/order_car_repository.dart';
import 'package:shaftrent/data/repository/profile_repository.dart';
import 'package:shaftrent/presentation/admin/car/bloc/car_bloc.dart';
import 'package:shaftrent/presentation/admin/dashboard/customer_profile/bloc/customer_profile_bloc.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_bloc.dart';
import 'package:shaftrent/presentation/admin/maps/bloc/maps_bloc.dart';
import 'package:shaftrent/presentation/admin/message/bloc/message_admin_bloc.dart';
import 'package:shaftrent/presentation/auth/bloc/login/login_bloc.dart';
import 'package:shaftrent/presentation/auth/bloc/register/register_bloc.dart';
import 'package:shaftrent/presentation/customer/car_order/bloc/car_order_bloc.dart';
import 'package:shaftrent/presentation/customer/dashboard/message_customer/bloc/message_customer_bloc.dart';
import 'package:shaftrent/presentation/customer/dashboard/profile/bloc/profile_bloc.dart';
import 'package:shaftrent/presentation/customer/history_order/bloc/history_order_bloc.dart';
import 'package:shaftrent/presentation/customer/maps_customer/bloc/maps_customer_bloc.dart';
import 'package:shaftrent/presentation/no_auth/car/bloc/car_no_auth_bloc.dart';
import 'package:shaftrent/presentation/no_auth/homepage_screen.dart';
import 'package:shaftrent/presentation/no_auth/maps/bloc/maps_no_auth_bloc.dart';
import 'package:shaftrent/service/service_http_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterBloc(authRepository: AuthRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => LoginBloc(authRepository: AuthRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => CarBloc(carRepository: CarRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => MapsBloc(mapsRepository: MapsRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => ProfileBloc(profileRepository: ProfileRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => CustomerProfileBloc(customerRepository: ProfileRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => CarOrderBloc(carRepository: CarRepository(ServiceHttpClient()), carOrderRepository: OrderCarRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => HistoryOrderBloc(historyOrderRepository: HistoryOrderRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => OrderCarByCustomerBloc(orderRepository: OrderCarRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => MessageAdminBloc(messageAdminRepository: MessageRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => MessageCustomerBloc(messageCustomerrepository: MessageRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => MapsCustomerBloc(mapsRepository: MapsRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => CarNoAuthBloc(carRepository: CarRepository(ServiceHttpClient()))),
        BlocProvider(create: (context) => MapsNoAuthBloc(mapsRepository: MapsRepository(ServiceHttpClient())))
      ],
      child: MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomepageScreen(),
      debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
