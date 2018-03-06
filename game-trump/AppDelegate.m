//
//  AppDelegate.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "AppDelegate.h"
#import <SpriteKit/SpriteKit.h>
#import "Person+CoreDataClass.h"
#import "HighScoreModel+CoreDataClass.h"
#import "Person+CoreDataProperties.h"
@import Firebase;

@interface AppDelegate ()
@property (nonatomic) NSManagedObjectContext *context;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.context = self.persistentContainer.viewContext;
    
    [FIRApp configure];
    
    //[self createData];
    [self basicFetch];
    //[self fetchWithSort];
    //[self fetchWithFilter];
    //[self updatePersons];
    //[self deletePerson];
    return YES;
}

-(void)createDataEmail:(NSString*)email{
    
//    Person *p1 = [[Person alloc]initWithContext:self.context];
//    p1.firstName = @"Fred";
//    p1.lastName = @"Flintstone";
//    p1.age = 80;
    
    HighScoreModel* highScore = [[HighScoreModel alloc] initWithContext:self.context];
    highScore.email = email;
    
//    Person *p2 = [[Person alloc]initWithContext:self.context];
//    p2.firstName = @"Monica";
//    p2.lastName = @"Soares";
//    p2.age = 34;
//
//    Person *p3 = [[Person alloc]initWithContext:self.context];
//    p3.firstName = @"Geraldo";
//    p3.lastName = @"Mendonça";
//    p3.age = 56;
    
    [self saveContext];
}

-(void)saveDataScore:(NSString*)email{
    
    //    Person *p1 = [[Person alloc]initWithContext:self.context];
    //    p1.firstName = @"Fred";
    //    p1.lastName = @"Flintstone";
    //    p1.age = 80;
    
    HighScoreModel* highScore = [[HighScoreModel alloc] initWithContext:self.context];
    highScore.email = email;
    
    //    Person *p2 = [[Person alloc]initWithContext:self.context];
    //    p2.firstName = @"Monica";
    //    p2.lastName = @"Soares";
    //    p2.age = 34;
    //
    //    Person *p3 = [[Person alloc]initWithContext:self.context];
    //    p3.firstName = @"Geraldo";
    //    p3.lastName = @"Mendonça";
    //    p3.age = 56;
    
    [self saveContext];
}

/*
-(NSArray *)executeFetchRequest:(NSFetchRequest *)request error:(NSError *_Nullable *)error;
*/

-(void)basicFetch{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
//    NSArray <Person*>* persons = [self.context executeFetchRequest:request error:nil];
//    [self printResultsFromArray:persons];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HighScoreModel"];
    NSArray <HighScoreModel*>* highScores = [self.context executeFetchRequest:request error:nil];
    [self printResultsFromArrayScore:highScores];

}
-(void)fetchWithSort{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
//    NSSortDescriptor *ageDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:NO];
//    request.sortDescriptors = @[ageDescriptor];
//    NSArray <Person *>*results = [self.context executeFetchRequest:request error:nil];
//    [self printResultsFromArray:results];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HighScoreModel"];
    NSSortDescriptor *emailDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"email" ascending:NO];
    request.sortDescriptors = @[emailDescriptor];
    NSArray <HighScoreModel *>*results = [self.context executeFetchRequest:request error:nil];
    [self printResultsFromArrayScore:results];
}
-(NSArray <HighScoreModel *>*)fetchWithFilterEmail:(NSString *)email{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age >= 56"];
//    request.predicate = predicate;
//    NSArray<Person*>* persons = [self.context executeFetchRequest:request error:nil];
//    [self printResultsFromArray:persons];
//    return persons;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HighScoreModel"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@", email];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@", email];isEqualToString:@"SegueToSecondViewController"
    request.predicate = predicate;
    NSArray<HighScoreModel*>* highScores = [self.context executeFetchRequest:request error:nil];
    [self printResultsFromArrayScore:highScores];
    return highScores;
}

-(NSArray <HighScoreModel *>*)fetchWithFilterEmailStage:(NSString *)email stage:(NSString*)stage{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HighScoreModel"];
    NSPredicate *predicateEmail = [NSPredicate predicateWithFormat:@"email == %@", email];
    NSPredicate *predicateStage = [NSPredicate predicateWithFormat:@"email == %@", stage];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@", email];isEqualToString:@"SegueToSecondViewController"
    request.predicate = predicateEmail;
    request.predicate = predicateStage;
    NSArray<HighScoreModel*>* highScores = [self.context executeFetchRequest:request error:nil];
    [self printResultsFromArrayScore:highScores];
    return highScores;
}

//-(void)updatePersons{
//    Person* fred = [self fetchWithFilter][0];
//    fred.age = 81;
//    [self saveContext];
//}

//-(void)updateHighScore:(NSString*)email{
//    HighScore* highScore = [self fetchWithFilterEmail:email][0];
//    highScore.score = [NSNumber numberWithInt:81];
//    [self saveContext];
//}

//-(void)deletePerson{
//    Person *fred = [self fetchWithFilter][0];
//    [self.context deleteObject:fred];
//    [self saveContext];
//}

//-(void)deleteHighScore:(NSString*)email{
//    HighScore *highScore = [self fetchWithFilterEmail:email][0];
//    [self.context deleteObject:highScore];
//    [self saveContext];
//}

//-(void)printResultsFromArray:(NSArray <Person *>*)persons{
//    for (Person *person in persons) {
//        NSLog(@"%@ %@ is %@ years old.", person.firstName,person.lastName,@(person.age));
//    }
//}

-(void)printResultsFromArrayScore:(NSArray <HighScoreModel *>*)hss{
    for (HighScoreModel *hs in hss) {
        NSLog(@"Email: %@ Score: %d Stage: %@ ", hs.email,hs.score,hs.stage);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    SKView* view = (SKView*)self.window.rootViewController.view;
    view.paused = YES;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    SKView* view = (SKView*)self.window.rootViewController.view;
    view.paused = NO;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

#pragma mark - Core Data stack
- (void)applicationWillTerminate:(UIApplication *)application {
     [self saveContext];
}
#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"game-trump"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


@end
