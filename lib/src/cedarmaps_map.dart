part of cedarmaps;

typedef void MapCreatedCallback(MapboxMapController controller);
//by mirshahbazi
class CedarmapsMap extends StatefulWidget {
  const CedarmapsMap({
    @required this.initialCameraPosition,
    this.clientID,
    this.clientSecret,
    this.onMapCreated,
    this.onStyleLoadedCallback,
    this.gestureRecognizers,
    this.compassEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.style,
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.trackCameraPosition = false,
    this.myLocationEnabled = false,
    this.myLocationTrackingMode = MyLocationTrackingMode.None,
    this.myLocationRenderMode = MyLocationRenderMode.COMPASS,
    this.logoViewMargins,
    this.compassViewPosition,
    this.compassViewMargins,
    this.onMapClick,
    this.onUserLocationUpdated,
    this.onMapLongClick,
    this.onCameraTrackingDismissed,
    this.onCameraTrackingChanged,
    this.onCameraIdle,
    this.onMapIdle,
  }) : assert(initialCameraPosition != null);

  /// If you want to use Cedarmaps hosted styles and map tiles, you need to provide a Cedarmaps client ID and client Secret.
  /// Obtain your credentials on [Cedarmaps website](https://www.cedarmaps.com/).
  final String clientID;

  /// If you want to use Cedarmaps hosted styles and map tiles, you need to provide a Cedarmaps client ID and client Secret.
  /// Obtain your credentials on [Cedarmaps website](https://www.cedarmaps.com/).
  final String clientSecret;

  /// Please note: you should only add annotations (e.g. symbols or circles) after `onStyleLoadedCallback` has been called.
  final MapCreatedCallback onMapCreated;

  /// Called when the map style has been successfully loaded and the annotation managers have been enabled.
  /// Please note: you should only add annotations (e.g. symbols or circles) after this callback has been called.
  final OnStyleLoadedCallback onStyleLoadedCallback;

  /// The initial position of the map's camera.
  final CameraPosition initialCameraPosition;

  /// True if the map should show a compass when rotated.
  final bool compassEnabled;

  /// Geographical bounding box for the camera target.
  final CameraTargetBounds cameraTargetBounds;

  /// Map Style
  final MapStyle style;

  /// Preferred bounds for the camera zoom level.
  ///
  /// Actual bounds depend on map data and device.
  final MinMaxZoomPreference minMaxZoomPreference;

  /// True if the map view should respond to rotate gestures.
  final bool rotateGesturesEnabled;

  /// True if the map view should respond to scroll gestures.
  final bool scrollGesturesEnabled;

  /// True if the map view should respond to zoom gestures.
  final bool zoomGesturesEnabled;

  /// True if the map view should respond to tilt gestures.
  final bool tiltGesturesEnabled;

  /// True if you want to be notified of map camera movements by the MapboxMapController. Default is false.
  ///
  /// If this is set to true and the user pans/zooms/rotates the map, MapboxMapController (which is a ChangeNotifier)
  /// will notify it's listeners and you can then get the new MapboxMapController.cameraPosition.
  final bool trackCameraPosition;

  /// True if a "My Location" layer should be shown on the map.
  ///
  /// This layer includes a location indicator at the current device location,
  /// as well as a My Location button.
  /// * The indicator is a small blue dot if the device is stationary, or a
  /// chevron if the device is moving.
  /// * The My Location button animates to focus on the user's current location
  /// if the user's location is currently known.
  ///
  /// Enabling this feature requires adding location permissions to both native
  /// platforms of your app.
  /// * On Android add either
  /// `<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />`
  /// or `<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />`
  /// to your `AndroidManifest.xml` file. `ACCESS_COARSE_LOCATION` returns a
  /// location with an accuracy approximately equivalent to a city block, while
  /// `ACCESS_FINE_LOCATION` returns as precise a location as possible, although
  /// it consumes more battery power. You will also need to request these
  /// permissions during run-time. If they are not granted, the My Location
  /// feature will fail silently.
  /// * On iOS add a `NSLocationWhenInUseUsageDescription` key to your
  /// `Info.plist` file. This will automatically prompt the user for permissions
  /// when the map tries to turn on the My Location layer.
  final bool myLocationEnabled;

  /// The mode used to let the map's camera follow the device's physical location.
  /// `myLocationEnabled` needs to be true for values other than `MyLocationTrackingMode.None` to work.
  final MyLocationTrackingMode myLocationTrackingMode;

  /// The mode to render the user location symbol
  final MyLocationRenderMode myLocationRenderMode;

  /// Set the layout margins for the Mapbox Logo
  final Point logoViewMargins;

