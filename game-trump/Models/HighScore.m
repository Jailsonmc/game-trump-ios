#import "HighScore.h"

@implementation HighScore
-(instancetype)init:(NSString*)email score:(NSNumber*)score stage:(NSString*)stage {
    self = [super init];

    self.email = email;
    self.score = score;
    self.stage = stage;

    return self;
    
}

@end
