//
//  HeroModel.h
//  iHeros
//
//  Created by Jailson Cavalcanti on 30/11/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject
-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic) NSNumber* idHero;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* heroDescription;

@end
