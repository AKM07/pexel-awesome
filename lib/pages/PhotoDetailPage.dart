import 'package:awesome/constants/Constants.dart';
import 'package:awesome/model/response/PhotoResponse.dart';
import 'package:awesome/utils/SizeUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoDetailPage extends StatefulWidget {
  final PhotoResponse photoData;

  const PhotoDetailPage({Key? key, required this.photoData}) : super(key: key);

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  @override
  Widget build(BuildContext context) {
    SizeUtil().init(context);
    double defaultSize = SizeUtil.defaultSize!;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: defaultSize * 40,
              pinned: true,
              elevation: 0,
              title: Text(widget.photoData.photographer!,
                  style: TextStyle(
                    color: Colors.white,
                  )),
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: Image.network(
                    widget.photoData.src!.original!,
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: SafeArea(
          child: Container(
            width: SizeUtil.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Photographer Name :",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Height :",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Width :",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Color average :",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                widget.photoData.photographer!,
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  widget.photoData.height.toString(),
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.photoData.width.toString(),
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.photoData.avgColor!,
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Click for more information about photo and photographer.",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(Constants.appMainColor),
                            shape: BoxShape.circle),
                        child: GestureDetector(
                          onTap: () {
                            _launchURL(widget.photoData.url!);
                          },
                          child: Icon(
                            FeatherIcons.globe,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(Constants.appMainColor),
                            shape: BoxShape.circle),
                        child: GestureDetector(
                          onTap: () {
                            _launchURL(widget.photoData.photographerUrl!);
                          },
                          child: Icon(
                            FeatherIcons.user,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
