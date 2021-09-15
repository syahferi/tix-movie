part of "pages.dart";

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(radius: 2.0, colors: [
          mainColor,
          accentColor1,
        ])),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 136,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/movie_icon.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70, bottom: 16),
              child: Text(
                'New Experience',
                style:
                    blackTextFont.copyWith(fontSize: 20, color: Colors.white),
              ),
            ),
            Text(
              'Watch a new movie\n easier than any before',
              style: greyTextFont.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Container(
              width: 250,
              height: 46,
              margin: EdgeInsets.only(top: 70, bottom: 19),
              child: ElevatedButton(
                child: Text(
                  'Get Started',
                  style: whiteTextFont.copyWith(
                      fontSize: 16,
                      color: mainColor,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(accentColor2)),
                onPressed: () => BlocProvider.of<PageBloc>(context)
                    .add(GoToRegistrationPage(RegistrationData())),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: greyTextFont.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      BlocProvider.of<PageBloc>(context).add(GoToLoginPage()),
                  child: Text(
                    'Sign In',
                    style: purpleTextFont.copyWith(
                        color: accentColor2, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
