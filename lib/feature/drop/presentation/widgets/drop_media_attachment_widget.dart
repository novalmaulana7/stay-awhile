// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:stay_awhile_mobile/const/app_colors.dart';
// import 'package:stay_awhile_mobile/const/app_size.dart';
// import 'package:stay_awhile_mobile/const/app_textstyle.dart';
// import 'package:stay_awhile_mobile/feature/drop/presentation/viewmodels/drop_viewmodel.dart';

// /// Media attachment section with image picker for the Drop feature.
// class DropMediaAttachmentWidget extends StatelessWidget {
//   const DropMediaAttachmentWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Attach a memory',
//           style: AppTextStyle.labelMd.copyWith(
//             color: AppColors.onSurfaceVariant,
//           ),
//         ),
//         const SizedBox(height: AppSize.spacingMd),
//         Selector<DropViewmodel, File?>(
//           selector: (_, vm) => vm.selectedImage,
//           builder: (_, selectedImage, _) {
//             return Row(
//               children: [
//                 _AddPhotoButton(
//                   onTap: () => _showImageSourceDialog(context),
//                 ),
//                 if (selectedImage != null) ...[
//                   const SizedBox(width: AppSize.spacingMd),
//                   _PreviewImage(
//                     file: selectedImage,
//                     onRemove: () {
//                       context.read<DropViewmodel>().removeImage();
//                     },
//                   ),
//                 ],
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }

//   void _showImageSourceDialog(BuildContext context) {
//     showModalBottomSheet<void>(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (ctx) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt_outlined),
//               title: const Text('Camera'),
//               onTap: () {
//                 Navigator.pop(ctx);
//                 context.read<DropViewmodel>().pickImage(ImageSource.camera);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library_outlined),
//               title: const Text('Gallery'),
//               onTap: () {
//                 Navigator.pop(ctx);
//                 context.read<DropViewmodel>().pickImage(ImageSource.gallery);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _AddPhotoButton extends StatelessWidget {
//   final VoidCallback onTap;

//   const _AddPhotoButton({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 120,
//         height: 120,
//         decoration: BoxDecoration(
//           color: AppColors.surfaceContainer,
//           borderRadius: BorderRadius.circular(AppSize.radiusXl),
//           border: Border.all(
//             color: AppColors.outlineVariant,
//             width: 2,
//             style: BorderStyle.solid,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.add_a_photo_outlined,
//               color: AppColors.onSurfaceVariant,
//               size: 32,
//             ),
//             const SizedBox(height: AppSize.spacingSm),
//             Text(
//               'Add Photo',
//               style: AppTextStyle.labelSm.copyWith(color: AppColors.onSurfaceVariant),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _PreviewImage extends StatelessWidget {
//   final File file;
//   final VoidCallback onRemove;

//   const _PreviewImage({required this.file, required this.onRemove});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: 120,
//           height: 120,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(AppSize.radiusXl),
//             image: DecorationImage(
//               image: FileImage(file),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Positioned(
//           top: 4,
//           right: 4,
//           child: GestureDetector(
//             onTap: onRemove,
//             child: Container(
//               padding: const EdgeInsets.all(4),
//               decoration: const BoxDecoration(
//                 color: AppColors.error,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.close,
//                 color: Colors.white,
//                 size: 16,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
