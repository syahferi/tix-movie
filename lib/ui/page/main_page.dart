part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Main Page'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hi ${state.user.name}'),
                    ElevatedButton(
                      child: Text('Sign Out'),
                      onPressed: () async => await AuthService.signOut(),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ));
  }
}
