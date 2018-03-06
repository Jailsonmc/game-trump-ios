//
//  HighScoreModelManager.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 30/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HighScoreModelManager : NSObject
-(instancetype)initWithContext:(NSManagedObjectContext*)context;
-(NSArray*)fetch;
-(void)insertWithStage:(NSString*)stage email:(NSString*)email score:(NSInteger*)score;
@end
