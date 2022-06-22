import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:products_crud/redux/app/app_state.dart';
import 'package:products_crud/redux/store.dart';
import 'package:products_crud/router/app_router.gr.dart';
import 'package:redux/redux.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var store = await createStore();
  runApp(MyApp(store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  const MyApp(this.store);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp.router(
        title: 'Products',
        debugShowCheckedModeBanner: false,
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
      ),
    );
  }
}
