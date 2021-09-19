part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  const AccountConfirmationPage(this.registrationData, {Key? key})
      : super(key: key);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool _isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    var profilePicture = widget.registrationData.profileImage;

    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<PageBloc>(context)
            .add(GotoPreferencePage(widget.registrationData));
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => BlocProvider.of<PageBloc>(context).add(
                                GotoPreferencePage(widget.registrationData)),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Confirm\nNew Account',
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 90),
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipOval(
                      child: profilePicture == null
                          ? Image.asset('assets/profile_icon.png')
                          : Image.file(
                              File(profilePicture.path),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome\n${widget.registrationData.name}',
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 110),
                  (_isSigningUp)
                      ? SpinKitFadingCircle(
                          color: Color(0xFF3E9090),
                          size: 45,
                        )
                      : SizedBox(
                          width: 250,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF3E9D9D)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isSigningUp = true;
                              });

                              imageToUpload =
                                  widget.registrationData.profileImage;

                              SignInSignUpResult result =
                                  await AuthService.signUp(
                                      widget.registrationData.email,
                                      widget.registrationData.password,
                                      widget.registrationData.name,
                                      widget.registrationData.selectedGenres,
                                      widget.registrationData.selectedLang);

                              if (result.userTix == null) {
                                setState(() {
                                  _isSigningUp = false;
                                });

                                Flushbar(
                                  duration: Duration(milliseconds: 1500),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: result.message,
                                )..show(context);
                              }
                            },
                            child: Text(
                              'Create My Account',
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
