import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/drop/presentation/viewmodels/drop_viewmodel.dart';

/// Fixed bottom action bar with "Drop Message" submit button.
class DropBottomActionWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const DropBottomActionWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.marginMobile,
        vertical: AppSize.spacingMd,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant, width: 0.1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Selector<DropViewmodel, ({bool canSubmit, DropStatus status})>(
          selector: (_, vm) => (
            canSubmit: vm.canSubmit,
            status: vm.status,
          ),
          builder: (_, data, _) {
            final isLoading = data.status == DropStatus.loading;
            return SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: data.canSubmit && !isLoading ? onPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimaryContainer,
                  disabledBackgroundColor:
                      AppColors.primaryContainer.withValues(alpha: 0.4),
                  elevation: 8,
                  shadowColor: AppColors.primaryContainer.withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.radiusFull),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.onPrimaryContainer,
                        ),
                      )
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Drop Message',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: AppSize.spacingSm),
                          Icon(Icons.send_outlined, size: 20),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
