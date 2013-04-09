//
//  IntroLayer.m
//  GameFeatSample_cocos2d_iphone
//
//  Created by Basic on 13/04/09.
//  Copyright (c) 2013年 Basic. All rights reserved.
//

#import "IntroLayer.h"


#define GAMEFEAT_MEDIA_ID @"メディアID" //※メディアIDは管理画面よりご確認いただけます。

#pragma mark - IntroLayer

@implementation IntroLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	IntroLayer *layer = [self node];
	[scene addChild: layer];
	return scene;
}

- (id)init{
	if((self=[super init])) {
        CGSize s = [CCDirector sharedDirector].winSize;
        
        //Set up sprite
        // 背景
        {
            CCSprite *sp;
            if([AppController isIPhone5]){
                sp = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Default-568h.png"]];
            }else{
                sp = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Default.png"]];
            }
            sp.position = ccp(s.width / 2, s.height / 2);
            [self addChild:sp];
        }
        
        {
            CCLabelTTF* l = [CCLabelTTF labelWithString:@"GAMEFEAT起動" fontName:@"Arial" fontSize:32];
            [l setColor:ccBLACK];
            CCMenuItemLabel *btn = [CCMenuItemLabel itemWithLabel:l target:self selector:@selector(onClick)];
            CCMenu *menu = [CCMenu menuWithItems: btn, nil];
            [menu setPosition:ccp(s.width / 2, s.height / 2 - 50)];
            [self addChild: menu];
        }
    }
    return self;
}

//=======================================================
// ボタンイベント
//=======================================================
-(void)onClick{
    NSLog(@"click");
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [GFController showGF:[CCDirector sharedDirector] site_id:GAMEFEAT_MEDIA_ID delegate:delegate];
}
@end
