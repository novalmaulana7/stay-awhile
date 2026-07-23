import 'package:flutter/material.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/feature/login/presentation/widgets/login_logo_circle_widget.dart';

/// Mobile header with logo circle and app name.
class MobileHeaderWidget extends StatelessWidget {
  const MobileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: AppSize.isMobile(context),
      child: SizedBox(
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LogoCircleWidget(),
            SizedBox(height: AppSize.spacingMd),
            Text(
              'Stay Awhile',
              style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
