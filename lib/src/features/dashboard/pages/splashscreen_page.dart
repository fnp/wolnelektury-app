import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _revealAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSplashSequence();
    });
  }

  Future<void> _startSplashSequence() async {
    await _animationController.forward();
    // Navigate to home screen
    if (mounted) {
      router.pushReplacementNamed(cataloguePageConfig.name);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _revealAnimation,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [
                    0.0,
                    _revealAnimation.value.clamp(0.0, 1.0),
                    (_revealAnimation.value + 0.1).clamp(0.0, 1.0),
                    1.0,
                  ],
                  colors: const [
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: SvgPicture.asset(Images.logo, width: 165),
            );
          },
        ),
      ),
    );
  }
}
