//
//  Network.m
//  iHeros
//
//  Created by Jailson Cavalcanti on 28/11/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "Network.h"
#import "MD5+NSString.h"
#import "HeroesTableViewController.h"

static NSString* const kMarvelKeyPrivate = @"f8f8d219066e7a75d0ed2d7ce1428287df4989c0";
static NSString* const kMarvelKeyPublic  = @"fe5afd66d30369d4afcd76b1ef86f30e";
static NSString *const kMarvelBaseURL = @"https://gateway.marvel.com/v1/public";

@implementation Network

-(NSURLComponents*)mainComponentsForPath:(NSString*)path {
    NSURL *url = [NSURL URLWithString:kMarvelBaseURL];
    url = [url URLByAppendingPathComponent:path];
    
    //NSLog(@"%@ --ll",url);
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:YES];
    
    NSString *timeStamp = [NSString stringWithFormat:@"%1.f",[NSDate.date timeIntervalSince1970]];
    NSURLQueryItem *timeStampItem = [[NSURLQueryItem alloc] initWithName:@"ts" value:timeStamp];
    
    NSString *hash = [[NSString stringWithFormat:@"%@%@%@", timeStamp, kMarvelKeyPrivate, kMarvelKeyPublic] md5];
    NSURLQueryItem *hashItem = [[NSURLQueryItem alloc] initWithName:@"hash" value:hash];
    
    NSURLQueryItem *publicKeyItem = [[NSURLQueryItem alloc] initWithName:@"apikey" value: kMarvelKeyPublic];
    
    components.queryItems = @[timeStampItem, hashItem, publicKeyItem];
    //NSLog(@"HI -- ");
    return components;
}

-(NSURL*)fetchHeroesByQuery:(NSString*)query {
    //NSLog(@"%@ -- ",query);
    NSURLComponents *components = [self mainComponentsForPath:@"characters"];
    //NSLog(@"%@ -- ",components.URL);
    if(query != nil){
        NSURLQueryItem *queryItem = [[NSURLQueryItem alloc] initWithName:@"nameStartsWith" value:query];
        components.queryItems = [components.queryItems arrayByAddingObject:queryItem];
    }
    //NSLog(@"%@ -- ",components.string);
    return components.URL;
    
}

-(NSURL*)fetchHeroesById:(NSNumber*)id {
    //NSLog(@"%@ -- ",query);GET /v1/public/characters/{characterId}
    NSString* preComponent = [NSString stringWithFormat:@"characters/%@", id];
    NSURLComponents *components = [self mainComponentsForPath:preComponent];
    
    //NSLog(@"%@ -- ",components.URL);
//    if(id != nil){
//        NSURLQueryItem *queryItem = [[NSURLQueryItem alloc] initWithName:@"nameStartsWith" value:id];
//        components.queryItems = [components.queryItems arrayByAddingObject:queryItem];
//    }
    //NSLog(@"%@ -- ",components.string);
    return components.URL;
    
}

@end
