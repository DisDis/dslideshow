import 'package:config_app/src/bloc/authentication_bloc.dart';
import 'package:config_app/src/bloc/authentication_event.dart';
import 'package:config_app/src/bloc/photoframe_repository.dart';
import 'package:config_app/src/page/home/bloc/home_cubit.dart';
import 'package:config_app/src/page/home/bloc/home_state.dart';
import 'package:config_app/src/page/home/view/web_tab.dart';
import 'package:config_app/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(userRepository: RepositoryProvider.of<UserRepository>(context)),
      child: const HomeView(),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                final userId = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.id,
                );
                return Text('UserID: $userId');
              },
            ),
            ConfigTabs(),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }*/
}

class ConfigTabs extends StatelessWidget {
  const ConfigTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/**
 const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
 * 
 */

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Config'),
        actions: [
          ElevatedButton(
            child: const Text('Logout'),
            onPressed: () {
              context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedTab.index,
        children: [
          Container(
            child: Text('1'),
          ),
          Container(
            child: Text('2'),
          ),
          Container(
            child: Text('3'),
          ),
          Container(
            child: Text('4'),
          ),
          WebConfigTab(),
          Container(
            child: Text('6'),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   key: const Key('homeView_addTodo_floatingActionButton'),
      //   onPressed: () => Navigator.of(context).push(EditTodoPage.route()),
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.web,
              icon: const Icon(Icons.web_asset),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.slideshow,
              icon: const Icon(Icons.picture_in_picture),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color: groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
