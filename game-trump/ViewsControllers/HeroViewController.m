//
//  HeroViewController.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 31/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "HeroViewController.h"
#import "Network.h"
#import "HeroModel.h"


@interface HeroViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabelField;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabelField;

@property (nonatomic, strong) NSArray *heroesArray;

@end

@implementation HeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUrl];
    
    HeroModel *model = self.heroesArray[0];
    
    if(model.name != nil){
        self.nameLabelField.text = model.name;
    }else{
        self.nameLabelField.text = @"Without title";
    }
    if(model.heroDescription != nil){
        self.descriptionLabelField.text = model.heroDescription;
    }else{
        self.descriptionLabelField.text = @"Without description";
    }
    
    //https://gateway.marvel.com/v1/public/characters?apikey=fe5afd66d30369d4afcd76b1ef86f30e&ts=1511902466&hash=866756952028a95e075d74534c32aaa9
    //https://gateway.marvel.com/v1/public/characters/1010933?ts=1514754422&hash=1245f88c0df476b8a8bc43ff79315cfe&apikey=fe5afd66d30369d4afcd76b1ef86f30e
    //HeroModel *model = self.heroesArray[0];
    //cell.nameLabel.text = model.name;
//    NSLog(@"Value :%@",value);
//    self.nameLabelField.text = [NSString stringWithFormat:@"%@",value];
    
//    if(self.name != nil){
//        self.nameLabelField.text = self.name;
//    }else{
//        self.nameLabelField.text = @"Without title";
//    }
//    if(self.heroDescription != nil){
//        self.descriptionLabelField.text = self.heroDescription;
//    }else{
//        self.descriptionLabelField.text = @"Without description";
//    }
    
    
//    self.descriptionLabelField.text = [NSString stringWithFormat:value];
    // Do any additional setup after loading the view.self.noticeLabel.text = @"Email or password invalid.";
}

-(void)createUrl{
    Network* network = [[Network alloc] init];
    NSNumber* value = self.idHero;
    //NSURL *url = [network fetchHeroesById:value];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[network fetchHeroesById:value] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self parseHeroes:data];
    }];
    [task resume];
}
-(void)parseHeroes:(NSData*)data{
    //NSLog(@"Data ---> %@ <--- Data",data);
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *heroesJson = json[@"data"][@"results"];
    NSMutableArray *heroes = [[NSMutableArray alloc] init];
    //NSLog(@"heroesJson ---> %@ <--- heroesJson",heroesJson);
    for (NSDictionary *dictionary in heroesJson) {
        HeroModel *model = [[HeroModel alloc] initWithDictionary:dictionary];
        [heroes addObject:model];
    }
    
    self.heroesArray = heroes.mutableCopy;
    

    
    //NSLog(@"%@ Array",self.heroesArray);
    //dispatch_sync(dispatch_get_main_queue(), ^{
       //[self.tableView reloadData];
       //[self.view setNeedsDisplay];
    //});
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
