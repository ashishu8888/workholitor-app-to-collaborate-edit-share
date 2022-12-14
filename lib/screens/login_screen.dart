import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_collaborative/constants/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:work_collaborative/repository/auth_repository.dart';
import 'package:work_collaborative/screens/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void signInwithGoogle(WidgetRef ref, BuildContext context) async {
    final eMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final errorModel =
        await ref.read(AuthRepositoryProvider).signinWithGoogle();
    if (errorModel.error != null) {
      eMessenger.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    } else {
      ref.read(userProvider.notifier).update(
            (state) => errorModel.data,
          );
      navigator.push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: ColorForApp.bgmColor.withOpacity(1),
          image: const DecorationImage(
            image: AssetImage(
              "lib/assets/bg01.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'hello, ',
                    style: GoogleFonts.acme(
                        color: ColorForApp.color1.withOpacity(1),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'there',
                    style: GoogleFonts.acme(
                        color: ColorForApp.color1.withOpacity(1),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  Text(
                    '      < your personalized collaborative editor: share, create, collaborate >',
                    style: GoogleFonts.acme(
                      color: ColorForApp.color1.withOpacity(1),
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('lib/assets/bg0.png'),
                radius: 40,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () => signInwithGoogle(ref, context),
                icon: Image.asset(
                  'lib/assets/g-logo-2.png',
                  height: 20,
                ),
                label: Text(
                  'sign in with google',
                  style: GoogleFonts.acme(
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50), primary: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
