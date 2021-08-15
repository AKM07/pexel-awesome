import 'package:awesome/bloc/PhotoBloc.dart';
import 'package:awesome/component/CommonLoadingWidget.dart';
import 'package:awesome/component/SABT.dart';
import 'package:awesome/constants/Constants.dart';
import 'package:awesome/model/LoadApiStatus.dart';
import 'package:awesome/model/response/BaseResponse.dart';
import 'package:awesome/model/response/PhotoResponse.dart';
import 'package:awesome/pages/PhotoDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../utils/SizeUtil.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isGridMode = true;
  int _page = 1;
  int _rowsPage = 10;
  bool _isGettingMoreData = false;
  bool _isInternetNotAvailable = false;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtil().init(context);
    double defaultSize = SizeUtil.defaultSize!;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: defaultSize * 30,
              floating: false,
              pinned: true,
              elevation: 0,
              title: SABT(
                  child: Text("Awesome App",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    icon: Icon(FeatherIcons.grid),
                    onPressed: () {
                      setState(() {
                        _isGridMode = true;
                      });
                    }),
                IconButton(
                    icon: Icon(FeatherIcons.alignJustify),
                    onPressed: () {
                      setState(() {
                        _isGridMode = false;
                      });
                    }),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: Image.asset(
                    "assets/images/slider_expand_bg.jpeg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: SafeArea(
          child: Container(
            width: SizeUtil.screenWidth,
            height: SizeUtil.screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: _isInternetNotAvailable
                ? _internetNotAvailableWidget(defaultSize)
                : _displayPhotosWidget(defaultSize),
          ),
        ),
      ),
    );
  }

  void loadInitialData() async {
    var isInternetAvailable = await Constants.checkInternetAvailability();
    if (isInternetAvailable) {
      _isInternetNotAvailable = false;
      photoBloc.doGetPhotos(_page, _rowsPage);
    } else {
      _isInternetNotAvailable = true;
    }
  }

  Future<void> refreshData() async {
    var isInternetAvailable = await Constants.checkInternetAvailability();
    if (isInternetAvailable) {
      _page = 1;
      photoBloc.doGetPhotos(_page, _rowsPage);
      setState(() {
        _isInternetNotAvailable = false;
      });
    } else {
      setState(() {
        _isInternetNotAvailable = true;
      });
    }
  }

  void loadMoreData() {
    _page++;
    photoBloc.doGetNextPhotos(_page, _rowsPage);
  }

  Widget _displayPhotosWidget(double defaultSize) {
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
          if (!_isGettingMoreData) {
            _isGettingMoreData = true;
            loadMoreData();
          }
        }
        return true;
      },
      child: StreamBuilder(
          stream: photoBloc.getPhotoSubject,
          builder:
              (context, AsyncSnapshot<BaseResponse<PhotoResponse>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.loadStatus == LoadApiStatus.LOADING) {
                return CommonLoadingWidget();
              } else if (snapshot.data!.loadStatus == LoadApiStatus.COMPLETED) {
                _isGettingMoreData = false;
                return _isGridMode
                    ? _picturesGridWidget(defaultSize, snapshot.data!.photos!)
                    : _picturesListWidget(defaultSize, snapshot.data!.photos!);
              } else if (snapshot.data!.loadStatus == LoadApiStatus.ERROR) {
                return Container(
                  child: Center(
                    child: Text("Please check your internet connection"),
                  ),
                );
              } else {
                return Container(
                  child: Center(
                    child: Text("Please check your internet connection"),
                  ),
                );
              }
            } else {
              return Container(
                child: Center(
                  child: Text("Please check your internet connection"),
                ),
              );
            }
          }),
    );
  }

  Widget _picturesGridWidget(
      double defaultSize, List<PhotoResponse> photosData) {
    final double _itemHeight = defaultSize * 17;
    final double _itemWidth = SizeUtil.screenWidth! / 2;
    return RefreshIndicator(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: photosData.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (_itemWidth / _itemHeight),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemBuilder: (context, index) {
          var _photoData = photosData[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoDetailPage(
                      photoData: _photoData,
                    ),
                  ));
            },
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      _photoData.src!.landscape!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    _photoData.photographer!,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    _photoData.width.toString() +
                        "x" +
                        _photoData.height.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      onRefresh: refreshData,
      color: Color(Constants.appMainColor),
    );
  }

  Widget _picturesListWidget(
      double defaultSize, List<PhotoResponse> photosData) {
    return RefreshIndicator(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: photosData.length,
          itemBuilder: (context, index) {
            var _photoData = photosData[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoDetailPage(
                        photoData: _photoData,
                      ),
                    ));
              },
              child: Container(
                width: SizeUtil.screenWidth,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      _photoData.src!.landscape!,
                      fit: BoxFit.cover,
                      height: defaultSize * 10,
                      width: defaultSize * 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _photoData.photographer!,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _photoData.width.toString() +
                                "x" +
                                _photoData.height.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      onRefresh: refreshData,
      color: Color(Constants.appMainColor),
    );
  }

  Widget _internetNotAvailableWidget(double defaultSize) {
    return Stack(
      children: [
        ListView(),
        Center(
          child: Text("Please check your internet connection"),
        ),
      ],
    );
  }
}
