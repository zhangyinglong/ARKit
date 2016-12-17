# ARKit说明文档

------------

## 说明

ARKit是一个基于第三方视觉增强引擎easyar.framework封装的AR框架，提供了一些基本的AR操作，以及一些消息回调通知。

## 使用方法

引入头文件

```ruby
#import <CHRARKit/ARKit.h>
```

API接口如下：

```objective-c
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
 *  删除缓存图片
 *
 *  @param url 所识别图片的url
 */
+ (void)removeImageName:(NSString *)url;

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
 *  @param name   所识别图片名(全路径)
 *  @param target AR目标
 *  @param type   视频类型
 */
- (void)loadName:(NSString *)name target:(NSString *)target type:(VideoType)type;

/**
 *  从url添加AR目标
 *
 *  @param url    所识别图片的url
 *  @param target AR目标
 *  @param type   视频类型
 */
- (void)loadURL:(NSString *)url target:(NSString *)target type:(VideoType)type;

/**
 *  启动AR
 *
 */
- (void)start;

/**
 *  停止AR
 */
- (void)stop;

/**
 *  拍照截图
 *
 *  @param waterMark 水印拼图
 *  @param completion 返回截图内容
 */
- (void)snapshot:(UIImage *)waterMark completion:(void(^)(UIImage *image))completion;
```

