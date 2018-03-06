//
//  GameScene.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"

@interface GameScene : SKScene<SKPhysicsContactDelegate>
@property (nonatomic, strong) NSString *stage;
@end
