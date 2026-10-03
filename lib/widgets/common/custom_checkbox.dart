import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Styled checkbox matching ui.html
class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: value ? AppColors.navy : AppColors.inputBg,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: value ? AppColors.navy : AppColors.border,
                  width: 1.5,
                ),
              ),
              child: value
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        size: 13,
                        color: AppColors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.muted,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
