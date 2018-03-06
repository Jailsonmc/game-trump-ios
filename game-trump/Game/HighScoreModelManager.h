#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "HighScore.h"

@interface HighScoreModelManager : NSObject
-(instancetype)initWithContext:(NSManagedObjectContext*)context;
-(NSArray*)fetch;
-(void)insertWithEmail:(NSString*)email score:(NSString*)score stage:(NSString*)stage;
-(NSArray <HighScore *>*)fetchWithFilter:(NSString*)email stage:(NSString*)stage;
@end
