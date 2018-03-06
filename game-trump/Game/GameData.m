//
//  GameData.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "GameData.h"

@interface GameData ()
@property NSString* filePath;
@end

@implementation GameData
+(id)data{
    GameData* data = [GameData new];
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"archive.data";
    data.filePath = [path stringByAppendingString:fileName];
    return data;
}
-(void)save{
    NSNumber* highScoreObject = [NSNumber numberWithInteger:self.highScore];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:highScoreObject];
    [data writeToFile:self.filePath atomically:YES];
}
-(void)load{
    NSData* data = [NSData dataWithContentsOfFile:self.filePath];
    NSNumber* highScoreObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.highScore = highScoreObject.intValue;
    self.highScoreColombia = highScoreObject.intValue;
    self.highScoreArabia = highScoreObject.intValue;
    self.highScoreGermany = highScoreObject.intValue;
    self.highScoreKoreia = highScoreObject.intValue;
    self.highScoreChina = highScoreObject.intValue;
}
-(void)resetScore{
    NSNumber* highScoreObject = [NSNumber numberWithInteger:0];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:highScoreObject];
    [data writeToFile:self.filePath atomically:YES];
}
@end
