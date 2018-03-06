//
//  HeroesTableViewController.h
//  iHeros
//
//  Created by Jailson Cavalcanti on 30/11/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroesTableViewController : UITableViewController<UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
