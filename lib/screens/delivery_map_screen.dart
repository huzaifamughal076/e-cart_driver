import 'dart:async';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecart_driver/screens/order_success_screen.dart';
import 'package:ecart_driver/screens/orders_screen.dart';
import 'package:ecart_driver/screens/success_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/widgets/order_item.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  final Completer<GoogleMapController> _controller = Completer();
  final HelpingMethods helpingMethods = HelpingMethods();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.6036535, -0.2097939),
    zoom: 19.151926040649414,
  );
  final List<Marker> _markers = <Marker>[];
  final List<Polyline> _polylines = <Polyline>[];
  bool isMultiOrder = true;

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    searchController.text = "#5 Suite, Trincity Industrial Esta";
    getImages("images/loc_pin.png", 100).then((markIcons) {
      _markers.add(Marker(
        markerId: const MarkerId("id"),
        icon: BitmapDescriptor.fromBytes(markIcons),
        position: const LatLng(5.6036535, -0.2097939),
      ));
      setState(() {});
    });

    super.initState();
  }

  addDirPin() {
    List<LatLng> latLen = [
      const LatLng(5.6036535, -0.2097939),
      const LatLng(5.603794, -0.209921),
      const LatLng(5.603858, -0.209976),
      const LatLng(5.603794, -0.210045),
    ];
    getImages("images/dir_pin.png", 100).then((markIcons) {
      _markers.add(Marker(
        markerId: const MarkerId("iddir"),
        icon: BitmapDescriptor.fromBytes(markIcons),
        position: const LatLng(5.603794, -0.210045),
      ));
      _polylines.add(Polyline(
          polylineId: const PolylineId('1'),
          points: latLen,
          color: Colors.green.shade200,
          width: 5));
      isMultiOrder = false;
      setState(() {});
      _goToTheLake(const LatLng(5.603794, -0.210045));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottom(),
      appBar: AppBar(
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.black //change your color here
                ),
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        actions: [
          if (!isMultiOrder)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset("images/ambulance_icon.svg"),
            )
        ],
        title: Text(
          isMultiOrder ? AppConstants.yourOrders : AppConstants.onTheWay,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
            polylines: Set<Polyline>.of(_polylines),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0.0)],
                stops: const [0.5, 1],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: isMultiOrder ? buildSlider() : _delivryCard(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                    child: textField(
                  textInputAction: TextInputAction.search,
                  hintText: AppConstants.deliveryLocation,
                  controller: searchController,
                  focusNode: searchNode,
                  isCode: true,
                  isSearch: true,
                )),
                Container(
                  height: 48,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _delivryCard() => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade400,
                  backgroundImage: const NetworkImage(AppConstants.userImage),
                ),
                title: const Text(
                  "Michel Lin",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontConstants.bold),
                ),
                trailing: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Amount",
                        style: TextStyle(
                            color: Color(0xff969696),
                            fontWeight: FontWeight.w500,
                            fontFamily: FontConstants.medium)),
                    Text(
                      "\$278",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.bold),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                tileColor: const Color(0xffEAF4DF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                leading: SvgPicture.asset("images/phone_icon.svg"),
                title: const Text("Call Customer",
                    style: TextStyle(
                        color: Color(0xff1B7575),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: FontConstants.bold)),
                subtitle: const Text("+92 4238903-237",
                    style: TextStyle(
                        color: Color(0xff1B7575),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontConstants.bold)),
              ),
            )
          ],
        ),
      );

  Future<void> _goToTheLake(latlng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latlng, zoom: 19.151926040649414)));
  }

  CarouselSlider buildSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 240.0,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInOut,
        enableInfiniteScroll: false,
        viewportFraction: 0.75,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: List.generate(3, (index) => orderItem(index)),
    );
  }

  Container _buildBottom() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (isMultiOrder) {
            addDirPin();
          } else {
            _replyBottomSheet();
          }
        },
        child: Text(
          isMultiOrder ? AppConstants.startDelivery : AppConstants.arrived,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: FontConstants.medium,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  TextEditingController replyController = TextEditingController();
  FocusNode replyNode = FocusNode();

  _replyBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          AppConstants.askDelivery,
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff1B7575),
                              fontWeight: FontWeight.bold,
                              fontFamily: FontConstants.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    const SizedBox(height: 16),
                    textField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      hintText: AppConstants.codeHint,
                      controller: replyController,
                      focusNode: replyNode,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const OrderSuccessScreen()))
                            .then((value) {
                          isMultiOrder = true;
                          setState(() {});
                        });
                      },
                      child: const Text(
                        AppConstants.done,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontConstants.medium),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
