import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/cubit/profile_creation_flow_cubit.dart';
import 'package:playkosmos_v3/ui/profile_creation_flow/view/widgets/next_button.dart';

/// This is the page for uploading pics for the profile creation
/// section
///
/// @author: Godwin Mathias
class UploadPicsPage extends StatelessWidget {
  const UploadPicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCreationFlowCubit, ProfileCreationFlowState,
        List<File?>?>(
      selector: (state) => state.fFlowModel.profilePicsList,
      builder: (context, state) {
        final dSelectedImages = [...?state];
        return LayoutBuilder(builder: (context, constraint) {
          final fMaxWidth = constraint.maxWidth;
          const fItemsWidth = 122;
          final fCrossAxisCount = fMaxWidth ~/ fItemsWidth;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomScrollView(
              slivers: [
                // Title
                SliverToBoxAdapter(
                  child: Text(
                    context.loc.uploadYourPics,
                    style: context.appTextTheme.header1,
                  ),
                ),
                const SliverToBoxAdapter(child: VSpace(12)),

                SliverToBoxAdapter(
                  child: Text(
                    context.loc.timeToShowOffYourProfilePics,
                    style: context.appTextTheme.caption,
                  ),
                ),
                const SliverToBoxAdapter(child: VSpace(40)),

                // Image selection grid
                SliverGrid.builder(
                  itemCount: dSelectedImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: fCrossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return ImageSlot(
                      image: dSelectedImages[index],
                      onAdd: () async {
                        final picker = ImagePicker();
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (pickedFile != null && context.mounted) {
                          dSelectedImages[index] = File(pickedFile.path);
                          if (context.mounted) {
                            context
                                .read<ProfileCreationFlowCubit>()
                                .changeSelectedImageFiles(dSelectedImages);
                          }
                        }
                      },
                      onRemove: () {
                        dSelectedImages[index] = null;
                        context
                            .read<ProfileCreationFlowCubit>()
                            .changeSelectedImageFiles(dSelectedImages);
                      },
                    );
                  },
                ),

                const SliverToBoxAdapter(child: VSpace(40)),

                // The next button
                SliverToBoxAdapter(
                  child: NextButton(fOnPressed: () {
                    context
                        .read<ProfileCreationFlowCubit>()
                        .uploadImages(images: dSelectedImages);
                    context.read<ProfileCreationFlowCubit>().nextPage();
                  }),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class ImageSlot extends StatelessWidget {
  final File? image;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ImageSlot({
    super.key,
    required this.image,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: image == null ? onAdd : null,
      child: image == null
          ? Center(
              child: DashedBorder(
              color: context.appColors.darkGreyColor!.withOpacity(.4),
              dashWidth: 6.0,
              dashSpacing: 4.0,
              strokeWidth: 2.0,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 122,
                height: 122,
                color: context.appColors.darkGreyColor!.withOpacity(.1),
                padding: const EdgeInsets.all(30.0),
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: context.colors.primary.withOpacity(.2),
                  child: Icon(
                    Icons.add,
                    size: 40,
                    color: context.colors.primary,
                  ),
                ),
              ),
            ))
          : Container(
              height: 122,
              width: 122,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(image!, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.appColors.redColor,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
