import 'package:awesome/bloc/PhotoBloc.dart';
import 'package:awesome/component/CommonLoadingWidget.dart';
import 'package:awesome/component/SABT.dart';
import 'package:awesome/model/LoadApiStatus.dart';
import 'package:awesome/model/response/BaseResponse.dart';
import 'package:awesome/model/response/PhotoResponse.dart';
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
  String page = "1";
  String rowsPage = "10";

  @override
  void initState() {
    photoBloc.doGetPhotos(page, rowsPage);
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
            child: StreamBuilder(
                stream: photoBloc.getPhotoSubject,
                builder: (context,
                    AsyncSnapshot<BaseResponse<PhotoResponse>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.loadStatus == LoadApiStatus.LOADING) {
                      return CommonLoadingWidget();
                    } else if (snapshot.data!.loadStatus ==
                        LoadApiStatus.COMPLETED) {
                      return _isGridMode
                          ? _picturesGridWidget(
                              defaultSize, snapshot.data!.photos!)
                          : _picturesListWidget(
                              defaultSize, snapshot.data!.photos!);
                    } else if (snapshot.data!.loadStatus ==
                        LoadApiStatus.ERROR) {
                      return Container(
                        height: defaultSize * 20,
                      );
                    } else {
                      return Container(height: defaultSize * 20);
                    }
                  } else {
                    return Container(height: defaultSize * 20);
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget _picturesGridWidget(
      double defaultSize, List<PhotoResponse> photosData) {
    final double _itemHeight = defaultSize * 17;
    final double _itemWidth = SizeUtil.screenWidth! / 2;
    return GridView.builder(
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
          onTap: () {},
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
    );
  }

  Widget _picturesListWidget(
      double defaultSize, List<PhotoResponse> photosData) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: photosData.length,
        itemBuilder: (context, index) {
          var _photoData = photosData[index];
          return GestureDetector(
            onTap: () {},
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
        });
  }
}
