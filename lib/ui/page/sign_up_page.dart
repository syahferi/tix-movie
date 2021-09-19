part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  const SignUpPage(this.registrationData, {Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late XFile? profilePicture;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    profilePicture = widget.registrationData.profileImage;

    BlocProvider.of<ThemeAppBloc>(context)
        .add(ThemeAppChanged(ThemeData().copyWith(primaryColor: Colors.grey)));

    return WillPopScope(
        onWillPop: () async {
          BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
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
                              onTap: () => BlocProvider.of<PageBloc>(context)
                                  .add(GoToSplashPage()),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Create New\nAccount',
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 104,
                      child: Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            child: ClipOval(
                              child: (profilePicture == null)
                                  ? Image.asset('assets/profile_icon.png')
                                  : Image.file(
                                      File(
                                        profilePicture?.path ?? '',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                if (widget.registrationData.profileImage ==
                                    null) {
                                  widget.registrationData.profileImage =
                                      await getImage();
                                } else {
                                  widget.registrationData.profileImage = null;
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: (profilePicture == null)
                                        ? AssetImage('assets/add_icon.png')
                                        : AssetImage('assets/delete_icon.png')
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Full Name',
                        hintText: 'Full Name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Email',
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Password',
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
                      ),
                    ),
                    const SizedBox(height: 30),
                    FloatingActionButton(
                      onPressed: () {
                        if (nameController.text.trim().isEmpty &&
                            emailController.text.trim().isEmpty &&
                            passwordController.text.trim().isEmpty &&
                            confirmPasswordController.text.trim().isEmpty) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: Color(0xFFFF5C83),
                            message: 'Please fill all the fields',
                          )..show(context);
                        } else if (passwordController.text.trim() !=
                            confirmPasswordController.text.trim()) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: Color(0xFFFF5C83),
                            message: 'Mismatch password and confirmed password',
                          )..show(context);
                        } else if (passwordController.text.trim().length < 6) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: Color(0xFFFF5C83),
                            message: 'Password length min 6 character',
                          )..show(context);
                        } else if (!EmailValidator.validate(
                            emailController.text.trim())) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: Color(0xFFFF5C83),
                            message: 'Wrong formatted email address',
                          )..show(context);
                        } else {
                          widget.registrationData.name =
                              nameController.text.trim();
                          widget.registrationData.email =
                              emailController.text.trim();
                          widget.registrationData.password =
                              passwordController.text.trim();

                          BlocProvider.of<PageBloc>(context)
                              .add(GotoPreferencePage(widget.registrationData));
                        }
                      },
                      backgroundColor: mainColor,
                      child: Icon(Icons.arrow_forward),
                      elevation: 0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
