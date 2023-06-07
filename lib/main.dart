// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:authentication_repo/authentication_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:podium/bootstrap.dart';
import 'package:podium/env.dart';
import 'package:podium/firebase_options.dart';
import 'package:podium/src/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FacebookAuth.instance.webAndDesktopInitialize(
    appId: Env.facebookAppId,
    cookie: true,
    xfbml: true,
    version: 'v15.0',
  );

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(PodiumApp(authenticationRepository: authenticationRepository));
}