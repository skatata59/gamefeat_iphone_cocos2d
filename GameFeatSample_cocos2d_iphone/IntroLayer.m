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
            CCLabelTTF* l = [CCLabelTTF labelWithString:@"GAMEFEAT起動" fontName:@"Arial" fontSize:20];
            [l setColor:ccBLACK];
            CCMenuItemLabel *btn = [CCMenuItemLabel itemWithLabel:l target:self selector:@selector(onGameFeatClick)];
            CCMenu *menu = [CCMenu menuWithItems: btn, nil];
            [menu setPosition:ccp(s.width / 2, s.height / 2 - 25)];
            [self addChild: menu];
        }
        {
            CCLabelTTF* l = [CCLabelTTF labelWithString:@"全画面型表示" fontName:@"Arial" fontSize:20];
            [l setColor:ccBLACK];
            CCMenuItemLabel *btn = [CCMenuItemLabel itemWithLabel:l target:self selector:@selector(onWallClick)];
            CCMenu *menu = [CCMenu menuWithItems: btn, nil];
            [menu setPosition:ccp(s.width / 2, s.height / 2 - 50)];
            [self addChild: menu];
        }
        
        //アイコン型広告の表示処理
        CCDirectorIOS *_director = (CCDirectorIOS*) [CCDirector sharedDirector];
        
        // GFIconControllerの初期化
        gfIconController = [[GFIconController alloc] init];
        
        // アイコンの自動更新間隔を指定（デフォルトで30秒／最短10秒）
        [gfIconController setRefreshTiming:10];
        
        // GFIconControllerの初期化
        gfIconController = [[GFIconController alloc] init];
        
        // アイコンの自動更新間隔を指定（デフォルトで30秒／最短10秒）
        [gfIconController setRefreshTiming:10];
        
        // アイコンの配置位置を設定（1個〜20個まで設置出来ます）
        {
            GFIconView *iconView = [[[GFIconView alloc] initWithFrame:CGRectMake(10, 380, 60, 60)] autorelease];
            [gfIconController addIconView:iconView];
            [_director.view addSubview:iconView];
        }
        {
            GFIconView *iconView = [[[GFIconView alloc] initWithFrame:CGRectMake(96, 380, 60, 60)] autorelease];
            [gfIconController addIconView:iconView];
            [_director.view addSubview:iconView];
        }
        {
            GFIconView *iconView = [[[GFIconView alloc] initWithFrame:CGRectMake(174, 380, 60, 60)] autorelease];
            [gfIconController addIconView:iconView];
            [_director.view addSubview:iconView];
        }
        {
            GFIconView *iconView = [[[GFIconView alloc] initWithFrame:CGRectMake(252, 380, 60, 60)] autorelease];
            [gfIconController addIconView:iconView];
            [_director.view addSubview:iconView];
        }
        
    }
    return self;
}


//=======================================================
// ビュー描画完了時にアイコン型広告を描画する
//=======================================================
-(void) onEnter{
    [super onEnter];
    [gfIconController loadAd:GAMEFEAT_MEDIA_ID];
}

-(void) onExit{
    [super onExit];
}

//=======================================================
// 全画面型ボタンイベント
//=======================================================
-(void)onWallClick{
    NSLog(@"onWallClick");
    
    CCDirectorIOS *_director = (CCDirectorIOS*) [CCDirector sharedDirector];
    
    // 全画面広告を初期化
    GFPopupView *popupView = [[GFPopupView alloc] init];
    
    // n回に1回表示するタイミング設定（1にすると毎回表示されます）
    [popupView setSchedule:1];
    
    // 全画面広告の表示アニメーションを無効にします（デフォルトはアニメーション有効 = YES）
    //[popupView setAnimation:NO];
    
    // 全画面広告の表示
    if ([popupView loadAd:GAMEFEAT_MEDIA_ID]) {
        [_director.view addSubview:popupView];
    }
}

//=======================================================
// ボタンイベント
//=======================================================
-(void)onGameFeatClick{
    NSLog(@"onGameFeatClick");
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [GFController showGF:[CCDirector sharedDirector] site_id:GAMEFEAT_MEDIA_ID delegate:delegate];
}
@end
