part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;

  const PreferencePage(this.registrationData, {Key? key}) : super(key: key);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  final List<String> genres = [
    'Horor',
    'Music',
    'Action',
    'Drama',
    'War',
    'Crime',
    'Comedy',
  ];
  final List<String> languages = [
    'Indonesia',
    'English',
    'Korean',
    'Arabian',
    'Japanese',
  ];

  List<String> selectedGenre = [];
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          widget.registrationData.password = '';
          BlocProvider.of<PageBloc>(context)
              .add(GoToRegistrationPage(widget.registrationData));
          return Future.value(false);
        },
        child: Scaffold(
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      margin: EdgeInsets.only(top: 20, bottom: 4),
                      child: GestureDetector(
                          onTap: () {
                            widget.registrationData.password = '';
                            BlocProvider.of<PageBloc>(context).add(
                                GoToRegistrationPage(widget.registrationData));
                          },
                          child: Icon(Icons.arrow_back)),
                    ),
                    Text(
                      'Select Your Four\nFavorite Genre',
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: generateGenreWidget(context),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Movie Language\nYou Prefer?',
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: generateLanguageWidget(context),
                    ),
                    const SizedBox(height: 30),
                    Center(
                        child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: mainColor,
                            child: Icon(Icons.arrow_forward),
                            onPressed: () {
                              if (selectedGenre.length != 4) {
                                Flushbar(
                                  duration: Duration(milliseconds: 1500),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: 'Please select 4 genre',
                                )..show(context);
                              } else {
                                widget.registrationData.selectedGenres =
                                    selectedGenre;
                                widget.registrationData.selectedLang =
                                    selectedLanguage;

                                BlocProvider.of<PageBloc>(context).add(
                                    GoToAccountConfirmationPage(
                                        widget.registrationData));
                              }
                            })),
                    const SizedBox(height: 50),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  List<Widget> generateGenreWidget(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - (2 * defaultMargin) - 24) / 2;

    return genres
        .map(
          (data) => SelectableBox(
            data,
            width: width,
            isSelected: selectedGenre.contains(data),
            onTap: () {
              onSelectGenre(data);
            },
          ),
        )
        .toList();
  }

  void onSelectGenre(String data) {
    if (selectedGenre.contains(data)) {
      setState(() {
        selectedGenre.remove(data);
      });
    } else {
      if (selectedGenre.length < 4) {
        setState(() {
          selectedGenre.add(data);
        });
      } else {
        Flushbar(
          duration: Duration(milliseconds: 1500),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: Color(0xFFFF5C83),
          message: 'You can only chose 4 genre',
        )..show(context);
      }
    }
  }

  List<Widget> generateLanguageWidget(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                setState(() {
                  selectedLanguage = e;
                });
              },
            ))
        .toList();
  }
}
