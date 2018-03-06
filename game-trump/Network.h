//
//  Network.h
//  iHeros
//
//  Created by Jailson Cavalcanti on 28/11/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Network : NSObject
//static NSString *const kMarvelBaseUrl = @"https://gateway.marvel.com:443";
-(NSURL*)fetchHeroesByQuery:(NSString*)query;
-(NSURL*)fetchHeroesById:(NSNumber*)id;
@end
