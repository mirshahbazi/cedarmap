part of cedarmaps;

enum MapStyle { LIGHT, DARK, LIGHT_RASTER }

class MapStyleHelper {
  static String urlPath(MapStyle style) {
    switch (style) {
      case MapStyle.LIGHT:
        return 'map/v1/styles/cedarmaps.light.json';
      case MapStyle.DARK:
        return 'map/v1/styles/cedarmaps.dark.json';
      case MapStyle.LIGHT_RASTER:
        return 'map/v1/tiles/light.json';
      default:
        return 'map/v1/styles/cedarmaps.light.json';
    }
  }

  static String backgroundHexColor(MapStyle style) {
    switch (style) {
      case MapStyle.DARK:
        return '#213945';
      default:
        return '#f4f3f0';
    }
  }
}
