//
//  IntroLayer.h
//  GameFeatSample_cocos2d_iphone
//
//  Created by Basic on 13/04/09.
//  Copyright (c) 2013年 Basic. All rights reserved.
//

#import "cocos2d.h"
#import "AppDelegate.h"
#import <GameFeatKit/GFIconController.h>
#import <GameFeatKit/GFIconView.h>

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
    GFIconController *gfIconController;
}
+(CCScene *) scene;

@end
