//
//  AppDelegate.h
//  GameFeatSample_cocos2d_iphone
//
//  Created by Basic on 13/04/09.
//  Copyright (c) 2013年 Basic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import <GameFeatKit/GFPopupView.h>
#import <GameFeatKit/GFView.h>
#import <GameFeatKit/GFController.h>

@class ViewController;

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate, GFViewDelegate>
{
	UIWindow *window;
	CCDirectorIOS	*director;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) CCDirectorIOS *director;

+ (BOOL)isIPhone5;

@end
