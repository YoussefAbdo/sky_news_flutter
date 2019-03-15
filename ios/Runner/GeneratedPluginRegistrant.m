//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <firebase_admob/FirebaseAdMobPlugin.h>
#import <firebase_analytics/FirebaseAnalyticsPlugin.h>
#import <firebase_core/FirebaseCorePlugin.h>
#import <firebase_messaging/FirebaseMessagingPlugin.h>
#import <fluttertoast/FluttertoastPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTFirebaseAdMobPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAdMobPlugin"]];
  [FLTFirebaseAnalyticsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAnalyticsPlugin"]];
  [FLTFirebaseCorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseCorePlugin"]];
  [FLTFirebaseMessagingPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseMessagingPlugin"]];
  [FluttertoastPlugin registerWithRegistrar:[registry registrarForPlugin:@"FluttertoastPlugin"]];
}

@end
