//
//  GameData.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject
@property int highScore;

@property int highScoreColombia;
@property int highScoreArabia;
@property int highScoreGermany;
@property int highScoreKoreia;
@property int highScoreChina;

@property(nonatomic) NSString* stage;
@property(nonatomic) NSString* email;
+(id)data;
-(void)save;
-(void)load;
-(void)resetScore;
@end
