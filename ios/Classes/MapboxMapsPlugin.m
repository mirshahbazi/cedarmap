#import "MapboxMapsPlugin.h"
#import <cedarmaps/cedarmaps-Swift.h>

@implementation MapboxMapsPlugin 
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMapboxGlFlutterPlugin registerWithRegistrar:registrar];
}
@end
