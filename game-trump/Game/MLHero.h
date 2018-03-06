//
//  MLHero.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MLHero : SKSpriteNode
+(id)hero;
//-(void)walkRight;
-(void)land;
-(void)jump;
-(void)start;
-(void)stop;
@end
