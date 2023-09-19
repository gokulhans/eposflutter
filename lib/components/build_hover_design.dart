import 'package:flutter/material.dart';

class OnHoverButton extends StatefulWidget {
  final Widget child;
  final Widget Function(bool isHovered)? builder;
  const OnHoverButton({super.key, required this.child, this.builder});

  @override
  State<OnHoverButton> createState() => _OnHoverButtonState();
}

class _OnHoverButtonState extends State<OnHoverButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoverdTransform = Matrix4.identity()
      ..scale(1.1); //Matrix4.identity()..translate(1, -8, 0)..scale(1.2);

    final transform = isHovered ? hoverdTransform : Matrix4.identity();

    return MouseRegion(
        //cursor: SystemMouseCursors.click,
        onEnter: (event) => onEntered(true),
        onExit: (event) => onEntered(false),
        child: AnimatedContainer(
          //  curve: Sprung.overDamped,
          transform: transform,
          duration: const Duration(milliseconds: 200),
          child: widget.child, //widget.builder(isHovered)
        ));
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}

class OnHoverText extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  const OnHoverText({super.key, required this.builder});

  @override
  State<OnHoverText> createState() => _OnHoverTextState();
}

class _OnHoverTextState extends State<OnHoverText> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoverdTransform = Matrix4.identity()
      ..translate(8, 0, 0)
      ..scale(1.2);

    final transform = isHovered ? hoverdTransform : Matrix4.identity();

    return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => onEntered(true),
        onExit: (event) => onEntered(false),
        child: AnimatedContainer(
            //  curve: Sprung.overDamped,
            transform: transform,
            duration: const Duration(milliseconds: 200),
            child: widget.builder(isHovered)));
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}
