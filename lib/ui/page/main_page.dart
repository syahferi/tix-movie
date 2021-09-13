part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int bottomNavBarIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: accentColor1),
          SafeArea(child: Container(color: Color(0xFFF6F7F9))),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                bottomNavBarIndex = index;
              });
            },
            children: [MoviePage(), Center(child: Text("My Tickets"))],
          ),
          createCustomNavBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 46,
              height: 46,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: accentColor2,
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: Icon(
                    Icons.add,
                    color: Colors.black.withOpacity(0.54),
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(UserSignOut());
                  AuthService.signOut();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createCustomNavBar() => Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: BottomNavBarClipper(),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                bottomNavBarIndex = index;
                pageController.jumpToPage(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                  label: 'New Movies',
                  icon: Container(
                    height: 20,
                    margin: EdgeInsets.only(bottom: 6),
                    child: Image.asset((bottomNavBarIndex == 0)
                        ? "assets/007-popcorn.png"
                        : "assets/001-film_clapperboard.png"),
                  )),
              BottomNavigationBarItem(
                  label: 'My Tickets',
                  icon: Container(
                    height: 20,
                    margin: EdgeInsets.only(bottom: 6),
                    child: Image.asset((bottomNavBarIndex == 1)
                        ? "assets/004-tickets.png"
                        : "assets/001-film_clapperboard.png"),
                  )),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: mainColor,
            unselectedItemColor: Color(0xFFE5E5E5),
            currentIndex: bottomNavBarIndex,
          ),
        ),
      ));
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
}
