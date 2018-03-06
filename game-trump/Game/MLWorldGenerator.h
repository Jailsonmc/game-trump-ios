//
//  MLWorldGenerator.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MLWorldGenerator : SKNode
+ (id)generatorWithWorld:(SKNode*)world;
-(void)populate:(NSString *)stage;
-(void)generate:(NSString *)stage;
@end
