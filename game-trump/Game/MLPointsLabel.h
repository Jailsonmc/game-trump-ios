//
//  MLPointsLabel.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MLPointsLabel : SKLabelNode
@property int number;

+(id)pointsLabelWithFontNamed:(NSString*)fontName;
-(void)increment;
-(void)setPoints:(int)points;
-(void)reset;
@end
