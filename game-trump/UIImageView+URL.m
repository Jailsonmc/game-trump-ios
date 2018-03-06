//
//  UIImageView+URL.m
//  fakeMato
//
//  Created by Jailson Cavalcanti on 25/11/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "UIImageView+URL.h"

@implementation UIImageView(URL)

-(void)setImageWithString:(NSString*)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self parseData:data];
    }];
    [task resume];
}
-(void)parseData:(NSData*)data{
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.image = [UIImage imageWithData:data];
    });
}
@end
