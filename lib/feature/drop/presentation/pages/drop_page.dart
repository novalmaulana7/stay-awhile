import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_awhile_mobile/const/app_colors.dart';
import 'package:stay_awhile_mobile/const/app_size.dart';
import 'package:stay_awhile_mobile/const/app_textstyle.dart';
import 'package:stay_awhile_mobile/feature/drop/presentation/viewmodels/drop_viewmodel.dart';
import 'package:stay_awhile_mobile/feature/drop/presentation/widgets/drop_message_input_widget.dart';
import 'package:stay_awhile_mobile/feature/drop/presentation/widgets/drop_category_picker_widget.dart';
import 'package:stay_awhile_mobile/feature/drop/presentation/widgets/drop_media_attachment_widget.dart';
import 'package:stay_awhile_mobile/feature/drop/presentation/widgets/drop_location_preview_widget.dart';
import 'package:stay_awhile_mobile/feature/drop/presentation/widgets/drop_bottom_action_widget.dart';

class DropPage extends StatefulWidget {
  const DropPage({super.key});

  @override
  State<DropPage> createState() => _DropPageState();
}

class _DropPageState extends State<DropPage> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final lat = extra?['lat'] as double? ?? -6.8912;
    final lng = extra?['lng'] as double? ?? 107.6110;
    final locationLabel = extra?['locationLabel'] as String? ?? 'Unknown location';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DropViewmodel>().setLocation(
        lat: lat,
        lng: lng,
        label: locationLabel,
      );
    });

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Drop a Message',
          style: AppTextStyle.headlineMd.copyWith(color: AppColors.primary),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.onSurfaceVariant,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.marginMobile,
              ).copyWith(top: AppSize.spacingLg, bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropMessageInputWidget(
                    controller: _messageController,
                    onChanged: (value) {
                      context.read<DropViewmodel>().setMessage(value);
                    },
                  ),
                  const SizedBox(height: AppSize.spacingXl),
                  const DropCategoryPickerWidget(),
                  const SizedBox(height: AppSize.spacingXl),
                  const DropMediaAttachmentWidget(),
                  const SizedBox(height: AppSize.spacingXl),
                  DropLocationPreviewWidget(
                    locationLabel: locationLabel,
                  ),
                ],
              ),
            ),
          ),
          DropBottomActionWidget(
            onPressed: () async {
              final vm = context.read<DropViewmodel>();
              await vm.dropMessage();
              if (vm.status == DropStatus.success && context.mounted) {
                context.pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
