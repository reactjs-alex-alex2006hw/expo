// Copyright 2016-present 650 Industries. All rights reserved.

#import "ABI17_0_0EXAudioRecordingPermissionRequester.h"
#import <ReactABI17_0_0/ABI17_0_0RCTUtils.h>

#import <AVFoundation/AVFoundation.h>

@interface ABI17_0_0EXAudioRecordingPermissionRequester ()

@property (nonatomic, weak) id<ABI17_0_0EXPermissionRequesterDelegate> delegate;

@end

@implementation ABI17_0_0EXAudioRecordingPermissionRequester

+ (NSDictionary *)permissions
{
  AVAudioSessionRecordPermission systemStatus;
  ABI17_0_0EXPermissionStatus status;

  NSString *microphoneUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSMicrophoneUsageDescription"];
  if (!microphoneUsageDescription) {
    ABI17_0_0RCTFatal(ABI17_0_0RCTErrorWithMessage(@"This app is missing NSMicrophoneUsageDescription, so audio services will fail. Add one of these keys to your bundle's Info.plist."));
    systemStatus = AVAudioSessionRecordPermissionDenied;
  } else {
    systemStatus = [[AVAudioSession sharedInstance] recordPermission];
  }
  switch (systemStatus) {
    case AVAudioSessionRecordPermissionGranted:
      status = ABI17_0_0EXPermissionStatusGranted;
      break;
    case AVAudioSessionRecordPermissionDenied:
      status = ABI17_0_0EXPermissionStatusDenied;
      break;
    case AVAudioSessionRecordPermissionUndetermined:
      status = ABI17_0_0EXPermissionStatusUndetermined;
      break;
  }

  return @{
    @"status": [ABI17_0_0EXPermissions permissionStringForStatus:status],
    @"expires": ABI17_0_0EXPermissionExpiresNever,
  };
}

- (void)requestPermissionsWithResolver:(ABI17_0_0RCTPromiseResolveBlock)resolve rejecter:(ABI17_0_0RCTPromiseRejectBlock)reject
{
  [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
    resolve([[self class] permissions]);
    if (_delegate) {
      [_delegate permissionRequesterDidFinish:self];
    }
  }];
}

- (void)setDelegate:(id<ABI17_0_0EXPermissionRequesterDelegate>)delegate
{
  _delegate = delegate;
}

@end
