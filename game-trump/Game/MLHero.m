//
//  MLHero.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "MLHero.h"

@interface MLHero()
@property BOOL isJumping;
@property BOOL isJumping2;
@property NSInteger jumpDouble;
@end

@implementation MLHero

static const uint32_t heroCategory = 0x1 << 0;
static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;

+(id)hero{
    MLHero *hero = [MLHero spriteNodeWithColor:[UIColor colorWithRed:0.93 green:0.88 blue:0.57 alpha:1.0] size:CGSizeMake(40, 40)];
    
    //SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"ground"];
    
    SKSpriteNode *hair = [SKSpriteNode spriteNodeWithImageNamed:@"hair"];
    hair.size = CGSizeMake(70, 70);
    [hero addChild:hair];
    hair.position = CGPointMake(-5, 16);
    
    SKSpriteNode *leftEye = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(2, 7)];
    [hero addChild:leftEye];
    leftEye.position = CGPointMake(-3, 8);
    
    SKSpriteNode *rightEye = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(2, 7)];
    [hero addChild:rightEye];
    rightEye.position = CGPointMake(13, 8);
    
    hero.name = @"hero";
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];
    hero.physicsBody.categoryBitMask = heroCategory;
    hero.physicsBody.contactTestBitMask = obstacleCategory | groundCategory;
    
    return hero;
}
//-(void)walkRight{
//    SKAction *incrementRight = [SKAction moveByX:10 y:0 duration:0];
//    [self runAction:incrementRight];
//}

-(void)jump{
    if(self.jumpDouble < 2){
        if(self.jumpDouble == 0){
            [self.physicsBody applyImpulse:CGVectorMake(0, 40)];
        }else if(self.jumpDouble == 1){
            [self.physicsBody applyImpulse:CGVectorMake(0, 30)];
        }
        self.jumpDouble = self.jumpDouble + 1;
        [self runAction:[SKAction playSoundFileNamed:@"retro_game_jump.mp3" waitForCompletion:NO]];
    }
}
-(void)land{
    self.jumpDouble = 0;
}
-(void)start{
    SKAction *incrementRight = [SKAction moveByX:1.0 y:0 duration:0.004];
    SKAction *moveRight = [SKAction repeatActionForever:incrementRight];
    [self runAction:moveRight];
}
-(void)stop{
    [self removeAllActions];
}
@end
