//
//  MainCrudViewController.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 27/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "MainCrudViewController.h"
#import "Person+CoreDataClass.h"
@import CoreData;
#import "AppDelegate.h"
#import "MainCrudViewController.h"

@interface MainCrudViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<Person*>* persons;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic, weak) AppDelegate *delegate;

@end

@implementation MainCrudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = self.delegate.persistentContainer.viewContext;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchAllPersons];
    [self.tableView reloadData];
}

-(void)fetchAllPersons{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    self.persons = [self.context executeFetchRequest:request error:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellCrud"];
    //data
    Person *person = self.persons[indexPath.row];
    cell.textLabel.text = person.lastName;
    cell.detailTextLabel.text = person.firstName;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MainCrudViewController *mcvc = segue.destinationViewController;
    mcvc.context = self.context;
    mcvc.delegate = self.delegate;
}

@end
