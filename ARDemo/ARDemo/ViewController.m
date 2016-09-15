//
//  ViewController.m
//  ARDemo
//
//  Created by zhangyinglong on 16/8/12.
//  Copyright © 2016年 ChinaHR. All rights reserved.
//

#import "ViewController.h"
#import <ARKit.h>

@interface ViewController ()

@property (nonatomic, strong) ARClient *client;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation ViewController

- (void)dealloc {
    [self unRegistNotification];
}

- (UIActivityIndicatorView *)activityView {
    if ( _activityView == nil ) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.center = self.view.center;
    }
    return _activityView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.title = @"ARDemo";
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBar.hidden = YES;

    [self setupARKit];
    [self setupCameraButton];
    [self registNotification];
}

- (void)setupARKit {
    [ARClient enableDebug];
    _client = [[ARClient alloc] initWithARKey:@""];
    
    [_client loadName:@"argame" target:@"video.mp4" type:kVideoTypeNormal];
    [_client loadName:@"namecard" target:@"http://7xj6uy.com5.z0.glb.qiniucdn.com/EsayARWebSite/video/EasyARSDKShow201520.mp4" type:kVideoTypeStream];
    [_client loadName:@"idback" target:@"transparentvideo.mp4" type:kVideoTypeSideBySide];
    
    [self.view addSubview:(UIView *)_client.glView];
    [_client setOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)registNotification {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(openURL:) name:QRCodePreparedNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(videoPrepared:) name:VideoPreparedNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(videoWillPlay:) name:VideoWillPlayNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(videoDidPlay:) name:VideoDidPlayNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(videoWillPause:) name:VideoWillPauseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(videoDidPause:) name:VideoDidPauseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(videoCompleted:) name:VideoCompletedNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(videoError:) name:VideoErrorNotification object:nil];
}

- (void)unRegistNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_client start];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_client stop];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [_client resize:self.view.bounds
        orientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [_client setOrientation:toInterfaceOrientation];
}

- (void)openURL:(NSNotification *)notification {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:notification.userInfo[@"path"]]];
}

- (void)videoPrepared:(NSNotification *)notification {
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    NSLog(@"videoPrepared %@", notification);
}

- (void)videoWillPlay:(NSNotification *)notification {
    NSLog(@"videoWillPlay %@", notification);
}

- (void)videoDidPlay:(NSNotification *)notification {
    NSLog(@"videoDidPlay %@", notification);
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
}

- (void)videoWillPause:(NSNotification *)notification {
    NSLog(@"videoWillPause %@", notification);
}

- (void)videoDidPause:(NSNotification *)notification {
    NSLog(@"videoDidPause %@", notification);
}

- (void)videoError:(NSNotification *)notification {
    NSLog(@"videoError %@", notification);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"视频播放加载失败"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)videoCompleted:(NSNotification *)notification {
    NSLog(@"videoCompleted %@", notification);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"视频播放完毕"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)setupCameraButton {
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) / 2 - 40, CGRectGetHeight(self.view.bounds) - 80, 80, 80)];
    UIImage *image = [UIImage imageNamed:@"take_photo_icon"];
    [cameraButton setImage:image forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(capturePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [cameraButton setTintColor:[UIColor blueColor]];
    [cameraButton.layer setCornerRadius:20.0];
    [self.view addSubview:cameraButton];
}

- (void)capturePhoto:(id)sender {
    [_client snapshot:[UIImage imageNamed:@"pic_ar_picmark"] completion:^(UIImage *image) {
        NSLog(@"capturePhoto image = %@", image);
    }];
}

@end
