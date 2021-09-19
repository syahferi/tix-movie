import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tix_movie/bloc/blocs.dart';
import 'package:tix_movie/model/models.dart';
import 'package:tix_movie/services/services.dart';
import 'package:tix_movie/shared/shared.dart';
import 'package:tix_movie/ui/widget/widgets.dart';

part 'account_confirmation_page.dart';
part 'main_page.dart';
part 'movie_page.dart';
part 'preference_page.dart';
part 'sigin_page.dart';
part 'sign_up_page.dart';
part 'splash_page.dart';
part 'wrapper.dart';

Future<XFile?> getImage() async {
  final imagePicker = ImagePicker();
  final image = await imagePicker.pickImage(source: ImageSource.gallery);
  return image;
}
