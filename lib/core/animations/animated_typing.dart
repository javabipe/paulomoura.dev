import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AnimatedTyping extends StatefulWidget {
  final List<String> texts;
  final TextStyle style;
  final Duration typingSpeed;
  final Duration erasingSpeed;
  final Duration pauseDuration;

  const AnimatedTyping({
    super.key,
    required this.texts,
    required this.style,
    this.typingSpeed = const Duration(milliseconds: 100),
    this.erasingSpeed = const Duration(milliseconds: 50),
    this.pauseDuration = const Duration(milliseconds: 2000),
  });

  @override
  State<AnimatedTyping> createState() => _AnimatedTypingState();
}

class _AnimatedTypingState extends State<AnimatedTyping> {
  String _currentText = "";
  int _textIndex = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  bool _cursorVisible = true;
  Timer? _cursorTimer;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _startCursorBlinking();
    _runTypewriter();
  }

  void _startCursorBlinking() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _cursorVisible = !_cursorVisible;
        });
      }
    });
  }

  void _runTypewriter() {
    if (!mounted) return;

    final fullText = widget.texts[_textIndex];

    if (!_isDeleting) {
      // Typing
      if (_charIndex < fullText.length) {
        _charIndex++;
        setState(() {
          _currentText = fullText.substring(0, _charIndex);
        });
        _typingTimer = Timer(widget.typingSpeed, _runTypewriter);
      } else {
        // Pausing after typing complete
        _isDeleting = true;
        _typingTimer = Timer(widget.pauseDuration, _runTypewriter);
      }
    } else {
      // Erasing
      if (_charIndex > 0) {
        _charIndex--;
        setState(() {
          _currentText = fullText.substring(0, _charIndex);
        });
        _typingTimer = Timer(widget.erasingSpeed, _runTypewriter);
      } else {
        // Switch to next text
        _isDeleting = false;
        _textIndex = (_textIndex + 1) % widget.texts.length;
        _typingTimer = Timer(const Duration(milliseconds: 500), _runTypewriter);
      }
    }
  }

  @override
  void dispose() {
    _cursorTimer?.cancel();
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _currentText,
          style: widget.style,
        ),
        AnimatedOpacity(
          opacity: _cursorVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 50),
          child: Text(
            "|",
            style: widget.style.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
