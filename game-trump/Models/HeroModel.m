//
//  HeroModel.m
//  iHeros
//
//  Created by Jailson Cavalcanti on 30/11/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    self.idHero = dictionary[@"id"];
    self.name = dictionary[@"name"];
    self.heroDescription = dictionary[@"description"];
    
    return self;
}
@end
