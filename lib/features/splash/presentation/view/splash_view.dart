// import 'package:flutter/material.dart';
// import 'package:project_1/constants/constants.dart';

// class SplashView extends StatelessWidget {
//   const SplashView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.white,
//       body: SplashViewBody(),
//     );
//   }
// }

// class SplashViewBody extends StatefulWidget {
//   const SplashViewBody({super.key});

//   @override
//   State<SplashViewBody> createState() => _SplashViewBodyState();
// }

// class _SplashViewBodyState extends State<SplashViewBody>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<Offset> slidingAnimation;
//   @override
//   void initState() {
//     super.initState();
//     initSlidingAnimation();
//     navigateToHome();
//   }

//   void dispose() {
//     super.dispose();
//     animationController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Image.asset('assets/images/logo.png', width: 200, height: 250),
//         SlidingText(slidingAnimation: slidingAnimation),
//       ],
//     );
//   }

//   void initSlidingAnimation() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     slidingAnimation = Tween<Offset>(
//       begin: const Offset(0, 2),
//       end: Offset.zero,
//     ).animate(animationController);
//     animationController.forward();
//   }

//   void navigateToHome() {
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushNamed((context), '/login');
//     });
//   }
// }

// class SlidingText extends StatelessWidget {
//   const SlidingText({super.key, required this.slidingAnimation});
//   final Animation<Offset> slidingAnimation;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: slidingAnimation,
//       builder: (context, _) {
//         return SlideTransition(
//           position: slidingAnimation,
//           child: Text(
//             'Your Health,Our Priority',
//             textAlign: TextAlign.center,
//             style: AppFonts.bodyLarge.copyWith(fontWeight: FontWeight.bold),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/auth/presentation/view/log_in_screen.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBody());
  }
}

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSlidingAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset('assets/images/logo.png', width: 200, height: 250),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation = Tween<Offset>(
      begin: Offset(0, 2),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogInScreen()),
      );
    });
  }
}

class SlidingText extends StatelessWidget {
  const SlidingText({super.key, required this.slidingAnimation});
  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Text(
            textAlign: TextAlign.center,
            'Your Health,Our Priority',
            style: AppFonts.bodyLarge.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              fontSize: 18,

              fontFamily: GoogleFonts.smoochSans().fontFamily,
            ),
          ),
        );
      },
    );
  }
}
