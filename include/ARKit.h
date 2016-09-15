//
//  ARKit.h
//  ARKit
//
//  Created by zhangyinglong on 16/8/10.
//  Copyright © 2016年 ChinaHR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __cplusplus
#define ARKIT_EXTERN            extern "C" __attribute__((visibility ("default")))
#else
#define ARKIT_EXTERN	        extern __attribute__((visibility ("default")))
#endif

ARKIT_EXTERN NSString *const QRCodePreparedNotification;
ARKIT_EXTERN NSString *const VideoPreparedNotification;
ARKIT_EXTERN NSString *const VideoWillPlayNotification;
ARKIT_EXTERN NSString *const VideoDidPlayNotification;
ARKIT_EXTERN NSString *const VideoWillPauseNotification;
ARKIT_EXTERN NSString *const VideoDidPauseNotification;
ARKIT_EXTERN NSString *const VideoCompletedNotification;
ARKIT_EXTERN NSString *const VideoErrorNotification;

#import <ARClient.h>
