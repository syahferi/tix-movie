part of "pages.dart";

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, state) {
              if (state is UserLoadSuccess) {
                if (imageToUpload != null) {
                  uploadImage(imageToUpload!).then((downloadUrl) {
                    imageToUpload = null;
                    BlocProvider.of<UserBloc>(context)
                        .add(UpdatedData(profileImage: downloadUrl));
                  });
                }
                var profilePicture = state.user.profilePicture;
                return Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF5F5588), width: 1),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          if (profilePicture != null && profilePicture.isEmpty)
                            SpinKitFadingCircle(
                              color: accentColor2,
                              size: 50,
                            ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (profilePicture != null &&
                                          profilePicture.isEmpty)
                                      ? AssetImage('assets/profile_icon.png')
                                      : NetworkImage(profilePicture ?? '')
                                          as ImageProvider,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ), //im
                    const SizedBox(width: 16), // age
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              78,
                          child: Text(
                            state.user.name ?? 'no names',
                            style: whiteTextFont.copyWith(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              78,
                          child: Text(
                            NumberFormat.currency(
                                    locale: "id_Id",
                                    decimalDigits: 0,
                                    symbol: "IDR ")
                                .format(state.user.accountBalance ?? 0),
                            style: yellowNumberFont.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return SpinKitFadingCircle(
                  color: accentColor3,
                  size: 5,
                );
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: defaultMargin, top: 30, right: defaultMargin, bottom: 10),
          child: Text(
            'Now Playing',
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, state) {
              if (state is MovieLoaded) {
                List<Movie> movies = state.movies.sublist(0, 10);

                return ListView.builder(
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: defaultMargin,
                    ),
                    child: MovieCard(movies[index]),
                  ),
                  itemCount: movies.length,
                  scrollDirection: Axis.horizontal,
                );
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            'Browse Movie',
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        BlocBuilder<UserBloc, UserState>(builder: (_, state) {
          if (state is UserLoadSuccess) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  state.user.selectedGenre!.length,
                  (index) => BrowseButton(
                    state.user.selectedGenre?[index],
                  ),
                ),
              ),
            );
          } else {
            return SpinKitFadingCircle(
              color: accentColor2,
              size: 50,
            );
          }
        }),
        Container(
          margin: EdgeInsets.only(
              left: defaultMargin, top: 30, right: defaultMargin, bottom: 10),
          child: Text(
            'Coming Soon',
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, state) {
              if (state is MovieLoaded) {
                List<Movie> movies = state.movies.sublist(10);

                return ListView.builder(
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: defaultMargin,
                    ),
                    child: ComingSoon(movies[index]),
                  ),
                  itemCount: movies.length,
                  scrollDirection: Axis.horizontal,
                );
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: defaultMargin, top: 30, right: defaultMargin, bottom: 10),
          child: Text(
            'Get Lucky Day',
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: dummyPromo
              .map((e) => Padding(
                    padding: const EdgeInsets.fromLTRB(
                        defaultMargin, 0, defaultMargin, defaultMargin),
                    child: PromoCard(e),
                  ))
              .toList(),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
