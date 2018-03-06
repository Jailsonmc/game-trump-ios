//
//  MLWorldGenerator.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "MLWorldGenerator.h"

@interface MLWorldGenerator()
//{
//    NSMutableArray* imageNameArrayGround;
//}
@property double currentGroundX;
@property double currentObstacleX;
@property SKNode* world;
@end

@implementation MLWorldGenerator

static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;

+ (id)generatorWithWorld:(SKNode*)world{
    
    MLWorldGenerator* generator = [MLWorldGenerator node];
    generator.currentGroundX = 0;
    generator.currentObstacleX = 400;
    generator.world = world;
//    [generator populate];
    return generator;
}

-(void)populate:(NSString *)stage{
    for (int i = 0; i < 3; i++)
        [self generate:stage];
    
}

//-(NSString *)arraySetupGround{
//    imageNameArrayGround = [NSMutableArray arrayWithArray:@[@"colombia",@"arabia-stage",@"germany",@"koreia",@"china"]];
//    return imageNameArrayGround[1];
//}

-(void)generate:(NSString *)stage{
    //cell.imageView.image = [UIImage imageNamed:imageNameArray[indexPath.row]];
//    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(self.scene.frame.size.width, 100)];
//    NSMutableArray* imageNameArrayGround = [NSMutableArray arrayWithArray:@[@"colombia",@"arabia-stage",@"germany",@"koreia",@"china"]];
    //NSLog(@"Image: ‰@",imageNameArrayGround[1]);
     //NSLog(@"Altura: %@",self.frame.size.height);
    //NSString *stage = imageNameArrayGround[1];
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:stage];
    //SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"ground"];
    ground.name = @"ground";
    //ground.position = CGPointMake(0, -400);
    //ground.position = CGPointMake(self.currentGroundX, -self.scene.frame.size.height/2 + ground.frame.size.height/2);
    ground.position = CGPointMake(self.currentGroundX, -self.scene.frame.size.height/2 + ground.frame.size.height/6);
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    ground.physicsBody.categoryBitMask = groundCategory;
    ground.physicsBody.dynamic = NO;
    [self.world addChild:ground];
    
    self.currentGroundX += ground.frame.size.width;
//    spriteNodeWithColor: size:CGSizeMake:CGSizeMake(40, 70)];
    SKSpriteNode *obstacle = [SKSpriteNode spriteNodeWithColor:[self getRandomColor] size:CGSizeMake(40, 70)];
    obstacle.name = @"obstacle";
    obstacle.position = CGPointMake(self.currentGroundX, ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2);
    obstacle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obstacle.size];
    obstacle.physicsBody.categoryBitMask = obstacleCategory;
    obstacle.physicsBody.dynamic = NO;
    [self.world addChild:obstacle];
    
    self.currentObstacleX += 250;
}

-(UIColor *)getRandomColor{
    int rand = arc4random() % 6;
    UIColor* color;
    
    switch (rand) {
        case 0:
            color = [UIColor redColor];
            break;
        case 1:
            color = [UIColor orangeColor];
            break;
        case 2:
            color = [UIColor yellowColor];
            break;
        case 3:
            color = [UIColor greenColor];
            break;
        case 4:
            color = [UIColor purpleColor];
            break;
        case 5:
            color = [UIColor blueColor];
            break;
        default:
            break;
    }
    return color;
}

@end
