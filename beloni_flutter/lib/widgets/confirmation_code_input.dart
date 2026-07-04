import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class ConfirmationCodeInput extends StatefulWidget {
  final int length;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;

  const ConfirmationCodeInput({
    super.key,
    required this.length,
    required this.onChanged,
    required this.onCompleted,
  });

  @override
  State<ConfirmationCodeInput> createState() => _ConfirmationCodeInputState();
}

class _ConfirmationCodeInputState extends State<ConfirmationCodeInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    String code = _controllers.map((c) => c.text).join();
    widget.onChanged(code);

    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        if (code.length == widget.length) {
          widget.onCompleted(code);
        }
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.length,
        (index) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.mainColor),
          ),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            maxLength: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            style: AppTypography.latoRegular.copyWith(fontSize: 24, color: AppColors.mainColor),
            onChanged: (value) => _onChanged(value, index),
          ),
        ),
      ),
    );
  }
}
