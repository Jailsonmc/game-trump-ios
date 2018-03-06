//
//  HighScoreModel+CoreDataProperties.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 30/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//
//

#import "HighScoreModel+CoreDataProperties.h"

@implementation HighScoreModel (CoreDataProperties)

+ (NSFetchRequest<HighScoreModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HighScoreModel"];
}

@dynamic email;
@dynamic score;
@dynamic stage;

@end
