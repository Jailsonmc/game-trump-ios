#import <Foundation/Foundation.h>

@interface HighScore : NSObject

-(instancetype)init:(NSString*)email score:(NSNumber*)score stage:(NSString*)stage;

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) NSString *stage;
@end
