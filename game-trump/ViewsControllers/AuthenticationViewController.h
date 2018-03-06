//
//  AuthenticationViewController.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 29/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;
@import CoreData;
@class AppDelegate;

@interface AuthenticationViewController : UIViewController

@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic, weak) AppDelegate *delegate;

@end

