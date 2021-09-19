part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = Provider.of<User?>(context);

    if (firebaseUser == null) {
      if (previousPageEvent is! GoToSplashPage) {
        previousPageEvent = GoToSplashPage();
        BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
      }
    } else {
      if (previousPageEvent is! GoToMainPage) {
        previousPageEvent = GoToMainPage();

        BlocProvider.of<UserBloc>(context).add(UserLoaded(firebaseUser.uid));
        BlocProvider.of<PageBloc>(context).add(GoToMainPage());
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, state) => (state is OnSplashPage)
            ? SplashPage()
            : (state is OnLoginPage)
                ? SignInPage()
                : (state is OnRegistrationPage)
                    ? SignUpPage(state.registrationData)
                    : (state is OnPreferencePage)
                        ? PreferencePage(state.registrationData)
                        : (state is OnAccountConfirmationPage)
                            ? AccountConfirmationPage(state.registrationData)
                            : MainPage());
  }
}
