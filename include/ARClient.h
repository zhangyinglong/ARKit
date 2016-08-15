//
//  ARClient.h
//  ARKit
//
//  Created by zhangyinglong on 16/8/14.
//  Copyright © 2016年 ChinaHR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OpenGLView;

/**
 *  视频类型
 */
typedef NS_ENUM(NSInteger, VideoType) {
    /**
     *  普通视频
     */
    kVideoTypeNormal = 0,
    /**
     *  透视视频
     */
    kVideoTypeSideBySide,
    /**
     *  流媒体视频
     */
    kVideoTypeStream
};

@interface ARClient : NSObject

/**
 *  版本号
 *
 */
+ (NSString *)version;

/**
 *  默认关闭调试信息
 */
+ (void)enableDebug;

/**
 *  AR视图
 */
@property (nonatomic, readonly) OpenGLView *glView;

/*
 * Steps to create the key for this sample:
 *  1. login www.easyar.com
 *  2. create app with
 *      Name: HelloARVideo
 *      Bundle ID: cn.easyar.samples.helloarvideo
 *  3. find the created item in the list and show key
 *  4. set key string bellow
 */
- (instancetype)initWithARKey:(NSString *)key;

/**
 *  重置AR视图区域
 *
 *  @param frame       区域
 *  @param orientation 屏幕方向
 */
- (void)resize:(CGRect)frame orientation:(UIInterfaceOrientation)orientation;

/**
 *  设置视图方向
 *
 *  @param orientation 屏幕方向
 */
- (void)setOrientation:(UIInterfaceOrientation)orientation;

/**
 *  添加AR目标
 *
 *  @param name   所识别图片名
 *  @param target AR目标
 */
- (void)loadName:(NSString *)name target:(NSString *)target type:(VideoType)type;

/**
 *  从json配置文件加载识别的平面图像
 *
 *  @param jsonFile json配置文件
 */
- (void)loadAllTargetsFromJsonFile:(NSString *)jsonFile;

/**
 *  启动AR
 *
 */
- (void)start;

/**
 *  停止AR
 */
- (void)stop;

@end
