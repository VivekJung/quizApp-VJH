import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/shared/common_widgets/custom_loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    var report = Provider.of<Report>(context);
    var user = AuthService().user;
    log('${user?.photoURL} photo');
    log('${user?.displayName} name');

    if (user != null) {
      return profileContents(user, context, report, navigator);
    } else {
      return noUserDisplay(navigator);
    }

    // return circularLoading(200);
  }

  profileContents(User user, BuildContext context, Report report,
      NavigatorState navigator) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            //profile picture
            Container(
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user.photoURL ??
                      "https://cdn-icons-png.flaticon.com/512/3898/3898303.png"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user.displayName ?? 'Guest',
              style: const TextStyle(color: Colors.white),
            ),
            Text(user.email ?? '',
                style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 20),
            // quiz count
            Text(
              report.total == 0 ? "0" : report.total.toString(),
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 80),
            ),
            Text('Quizzes completed',
                style: Theme.of(context).textTheme.headline1),

            const SizedBox(height: 20),
            const Spacer(),

            ProfileButtons(
              btnFunction: () {
                Navigator.pushNamed(context, '/topics');
              },
              btnColor: Colors.greenAccent.shade700,
              btnIcon: Icons.person_add_alt_rounded,
              label: 'Continue playing more',
            ),
            const SizedBox(height: 20),
            //signOut button
            ProfileButtons(
              btnFunction: () async {
                var logOutStatus = await AuthService().signOut();

                if (logOutStatus == null) {
                  navigator.pushNamedAndRemoveUntil('/', (route) => false);
                } else {
                  log('Error while loging out - UI, $logOutStatus');
                }
                //
              },
              btnColor: Colors.deepOrange,
              btnIcon: Icons.logout_sharp,
              label: 'Sign Out',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  noUserDisplay(NavigatorState navigator) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No user DATA found'),
            ProfileButtons(
              btnFunction: () async {
                var logOutStatus = await AuthService().signOut();

                if (logOutStatus == null) {
                  navigator.pushNamedAndRemoveUntil('/', (route) => false);
                } else {
                  log('Error while logging out - UI, $logOutStatus');
                }
                //
              },
              btnColor: Colors.redAccent,
              btnIcon: Icons.logout_sharp,
              label: 'Try logging in again',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({
    Key? key,
    required this.btnFunction,
    required this.btnColor,
    required this.btnIcon,
    required this.label,
  }) : super(key: key);

  final Function()? btnFunction;
  final Color? btnColor;
  final IconData btnIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: ElevatedButton.icon(
        onPressed: btnFunction ?? () {},
        //

        icon: Icon(
          btnIcon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: btnColor ?? Colors.white,
        ),
        label: Text(
          label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
