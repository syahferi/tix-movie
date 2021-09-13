part of "pages.dart";

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
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
                                    ? AssetImage("assets/005-glass.png")
                                    : NetworkImage(profilePicture ?? '')
                                        as ImageProvider,
                              ),
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
      ],
    );
  }
}
