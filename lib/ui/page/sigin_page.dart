part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeAppBloc>(context)
        .add(ThemeAppChanged(ThemeData(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 70,
                    child: Image.asset('assets/default_cinema.png'),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 70, bottom: 40),
                      child: Text(
                        'Welcome Back\nExplorer!',
                        style: blackTextFont.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Email Address',
                      hintText: 'Email Address',
                    ),
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Password',
                      hintText: 'Password',
                    ),
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Forgot Password? ',
                        style: greyTextFont.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Get Now',
                        style: greyTextFont.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 40, bottom: 30),
                      child: isSigningIn
                          ? SpinKitFadingCircle(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              child: Icon(
                                Icons.arrow_forward,
                                color: isEmailValid && isPasswordValid
                                    ? Colors.white
                                    : Color(0xFFBEBEBE),
                              ),
                              backgroundColor: isEmailValid && isPasswordValid
                                  ? mainColor
                                  : Color(0xFFE4E4E4),
                              onPressed: isEmailValid && isPasswordValid
                                  ? () async {
                                      setState(() {
                                        isSigningIn = true;
                                      });
                                      SignInSignUpResult result =
                                          await AuthService.signIn(
                                              emailController.text,
                                              passwordController.text);

                                      if (result.userTix == null) {
                                        setState(() {
                                          isSigningIn = false;
                                        });
                                        Flushbar(
                                          duration: Duration(seconds: 4),
                                          backgroundColor: Color(0xFFFF5C83),
                                          message: result.message,
                                        )..show(context);
                                      }
                                    }
                                  : null,
                            ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Start Fresh Now? ',
                        style: greyTextFont.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Sign Up',
                        style: purpleTextFont.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // ElevatedButton(
                  //   child: Text('Sign In'),
                  //   onPressed: () async => await AuthService.signIn(
                  //     'mobile@gmail.com',
                  //     '123456',
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class Cinema {
  double price;

  Cinema(this.price);

  double calculateAdminFee();
}

class StandardCinema extends Cinema {
  StandardCinema(double price) : super(price);

  @override
  double calculateAdminFee() {
    return price * 10 / 100;
  }
}

class DeluxeCinema extends Cinema {
  DeluxeCinema(double price) : super(price);

  @override
  double calculateAdminFee() {
    return price * 12 / 100;
  }
}

class PremiumCinema extends Cinema {
  PremiumCinema(double price) : super(price);

  @override
  double calculateAdminFee() {
    return price * 20 / 100;
  }
}
