//
//  CrudViewController.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 27/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;
@class AppDelegate;

@interface CrudViewController : UIViewController
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic, weak) AppDelegate *delegate;

@end
