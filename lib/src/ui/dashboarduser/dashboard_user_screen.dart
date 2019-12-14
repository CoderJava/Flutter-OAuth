import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_oauth/src/bloc/dashboarduser/dashboard_user_bloc.dart';
import 'package:flutter_sample_oauth/src/injector/injector.dart';
import 'package:flutter_sample_oauth/src/model/user/user.dart';
import 'package:flutter_sample_oauth/src/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_sample_oauth/src/widget/widget_card_loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardUserScreen extends StatefulWidget {
  @override
  _DashboardUserScreenState createState() => _DashboardUserScreenState();
}

class _DashboardUserScreenState extends State<DashboardUserScreen> {
  final DashboardUserBloc _dashboardUserBloc = DashboardUserBloc();

  @override
  void initState() {
    _dashboardUserBloc.add(DashboardUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _dashboardUserBloc.add(DashboardUserEvent());
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.signOutAlt),
            onPressed: () {
              locator<SharedPreferencesManager>().clearAll();
              Navigator.pushNamedAndRemoveUntil(context, '/login_screen', (r) => false);
            },
          ),
        ],
      ),
      body: BlocProvider<DashboardUserBloc>(
        create: (context) => _dashboardUserBloc,
        child: BlocListener<DashboardUserBloc, DashboardUserState>(
          listener: (context, state) {
            if (state is DashboardUserFailure) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
              ));
            }
          },
          child: BlocBuilder<DashboardUserBloc, DashboardUserState>(
            builder: (context, state) {
              if (state is DashboardUserLoading) {
                return WidgetCardLoading();
              } else if (state is DashboardUserSuccess) {
                List<ItemUser> users = state.users;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    ItemUser itemUser = users[index];
                    return ListTile(
                      title: Text(
                        itemUser.username,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        '${itemUser.age}',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: users.length,
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
