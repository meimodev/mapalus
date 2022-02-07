import 'package:flutter/material.dart';
import 'package:mapalus/app/modules/splash/splash_screen.dart';
import 'package:mapalus/app/widgets/wrapper_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WrapperScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Upper Section, Search bar, tagline, category cards",
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            "Products goes here",
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            "Cart Card",
            style: Theme.of(context).textTheme.headline5,
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SplashScreen(),
                ),
              )
            },
            child: const Text("Test Navigation"),
          )
        ],
      ),
    );
  }
}