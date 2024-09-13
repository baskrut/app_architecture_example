import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:app_architecture_example/ui/styling/shadows/text_input_shadow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final TextEditingController? textController;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? errorText;
  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextStyle? errorStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Function? onFieldSubmitted;
  final bool? autofocus;

  const TextInputField({
    this.textController,
    this.keyboardType,
    this.label,
    this.hint,
    this.hintStyle,
    this.onChanged,
    this.focusNode,
    this.nextFocusNode,
    this.errorText,
    this.errorStyle,
    this.validator,
    this.inputFormatters,
    this.onEditingComplete,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofocus,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late final FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
    }

    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    if (widget.focusNode != null) {
      _focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = _hasFocus
        ? Theme.of(context).textTheme.headlineMedium?.copyWith(color: appBlue)
        : Theme.of(context).textTheme.headlineMedium;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
          height: 60,
          child: TextFormField(
            autofocus: widget.autofocus ?? false,
            onEditingComplete: widget.onEditingComplete,
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            controller: widget.textController,
            style: Theme.of(context).textTheme.headlineMedium,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            onFieldSubmitted: (term) {
              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!();
              }
              _onFieldSubmitted(context);
            },
            validator: widget.validator,
            decoration: InputDecoration(
              isDense: true,
              errorText: widget.errorText != null ? '' : null,
              errorStyle: const TextStyle(height: 0.0),
              alignLabelWithHint: true,
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              counterText: '',
              labelText: widget.label,
              labelStyle: style,
              hintText: widget.hint,
              hintStyle: widget.hintStyle ?? style,
              disabledBorder: ShadowInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: appBlue, width: 1.0),
                  ),
                  shadow: textInputActiveShadow),
              focusedBorder: ShadowInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: appBlue, width: 1.0),
                  ),
                  shadow: textInputActiveShadow),
              enabledBorder: ShadowInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: borderGrey, width: 1.0),
                  ),
                  shadow: textInputActiveShadow),
              border: ShadowInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: borderGrey, width: 1.0),
                  ),
                  shadow: textInputActiveShadow),
              focusedErrorBorder: ShadowInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: appError, width: 1.0),
                  ),
                  shadow: textInputErrorShadow),
              errorBorder: ShadowInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: appError, width: 1.0),
                  ),
                  shadow: textInputErrorShadow),
            ),
          ),
        ),
        if (widget.errorText != null && '${widget.errorText}'.isNotEmpty)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                widget.errorText ?? 'error',
                // .copyWith(color: appError)
                style: widget.errorStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(color: appError),
              ),
            ),
          )
      ],
    );
  }

  void _onFieldSubmitted(BuildContext context) {
    widget.focusNode?.unfocus();
    FocusScope.of(context).requestFocus(widget.nextFocusNode);
  }
}

class ShadowInputBorder extends OutlineInputBorder {
  ShadowInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart, double gapExtent = 0.0, double gapPercentage = 0.0, TextDirection? textDirection}) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow.toPaint();
    final Rect bounds = rect.shift(shadow.offset).inflate(shadow.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(canvas, rect,
        gapStart: gapStart, gapExtent: gapExtent, gapPercentage: gapPercentage, textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is ShadowInputBorder &&
        other.borderSide == borderSide &&
        other.child == child &&
        other.shadow == shadow;
  }

  @override
  int get hashCode => Object.hash(borderSide, child, shadow);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'DecoratedInputBorder')}($borderSide, $shadow, $child)';
  }
}
