import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

class GalleryProfilePicView extends StatefulWidget {
  ///The current selected entity
  final AssetEntity? fSelectedAssetEntity;

  const GalleryProfilePicView({
    super.key,
    required this.fSelectedAssetEntity,
  });

  @override
  State<GalleryProfilePicView> createState() => _GalleryProfilePicViewState();
}

class _GalleryProfilePicViewState extends State<GalleryProfilePicView> {
  ///Current page
  int _dCurrentPage = 0;

  ///Asset path
  AssetPathEntity? _fAssetEntityPath;

  ///Stores all the assets(media files)
  List<AssetEntity>? _dAssetEntityList;

  ///Total asset count
  int _dTotalEntitiesCount = 0;

  ///If there's more asset to load
  bool _dHasMoreToLoad = true;

  ///Stores the asset
  late AssetEntity? _dSelectedAsset;

  ///If image is loading
  bool _dIsLoading = false;

  @override
  void initState() {
    super.initState();
    //Fetches all the pictures
    _fetchData();

    //Initializes the selected asset list
    _dSelectedAsset = widget.fSelectedAssetEntity;
  }

  ///Checks for permission and fetches the pictures
  void _fetchData() async {
    setState(() {
      _dIsLoading = true;
    });

    ///Checks if permission was granted
    final bool result = await context
        .read<PermissionsRepository>()
        .requestMediaStoragePermission(fOnPermanentPermissionDenial: () {
      return showDialogWithOneAction(
        context,
        title: context.loc.cameraPermissionRequired,
        subtitle: context.loc.toUseFeatureAllowAccessToCameraInSettings,
        titleTextAlign: TextAlign.start,
        subTitleTextAlign: TextAlign.start,
        trueActionText: context.loc.openAppSettings,
      );
    });
    if (result) {
      _fetchMedia();
    } else {
      setState(() {
        _dIsLoading = false;
      });
      pop();
    }
  }

  void pop() {
    Navigator.pop(context);
  }

  ///To fetch the images/photos from the user device
  void _fetchMedia() async {
    //Obtains the root album
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    //If there's no recent path
    if (albums.isEmpty) {
      setState(() {
        _dIsLoading = false;
      });
      return;
    }

    setState(() {
      _fAssetEntityPath = albums.first;
    });

    //Counts the total assets
    _dTotalEntitiesCount = await _fAssetEntityPath!.assetCountAsync;
    //Generates the media files
    List<AssetEntity> media = await _fAssetEntityPath!.getAssetListPaged(
      size: 60,
      page: 0,
    );
    setState(() {
      _dAssetEntityList = media;
      _dIsLoading = false;
      _dHasMoreToLoad = _dAssetEntityList!.length < _dTotalEntitiesCount;
    });
    return;
  }

  ///Load more assets
  void _loadMoreData() async {
    List<AssetEntity> media = await _fAssetEntityPath!.getAssetListPaged(
      size: 60,
      page: _dCurrentPage + 1,
    );
    setState(() {
      _dAssetEntityList!.addAll(media);
      _dCurrentPage++;
      _dHasMoreToLoad = _dAssetEntityList!.length < _dTotalEntitiesCount;
    });
    return;
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  /// When [assetEntity] is tapped
  void onAssetTap(AssetEntity assetEntity) {
    if (_dSelectedAsset == assetEntity) {
      _dSelectedAsset = null;
    } else {
      _dSelectedAsset = assetEntity;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        fAppBarHeight: context.scaleWithTextFactor(4, 56),
        fTitle: ListTile(
          title: Text(
            context.loc.gallery,
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            context.loc.addPhotos,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
      body: _dIsLoading == true
          ? Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(context.colors.secondary),
              ),
            )
          : (_dAssetEntityList == null || _dAssetEntityList!.isEmpty)
              ? Center(
                  child: Text(
                    context.loc.noPhotosFound,
                    style: context.textTheme.bodyMedium,
                  ),
                )
              : DeviceScreenWidget(
                  fChild: (context, deviceType) {
                    final bool isTablet =
                        deviceType == DeviceScreenTypeEnum.tablet;
                    final int rowCount = isTablet ? 4 : 3;
                    return Stack(
                      children: [
                        //Images
                        GridView.builder(
                          itemCount: _dAssetEntityList!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: rowCount,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == _dAssetEntityList!.length - 8 &&
                                _dHasMoreToLoad) {
                              _loadMoreData();
                            }
                            final AssetEntity entity =
                                _dAssetEntityList![index];
                            final int rowIndex = (index ~/ rowCount) + 1;
                            final int columnIndex = (index % rowCount) + 1;
                            return Semantics(
                              label: context.loc
                                  .imageSemantics(rowIndex, columnIndex),
                              excludeSemantics: true,
                              selected: _dSelectedAsset == entity,
                              child: GestureDetector(
                                onTap: () {
                                  onAssetTap(entity);
                                },
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: AssetEntityImage(
                                        entity,
                                        isOriginal: false,
                                        thumbnailSize:
                                            const ThumbnailSize.square(200),
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Center(
                                          child: Icon(
                                            Icons.warning,
                                            color: Colors.black38,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // If entity is selected adds a primary color overlay
                                    // above it
                                    if (_dSelectedAsset == entity)
                                      Positioned.fill(
                                        child: Container(
                                          color: context.colors.secondary
                                              .withOpacity(0.5),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        // Button
                        (_dSelectedAsset != null)
                            ? Positioned(
                                left: 0,
                                right: 0,
                                bottom: 20,
                                child: PrimaryButton.big(
                                  fEnabled: true,
                                  fOnTap: () {
                                    Navigator.pop(context, _dSelectedAsset!);
                                  },
                                  fText: context.loc.uploadText,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  },
                ),
    );
  }
}