  /// Set the position for the Mapbox Compass
  final CompassViewPosition compassViewPosition;

  /// Set the layout margins for the Mapbox Compass
  final Point compassViewMargins;

  /// Which gestures should be consumed by the map.
  ///
  /// It is possible for other gesture recognizers to be competing with the map on pointer
  /// events, e.g if the map is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The map will claim gestures that are recognized by any of the
  /// recognizers on this list.
  ///
  /// When this set is empty or null, the map will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  final OnMapClickCallback onMapClick;
  final OnMapClickCallback onMapLongClick;

  /// While the `myLocationEnabled` property is set to `true`, this method is
  /// called whenever a new location update is received by the map view.
  final OnUserLocationUpdated onUserLocationUpdated;

  /// Called when the map's camera no longer follows the physical device location, e.g. because the user moved the map
  final OnCameraTrackingDismissedCallback onCameraTrackingDismissed;

  /// Called when the location tracking mode changes
  final OnCameraTrackingChangedCallback onCameraTrackingChanged;

  // Called when camera movement has ended.
  final OnCameraIdleCallback onCameraIdle;

  /// Called when map view is entering an idle state, and no more drawing will
  /// be necessary until new data is loaded or there is some interaction with
  /// the map.
  /// * No camera transitions are in progress
  /// * All currently requested tiles have loaded
  /// * All fade/transition animations have completed
  final OnMapIdleCallback onMapIdle;

  @override
  State createState() => _CedarmapsMapState();
}

class _CedarmapsMapState extends State<CedarmapsMap> {
  Future<String> futureAccessToken;

  final Completer<MapboxMapController> _controller =
      Completer<MapboxMapController>();

  _CedarmapsMapOptions _cedarmapsMapOptions;
  final MapboxGlPlatform _mapboxGlPlatform = MapboxGlPlatform.createInstance();

  final _initialToken = 'pk.kdsevitantcaerspamradecsisiht';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: futureAccessToken,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Map<String, dynamic> creationParams = <String, dynamic>{
            'initialCameraPosition': widget.initialCameraPosition?.toMap(),
            'options':
                _CedarmapsMapOptions.fromWidget(widget, snapshot.data).toMap(),
            'accessToken': _initialToken,
          };

          Uint8List logoBytes = base64Decode(Constants.ATTRIBUTION_LOGO);

          var logoHorizontalMargin = 8.0;
          var logoVerticalMargin = 8.0;

          if (widget.logoViewMargins != null) {
            logoHorizontalMargin += widget.logoViewMargins.x;
            logoVerticalMargin += widget.logoViewMargins.y;
          }

          return Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              _mapboxGlPlatform.buildView(creationParams, onPlatformViewCreated,
                  widget.gestureRecognizers),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: logoHorizontalMargin,
                      vertical: logoVerticalMargin),
                  child: Container()),
                  // child: Image.memory(logoBytes,
                  //     width: 85, height: 21, fit: BoxFit.fitWidth))
            ],
          );
        } else {
          String color = MapStyleHelper.backgroundHexColor(widget.style)
              .replaceAll('#', '0xff');
          return Container(color: Color(int.parse(color)));
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    futureAccessToken = Authentication().getAccessToken(widget.clientID, widget.clientSecret);
    _cedarmapsMapOptions = _CedarmapsMapOptions.fromWidget(widget, null);
  }

  @override
  void didUpdateWidget(CedarmapsMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    final _CedarmapsMapOptions newOptions =
        _CedarmapsMapOptions.fromWidget(widget, null);
    final Map<String, dynamic> updates =
        _cedarmapsMapOptions.updatesMap(newOptions);
    _updateOptions(updates);
    _cedarmapsMapOptions = newOptions;
  }

  void _updateOptions(Map<String, dynamic> updates) async {
    if (updates.isEmpty) {
      return;
    }
    final MapboxMapController controller = await _controller.future;
    controller.updateMapOptions(updates);
  }

  Future<void> onPlatformViewCreated(int id) async {
    MapboxGlPlatform.addInstance(id, _mapboxGlPlatform);
    final MapboxMapController controller = MapboxMapController.init(
        id, widget.initialCameraPosition, onStyleLoadedCallback: () {
      if (_controller.isCompleted) {
        widget.onStyleLoadedCallback();
      } else {
        _controller.future.then((_) => widget.onStyleLoadedCallback());
      }
    },
        onMapClick: widget.onMapClick,
        onUserLocationUpdated: widget.onUserLocationUpdated,
        onMapLongClick: widget.onMapLongClick,
        onCameraTrackingDismissed: widget.onCameraTrackingDismissed,
        onCameraTrackingChanged: widget.onCameraTrackingChanged,
        onCameraIdle: widget.onCameraIdle,
        onMapIdle: widget.onMapIdle);
    await MapboxMapController.initPlatform(id);
    _controller.complete(controller);
    if (widget.onMapCreated != null) {
      widget.onMapCreated(controller);
    }
  }
}

