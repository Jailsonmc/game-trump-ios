//
//  StagesTableViewCell.h
//  game-trump
//
//  Created by Jailson Cavalcanti on 26/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StagesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *stageImageView;

@property (weak, nonatomic) IBOutlet UILabel *stageLabel;

@property (weak, nonatomic) IBOutlet UILabel *stageScoreLabel;

@end
