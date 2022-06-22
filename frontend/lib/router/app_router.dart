import 'package:auto_route/auto_route.dart';

import '../features/products_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: ProductPage, initial: true),
  ],
)
class $AppRouter {}
