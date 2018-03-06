//
//  StagesTableViewController.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 26/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "StagesTableViewController.h"
#import "StagesTableViewCell.h"
#import "GameViewController.h"
#import "GameData.h"

#import "HighScoreModel+CoreDataClass.h"
#import "AppDelegate.h"

#import <CoreData/CoreData.h>
#import "HighScore.h"


@interface StagesTableViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray* imageNameArray;
}

@end

@implementation StagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self arraySetup];
}

-(void)arraySetup{
    imageNameArray = [NSMutableArray arrayWithArray:@[@"colombia",@"arabia",@"germany",@"koreia",@"china"]];
}

#pragma mark - Table view data source
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"stageCell";
    StagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.stageLabel.text = [NSString stringWithFormat:@"Stage %d",(int)indexPath.row + 1];
    
    //cell.stageLabel.text = [NSString stringWithFormat:@"%@",imageNameArray[indexPath.row]];
    
    //NSLog(@"Indes --> %d",[NSString stringWithFormat:@"%d",(int)indexPath.row + 1]);
    cell.stageImageView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
    
//    NSString* email2 = @"teste@teste2.com";
//    HighScoreModel* highScores = [self.delegate fetchWithFilterEmailStage:email2 stage:imageNameArray[indexPath.row]];
//    cell.stageScoreLabel.text = [NSString stringWithFormat:@"%d",data.highScore];
    
    GameData* data = [GameData data];
    [data load];
    
    if(indexPath.row == 0){
        cell.stageScoreLabel.text = [NSString stringWithFormat:@"%d",data.highScoreColombia];
    }else if( indexPath.row  == 1){
        cell.stageScoreLabel.text = [NSString stringWithFormat:@"%d",data.highScoreArabia];
    }else if(indexPath.row == 2){
        cell.stageScoreLabel.text = [NSString stringWithFormat:@"%d",data.highScoreGermany];
    }else if(indexPath.row == 3){
        cell.stageScoreLabel.text = [NSString stringWithFormat:@"%d",data.highScoreKoreia];
    }else if(indexPath.row == 4){
        cell.stageScoreLabel.text = [NSString stringWithFormat:@"%d",data.highScoreChina];
    }
    
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.layer.borderWidth = 2;
    cell.contentView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //cell.stageScoreLabel.text = [NSString stringWithFormat:@"%d",data.highScore];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return imageNameArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    GameViewController *gameSceneVC = segue.destinationViewController;
    UITableViewCell *cell = sender;
    // Passamos para o ViewController GameScene a categoria
    // que foi seleccionada
    NSIndexPath *selectedIndex = [self.tableView indexPathForCell:cell];
    NSString *stageFull= [NSString stringWithFormat:@"%@-stage",imageNameArray[selectedIndex.row]];
    gameSceneVC.stage = stageFull;
}
-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Adicionamos uma nova action quando o user arrasta horizontalmente a cell
    UIContextualAction *addAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Reset Score" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        //Quando o user clica na ação vamos guardar um novo ProductModel usando o indexPath
        [self resetScore:indexPath];
        completionHandler(true);
    }];
    
    return [UISwipeActionsConfiguration configurationWithActions:@[addAction]];
}

-(void)resetScore:(NSIndexPath*)indexPath {
    GameData* data = [GameData data];
    [data resetScore];
    
    NSArray* indexArray = [NSArray arrayWithObjects:indexPath, nil];
    
    [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView reloadData];
    
//    // Build the two index paths
//    NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:3 inSection:2];
//    NSIndexPath* indexPath2 = [NSIndexPath indexPathForRow:4 inSection:3];
//    // Add them in an index path array
//    NSArray* indexArray = [NSArray arrayWithObjects:indexPath1, indexPath2, nil];
//    // Launch reload for the two index path
//    [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];

}

@end
