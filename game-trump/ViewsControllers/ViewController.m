//
//  ViewController.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 26/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray* imageNameArray;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self arraySetup];
}

-(void)arraySetup{
    imageNameArray = [NSMutableArray arrayWithArray:@[@"colombia",@"arabia",@"germany",@"koreia",@"china"]];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return imageNameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.imageView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
    cell.textLabel.text = imageNameArray[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
    
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.layer.borderWidth = 2;
    cell.contentView.layer.borderColor = [UIColor blackColor].CGColor;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [imageNameArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
-(IBAction)editTapped:(id)sender{
    _table.editing = !_table.editing;
}
-(IBAction)refreshTapped:(id)sender{
    [_table reloadData];
}
@end

