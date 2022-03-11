import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/home_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/geofencing.dart';
import 'package:profit/widgets/Dashboard/Screens/food_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/workouts_screen.dart';
import 'package:profit/widgets/Dashboard/NavigationBloc/tab_bar_bloc.dart';
import 'package:profit/widgets/Dashboard/NavigationBloc/tab_bar_event.dart';
import 'package:profit/themes/ThemeUI.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (BuildContext context) => TabBarBloc(0),
      child: BlocBuilder<TabBarBloc, int>(
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            body: _createBody(context,
                bloc.currentIndex), //return the index of the screen i want to route
            bottomNavigationBar: _createdBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createdBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/dashboard/home.png', scale: 1.5,),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/dashboard/food.png', scale: 1.5,),
          label: 'Food',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/dashboard/workout.png', scale: 1.5,),
          label: 'Workout',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/dashboard/geofence.png', scale: 1.5,),
          label: 'GeoFence',
        ),
      ],
      selectedLabelStyle: FitnessAppTheme.navScreen,
      fixedColor: Colors.blue,
      onTap: (index) {
        bloc.add(NavBarTappedEvent(
            index: index)); //trigger and notifies the bloc a new event
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [HomePage(),FoodScreen(), WorkoutsPage(), GeoFencing()];
    return children[index];
  }
}