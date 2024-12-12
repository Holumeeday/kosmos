import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/data/data.dart';
import 'package:playkosmos_v3/enums/enums.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
This class defines the gallery view to add photos and videos
@author: Ugochukwu Umeh
*/
class GalleryView extends StatefulWidget {
  ///The current selected entity
  final List<AssetEntity> fSelectedAssetEntityList;

  /// The max number of media
  final int? fMediaMaxNumber;

  /// The max number of seconds for video. Defaults to 30
  final int fVideoMaxSeconds;

  /// The request type
  final MediaPermissionEnum fRequestType;

  const GalleryView({
    super.key,
    required this.fSelectedAssetEntityList,
    this.fMediaMaxNumber,
    required this.fVideoMaxSeconds,
    required this.fRequestType,
  });

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  /// Current page
  int _dCurrentPage = 0;

  /// Asset path
  AssetPathEntity? _fAssetEntityPath;

  /// Stores all the assets(media files)
  List<AssetEntity>? _dAssetEntityList;

  /// Total asset count
  int _dTotalEntitiesCount = 0;

  /// If there's more asset to load
  bool _dHasMoreToLoad = true;

  /// Stores the list
  final List<AssetEntity> _fSelectedAssetList = [];

  /// If image is loading
  bool _dIsLoading = false;

  @override
  void initState() {
    super.initState();
    //Fetches all the pictures
    _fetchData();

    //Initializes the selected asset list
    _fSelectedAssetList.addAll(widget.fSelectedAssetEntityList);
  }

  ///Checks for permission and fetches the pictures
  void _fetchData() async {
    setState(() {
      _dIsLoading = true;
    });

    /// Checks if permission was granted
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

  /// To fetch the media
  void _fetchMedia() async {
    //Obtains the root album
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: widget.fRequestType.getRequestType(),
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

  /// To toggle selection
  void toggleSelection(AssetEntity entity) {
    if (_fSelectedAssetList.contains(entity)) {
      _fSelectedAssetList.remove(entity);
    } else {
      if (widget.fMediaMaxNumber != null) {
        if (_fSelectedAssetList.length >= widget.fMediaMaxNumber!) {
          showMaxLengthSnackbar();
        } else {
          _fSelectedAssetList.add(entity);
        }
      } else {
        _fSelectedAssetList.add(entity);
      }
    }
    setState(() {});
  }

  /// To show the max duration
  void showDurationMaxSnackbar() {
    SnackBarUtil.showDefaultTextSnackbar(
      snackbarText:
          context.loc.selectAVideoWithDuration(widget.fVideoMaxSeconds),
      snackbarMilliseconds: 1500,
    );
  }

  /// To show the max length
  void showMaxLengthSnackbar() {
    SnackBarUtil.showDefaultTextSnackbar(
      snackbarText: context.loc.maxNumberOfMediaItemsReached,
      snackbarMilliseconds: 1000,
    );
  }

  /// When no media is found
  String noMediaFoundText() {
    return switch (widget.fRequestType) {
      MediaPermissionEnum.image => context.loc.noPhotosFound,
      MediaPermissionEnum.video => context.loc.noVideosFound,
      MediaPermissionEnum.common => context.loc.noMediaFound,
    };
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
        fActions: [
          PrimaryButton(
            fOnTap: () {
              //Pops back with the list of selected assets
              Navigator.pop(
                context,
                _fSelectedAssetList,
              );
            },
            fText: context.loc.done,
            fEnabled: true,
          ),
        ],
        fAppBarHeight: context.scaleWithTextFactor(2, 56),
      ),
      body: SafeArea(
        child: _dIsLoading == true
            ? Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(context.colors.secondary),
                ),
              )
            : (_dAssetEntityList == null || _dAssetEntityList!.isEmpty)
                ? Center(
                    child: Text(
                      noMediaFoundText(),
                      style: context.textTheme.bodyMedium,
                    ),
                  )
                : DeviceScreenWidget(
                    fChild: (context, deviceType) {
                      final bool isTablet =
                          deviceType == DeviceScreenTypeEnum.tablet;
                      final int rowCount = isTablet ? 4 : 3;
                      return GridView.builder(
                        itemCount: _dAssetEntityList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: rowCount,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == _dAssetEntityList!.length - 8 &&
                              _dHasMoreToLoad) {
                            _loadMoreData();
                          }
                          final AssetEntity entity = _dAssetEntityList![index];
                          final int rowIndex = (index ~/ rowCount) + 1;
                          final int columnIndex = (index % rowCount) + 1;
                          final bool isVideo = entity.type == AssetType.video;
                          return Semantics(
                            label: isVideo
                                ? context.loc
                                    .videoSemantics(rowIndex, columnIndex)
                                : context.loc
                                    .imageSemantics(rowIndex, columnIndex),
                            excludeSemantics: true,
                            selected: _fSelectedAssetList.contains(entity),
                            child: GestureDetector(
                              onTap: () {
                                if (entity.duration > widget.fVideoMaxSeconds) {
                                  showDurationMaxSnackbar();
                                } else {
                                  toggleSelection(entity);
                                }
                              },
                              child: Stack(
                                children: [
                                  // Renders the asset, uses the thumbnail size of the
                                  // videos
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

                                  //If entity is a video adds the video cam icon at the
                                  // bottom right part of the screen
                                  if (isVideo)
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: TextWithBackground(
                                        fText:
                                            entity.duration.getVideoDuration(),
                                        fTextSize: 11,
                                        fPadding: const EdgeInsets.all(2),
                                        fBackgroundColor:
                                            context.colors.tertiary,
                                        fFontWeight: FontWeight.w600,
                                      ),
                                    ),

                                  //If entity is selected adds a primary color overlay
                                  // above it
                                  if (_fSelectedAssetList.contains(entity))
                                    Positioned.fill(
                                      child: Container(
                                        color: context.colors.secondary
                                            .withOpacity(0.5),
                                        child: Icon(
                                          Icons.check,
                                          color: context.colors.onSecondary,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
