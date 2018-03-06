//
//  MLPointsLabel.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "MLPointsLabel.h"

@implementation MLPointsLabel

+(id)pointsLabelWithFontNamed:(NSString*)fontName{
    
    MLPointsLabel* pointsLabel = [MLPointsLabel labelNodeWithText:fontName];
//    pointsLabel.name = @"pointsLabel";
    pointsLabel.text = @"0";
    pointsLabel.number = 0;
    return pointsLabel;
    
}

-(void)increment{
    self.number++;
    self.text = [NSString stringWithFormat:@"%i", self.number];
}

-(void)setPoints:(int)points{
    self.number = points;
    self.text = [NSString stringWithFormat:@"%i", self.number];
}

-(void)reset{
    self.number = 0;
    self.text = @"0";
}

@end
