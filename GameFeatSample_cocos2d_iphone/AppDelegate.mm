//
//  AppDelegate.m
//  GameFeatSample_cocos2d_iphone
//
//  Created by Basic on 13/04/09.
//  Copyright (c) 2013年 Basic. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "IntroLayer.h"

@implementation AppController

@synthesize window=_window, director = _director;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Create the main window
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _director = (CCDirectorIOS*) [CCDirector sharedDirector];
    CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
    [sharedFileUtils setEnableFallbackSuffixes:NO];
    [sharedFileUtils setiPhoneRetinaDisplaySuffix:@"@2x"];
    
    CCGLView *glView = [CCGLView viewWithFrame:CGRectMake(0, 0, 320, 480 + ([AppController isIPhone5] ? 88 : 0))
                                   pixelFormat:kEAGLColorFormatRGB565
                                   depthFormat:0
                            preserveBackbuffer:NO
                                    sharegroup:nil
                                 multiSampling:NO
                               numberOfSamples:0];
    _director.wantsFullScreenLayout = YES;
    [_director setDisplayStats:YES];
    [_director setAnimationInterval:1.0/60];
    [_director setView:glView];
    [_director setDelegate:self];
    [_director setProjection:kCCDirectorProjection2D];
    if(![_director enableRetinaDisplay:YES] ){
        CCLOG(@"Retina Display Not supported");
    }
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    
    [_director pushScene:[IntroLayer scene]];
    
    [self.window addSubview:_director.view];
	[_window makeKeyAndVisible];
	
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
    [_director pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
    [_director resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
    [_director stopAnimation];
    // アプリがバックグランド実行へ遷移した際にコンバージョン定期送信を実行します。
    UIDevice *device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ([device respondsToSelector:@selector(isMultitaskingSupported)]) {
        backgroundSupported = device.multitaskingSupported;
    }
    if (backgroundSupported) {
        [GFController backgroundTask];
    }

}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
    [_director startAnimation];
    [GFController conversionCheckStop];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) dealloc
{
	[window release];
	[super dealloc];
}

+ (BOOL)isIPhone5{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return NO;
    }
    else {
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
        if (frame.size.height > 480.0) {
            return YES;
        }
        else {
            return NO;
        }
    }
}

//=======================================================
// GFViewDelegate
//=======================================================
- (void)didShowGameFeat{
    // GameFeatが表示されたタイミングで呼び出されるdelegateメソッド
    NSLog(@"didShowGameFeat");
}
- (void)didCloseGameFeat{
    // GameFeatが閉じられたタイミングで呼び出されるdelegateメソッド
    NSLog(@"didCloseGameFeat");
}

@end

