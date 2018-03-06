//
//  StagesViewController.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 26/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "StagesViewController.h"

@interface StagesViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray* imageNameArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableStage;

@end

@implementation StagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
-(void)arraySetup{
    imageNameArray = [NSMutableArray arrayWithArray:@[@"colombia",@"germany",@"arabia",@"koreia",@"china"]];
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return imageNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Entrou 2");
    static NSString* cellId = @"cellStage";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.imageView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
    cell.textLabel.text = imageNameArray[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row + 1];
    return cell;
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
