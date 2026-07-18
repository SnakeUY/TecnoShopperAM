import 'package:flutter/material.dart';
import 'package:flutter_ces/pages/login_forms/login_page.dart';
import 'package:provider/provider.dart';

import '../../components/stack_pages_route.dart';

class CompraFormsDemo extends StatefulWidget {
  const CompraFormsDemo({super.key});

  @override
  State<CompraFormsDemo> createState() => _CompraFormsDemoState();
}

class SharedFormState {
  Map<String, String> valuesByName = {};

  SharedFormState();
}

class _CompraFormsDemoState extends State<CompraFormsDemo> {
  final GlobalKey<NavigatorState> navKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        //Use provider to pass down a FormState to each of the form views, this way they can easily share and update the same state object
        Provider<SharedFormState>(
          create: (_) => SharedFormState(),
          //Use WillPopScope to intercept hardware back taps, and instead pop the nested navigator
          child: PopScope(
            onPopInvokedWithResult: (didPop, result) async {
              if (!didPop) await _handleBackPop();
            },
            //Use a nested navigator to group the 3 form views under 1 parent view
            child: Navigator(
              key: navKey,
              onGenerateRoute: (route) {
                return StackPagesRoute(
                  previousPages: [],
                  enterPage: LoginPage(),
                  //enterPage: PlantFormPayment(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _handleBackPop() async {
    if (navKey.currentState?.canPop() == true) {
      navKey.currentState?.pop();
    }
    return true;
  }
}
