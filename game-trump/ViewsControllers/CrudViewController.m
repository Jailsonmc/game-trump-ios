//
//  CrudViewController.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 27/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "CrudViewController.h"
#import "Person+CoreDataClass.h"
#import "AppDelegate.h"

@interface CrudViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation CrudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)save:(UIBarButtonItem *)sender {
    NSString *fn = self.firstNameTextField.text;
    NSString *ln = self.lastNameTextField.text;
    int16_t age  = (int16_t)[self.ageTextField.text intValue];
    Person *person = [[Person alloc] initWithContext:self.context];
    person.firstName = fn;
    person.lastName = ln;
    person.age = age;
    [self.delegate saveContext];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
