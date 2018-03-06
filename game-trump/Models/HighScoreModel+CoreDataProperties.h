//
//  HighScoreModel+CoreDataProperties.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 30/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//
//

#import "HighScoreModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HighScoreModel (CoreDataProperties)

+ (NSFetchRequest<HighScoreModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nonatomic) int32_t score;
@property (nullable, nonatomic, copy) NSString *stage;

@end

NS_ASSUME_NONNULL_END