/// Configuration options for the MapboxMaps user interface.
///
/// When used to change configuration, null values will be interpreted as
/// "do not change this configuration option".
class _CedarmapsMapOptions {
  _CedarmapsMapOptions({
    this.compassEnabled,
    this.cameraTargetBounds,
    this.styleString,
    this.minMaxZoomPreference,
    this.rotateGesturesEnabled,
    this.scrollGesturesEnabled,
    this.tiltGesturesEnabled,
    this.trackCameraPosition,
    this.zoomGesturesEnabled,
    this.myLocationEnabled,
    this.myLocationTrackingMode,
    this.myLocationRenderMode,
    this.logoViewMargins,
    this.compassViewPosition,
    this.compassViewMargins,
  });

  static _CedarmapsMapOptions fromWidget(CedarmapsMap map, String accessToken) {
    return _CedarmapsMapOptions(
      compassEnabled: map.compassEnabled,
      cameraTargetBounds: map.cameraTargetBounds,
      styleString:[Constants.CEDARMAPS_BASE_URL, MapStyleHelper.urlPath(map.style)].join('/') ,
      minMaxZoomPreference: map.minMaxZoomPreference,
      rotateGesturesEnabled: map.rotateGesturesEnabled,
      scrollGesturesEnabled: map.scrollGesturesEnabled,
      tiltGesturesEnabled: map.tiltGesturesEnabled,
      trackCameraPosition: map.trackCameraPosition,
      zoomGesturesEnabled: map.zoomGesturesEnabled,
      myLocationEnabled: map.myLocationEnabled,
      myLocationTrackingMode: map.myLocationTrackingMode,
      myLocationRenderMode: map.myLocationRenderMode,
      logoViewMargins: map.logoViewMargins,
      compassViewPosition: map.compassViewPosition,
      compassViewMargins: map.compassViewMargins,
    );
  }

  final bool compassEnabled;

  final CameraTargetBounds cameraTargetBounds;

  final String styleString;

  final MinMaxZoomPreference minMaxZoomPreference;

  final bool rotateGesturesEnabled;

  final bool scrollGesturesEnabled;

  final bool tiltGesturesEnabled;

  final bool trackCameraPosition;

  final bool zoomGesturesEnabled;

  final bool myLocationEnabled;

  final MyLocationTrackingMode myLocationTrackingMode;

  final MyLocationRenderMode myLocationRenderMode;

  final Point logoViewMargins;

  final CompassViewPosition compassViewPosition;

  final Point compassViewMargins;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> optionsMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        optionsMap[fieldName] = value;
      }
    }

    List<dynamic> pointToArray(Point fieldName) {
      if (fieldName != null) {
        return <dynamic>[fieldName.x, fieldName.y];
      }

      return null;
    }

    addIfNonNull('compassEnabled', compassEnabled);
    addIfNonNull('cameraTargetBounds', cameraTargetBounds?.toJson());
    addIfNonNull('styleString', styleString);
    addIfNonNull('minMaxZoomPreference', minMaxZoomPreference?.toJson());
    addIfNonNull('rotateGesturesEnabled', rotateGesturesEnabled);
    addIfNonNull('scrollGesturesEnabled', scrollGesturesEnabled);
    addIfNonNull('tiltGesturesEnabled', tiltGesturesEnabled);
    addIfNonNull('zoomGesturesEnabled', zoomGesturesEnabled);
    addIfNonNull('trackCameraPosition', trackCameraPosition);
    addIfNonNull('myLocationEnabled', myLocationEnabled);
    addIfNonNull('myLocationTrackingMode', myLocationTrackingMode?.index);
    addIfNonNull('myLocationRenderMode', myLocationRenderMode?.index);
    addIfNonNull('logoViewMargins', pointToArray(logoViewMargins));
    addIfNonNull('compassViewPosition', compassViewPosition?.index);
    addIfNonNull('compassViewMargins', pointToArray(compassViewMargins));
    return optionsMap;
  }

  Map<String, dynamic> updatesMap(_CedarmapsMapOptions newOptions) {
    final Map<String, dynamic> prevOptionsMap = toMap();
    return newOptions.toMap()
      ..removeWhere(
          (String key, dynamic value) => prevOptionsMap[key] == value);
  }
}
