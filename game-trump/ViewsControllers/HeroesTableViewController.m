//
//  HeroesTableViewController.m
//  iHeros
//
//  Created by Jailson Cavalcanti on 30/11/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "HeroesTableViewController.h"

#import "Network.h"
#import "HeroModel.h"
#import "HeroTableViewCell.h"
#import "UIImageView+URL.h"
#import "HeroViewController.h"

@interface HeroesTableViewController ()
@property (nonatomic) UISearchController *searchController;
@property (nonatomic) Network *network;
@property (nonatomic, strong) NSArray *heroesArray;
@end

@implementation HeroesTableViewController

-(Network*)network{
    if(_network == nil){
        _network = [[Network alloc]init];
    }
    return _network;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureLayout];
    [self.imageView setImageWithString:@"https://lumiere-a.akamaihd.net/v1/images/Darth-Vader_6bda9114.jpeg?region=0%2C23%2C1400%2C785&width=768"];
}

-(void)configureLayout{

    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.navigationItem.searchController = self.searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //NSLog(@"OI6");
    //NSLog(searchController.searchBar.text);
    
    [self fetchHeroes:searchController.searchBar.text];
}

-(void)fetchHeroes:(NSString*)searchText{
    //NSLog(@"%@ -- ",searchText);
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[self.network fetchHeroesByQuery:searchText] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d Tamanho do Array",self.heroesArray.count);
    return self.heroesArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeroCell"];
    HeroModel *model = self.heroesArray[indexPath.row];
    cell.nameLabel.text = model.name;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HeroViewController *heroVC = segue.destinationViewController;
    UITableViewCell *cell = sender;
    // Passamos para o ViewController ProductsTableViewController a categoria
    // que foi seleccionada
//    NSIndexPath *selectedIndex = [self.tableView indexPathForCell:cell];
//    heroVC.category = self.categoriesSections[selectedIndex.row];
    
      NSIndexPath *selectedIndex = [self.tableView indexPathForCell:cell];
      HeroModel *model = self.heroesArray[selectedIndex.row];
      heroVC.idHero = model.idHero;
      //NSNumber *characterId = self.heroesArray[selectedIndex].idHero;[self.imageTitleArray objectAtIndex: indexPath.row];
      //NSArray *teste = [self.heroesArray objectAtIndex:selectedIndex];
      //NSMutableArray *idHero = [[NSString alloc]initWithFormat:@"%@",[self.heroesArray objectForKey:@"key"]];
      //heroVC.idHero = [self.heroesArray[selectedIndex] objectAtIndex:@"idHero"];
//    NSString *characterId = [NSString stringWithFormat:@"%@-stage",imageNameArray[selectedIndex.row]];
//    gameSceneVC.stage = stageFull;
    
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Adicionamos uma nova action quando o user arrasta horizontalmente a cell
    UIContextualAction *addAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Add Favorite" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        //Quando o user clica na ação vamos guardar um novo ProductModel usando o indexPath
        //[self resetScore:indexPath];
        completionHandler(true);
    }];
    
    return [UISwipeActionsConfiguration configurationWithActions:@[addAction]];
}

@end
