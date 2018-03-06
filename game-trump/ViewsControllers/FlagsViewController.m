//
//  FlagsViewController.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 26/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "FlagsViewController.h"

@interface FlagsViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray* imageNameArray;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation FlagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self arraySetup];
}
-(void)arraySetup{
    imageNameArray = [NSMutableArray arrayWithArray:@[@"arabia",@"china",@"colombia"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return imageNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.imageView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
    cell.textLabel.text = imageNameArray[indexPath.row];
    return cell;
}
@end
