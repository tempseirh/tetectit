import 'package:flutter/material.dart';

class ScanningAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color scanLineColor;
  final double scanLineHeight;
  final BorderRadius? borderRadius;
  final bool isScanning;

  const ScanningAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.scanLineColor = Colors.white,
    this.scanLineHeight = 4.0, // Increased default height
    this.borderRadius,
    this.isScanning = true,
  });

  @override
  State<ScanningAnimation> createState() => _ScanningAnimationState();
}

class _ScanningAnimationState extends State<ScanningAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    // Start the animation and make it repeat
    if (widget.isScanning) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final borderRadius = widget.borderRadius ?? BorderRadius.circular(12);

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // The main content (image)
              ClipRRect(
                borderRadius: borderRadius,
                child: SizedBox.expand(
                  child: widget.child,
                ),
              ),

              // The overlay to indicate scanning is happening
              if (widget.isScanning)
                ClipRRect(
                  borderRadius: borderRadius,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          widget.scanLineColor.withOpacity(0.05),
                          widget.scanLineColor.withOpacity(0.1),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),

              // The scanning line
              if (widget.isScanning)
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final topPosition =
                        (_animation.value * constraints.maxHeight).clamp(
                            0.0, constraints.maxHeight - widget.scanLineHeight);

                    return Positioned(
                      left: 0,
                      right: 0,
                      top: topPosition,
                      child: Container(
                        height: widget.scanLineHeight,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          // Much brighter line
                          color: widget.scanLineColor.withOpacity(0.8),
                          boxShadow: [
                            BoxShadow(
                              color: widget.scanLineColor.withOpacity(0.6),
                              blurRadius: 12,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
