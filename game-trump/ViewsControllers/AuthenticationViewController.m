//
//  AuthenticationViewController.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 29/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "GameData.h"
#import "Person+CoreDataClass.h"
#import "AppDelegate.h"
#import "HighScoreModel+CoreDataClass.h"

#import "StagesTableViewController.h"

@interface AuthenticationViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *signInSelector;
@property (weak, nonatomic) IBOutlet UILabel *signInLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (nonatomic) Boolean isSignIn;
@property(strong, nonatomic)FIRAuth *authUI;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSignIn = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)signInSelectionChanged:(UISegmentedControl *)sender {
    
    self.isSignIn = !self.isSignIn;
    if(self.isSignIn){
        self.signInLabel.text = @"Sign in";
        [self.signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
    }else{
        self.signInLabel.text = @"Register";
        [self.signInButton setTitle:@"Register" forState:UIControlStateNormal];
    }
    
}
- (IBAction)signInButtonTapped:(UIButton *)sender {
    
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    if(email && password){
        if(self.isSignIn){
            [[FIRAuth auth] signInWithEmail:email password:password completion:^(FIRUser *user, NSError *error){
                if (error != nil) {
                    //NSLog(@"Occur a error! %@", error);
                    self.noticeLabel.text = @"Email or password invalid.";
                } else {
                    
//                    if (![self.delegate fetchWithFilter:(NSString *)email]){
//                        [self.delegate createDataEmail:email];
//                        [self.delegate saveContext];
//                    }
                    
//                    StagesTableViewController *stagesTableViewControllerVC = segue.destinationViewController;
//                    //NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
//                    stagesTableViewControllerVC.eamil = email;
                    
                    [self performSegueWithIdentifier:@"goToSignIn" sender:self];
                    
                }
            }];
        }else{
            [[FIRAuth auth] createUserWithEmail:email password:password completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
//                NSLog(@"The user: %@",user);
//                NSLog(@"The id: %@",user.uid);
                if (error != nil) {
                    // There was an error creating the account
                    self.noticeLabel.text = @"There was an error signing up for email.";
                    //NSLog(@"Occur a error! %@", error);
                } else {
                    // We created a new user account
                    //NSLog(@"It is was created something!!");
                    
//                    HighScoreModel *hs = [[HighScoreModel alloc] initWithContext:self.context];
//                    hs.email = email;
                    
//                    [self.delegate createDataEmail:email];
//                    [self.delegate saveContext];
                    
                    [self performSegueWithIdentifier:@"goToSignIn" sender:self];
                }
                
            }];
        }
    }
    

    
}

//- (BOOL)validateEmailWithString:(NSString*)email{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
//}

@end
