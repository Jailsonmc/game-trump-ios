//
//  GameScene.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "GameScene.h"
#import "MLHero.h"
#import "MLWorldGenerator.h"
#import "MLPointsLabel.h"
#import "GameData.h"

#import "Person+CoreDataClass.h"

@interface GameScene()
@property BOOL isStarted;
@property BOOL isGameOver;
@property NSInteger life;
@end

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    MLHero *hero;
    SKNode *world;
    MLWorldGenerator *generator;
}

static NSString* GAME_FONT = @"AmericanTypewriter-Bold";

- (void)didMoveToView:(SKView *)view {
    
    self.life = 3;
    
    // Setup your scene here
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.physicsWorld.contactDelegate = self;
    [self createContent];
    
    // Get label node from scene and store it for use later
    _label = (SKLabelNode *)[self childNodeWithName:@"//helloLabel"];

    _label.alpha = 0.0;
    [_label runAction:[SKAction fadeInWithDuration:2.0]];

    CGFloat w = (self.size.width + self.size.height) * 0.05;

    // Create shape node to use during mouse interaction
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    _spinnyNode.lineWidth = 2.5;

    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
    [_spinnyNode runAction:[SKAction sequence:@[
                                                [SKAction waitForDuration:0.5],
                                                [SKAction fadeOutWithDuration:0.5],
                                                [SKAction removeFromParent],
                                                ]]];
}

-(void)createContent{
    self.backgroundColor = [SKColor colorWithRed:0.54 green:0.7853 blue:1.0 alpha:1.0];
    
    world = [SKNode node];
    [self addChild:world];
    
    //self.stage = @"koreia-stage";
    
    //NSLog(@"Stage >> %@", self.stage);
    
    generator = [MLWorldGenerator generatorWithWorld:world];
    [self addChild:generator];
    [generator populate:self.stage];
    
    //NSLog(@"Altura: %@",self.frame.size.height);
    
    hero = [MLHero hero];
    [world addChild:hero];
    
    [self loadScoreLabels];
    
    SKLabelNode* tapToBeginLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    tapToBeginLabel.name = @"tapToBeginLabel";
    tapToBeginLabel.text = @"Tap to Begin";
    tapToBeginLabel.fontSize = 22.0;
    //tapToBeginLabel.position = CGPointMake(100, 100);
    [self addChild:tapToBeginLabel];
    
    [self animateWithPulse:tapToBeginLabel];
    [self loadClouds];
}

-(void)loadScoreLabels{
    
    MLPointsLabel* pointsLabel = [MLPointsLabel pointsLabelWithFontNamed:GAME_FONT];
    pointsLabel.name = @"pointsLabel";
    pointsLabel.position = CGPointMake(-100, 100);
    [self addChild:pointsLabel];
    
    GameData* data = [GameData data];
    [data load];
    
    MLPointsLabel* highScoreLabel = [MLPointsLabel pointsLabelWithFontNamed:GAME_FONT];
    highScoreLabel.name = @"highScoreLabel";
    highScoreLabel.position = CGPointMake(100, 100);
    
    //[highScoreLabel setPoints:data.highScore];
    
    if([self.stage isEqualToString:@"colombia-stage"]){
        [highScoreLabel setPoints:data.highScoreColombia];
    }else if([self.stage isEqualToString:@"arabia-stage"]){
        [highScoreLabel setPoints:data.highScoreArabia];
    }else if([self.stage isEqualToString:@"germany-stage"]){
        [highScoreLabel setPoints:data.highScoreGermany];
    }else if([self.stage isEqualToString:@"koreia-stage"]){
        [highScoreLabel setPoints:data.highScoreKoreia];
    }else if([self.stage isEqualToString:@"china-stage"]){
        [highScoreLabel setPoints:data.highScoreChina];
    }
    
    [self addChild:highScoreLabel];
    
    SKLabelNode* bestLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    bestLabel.text = @"Best:";
    bestLabel.fontSize = 16.0;
    bestLabel.position = CGPointMake(-40, 0);
    [highScoreLabel addChild:bestLabel];
    
}

-(void)loadClouds{
    SKShapeNode* cloud1 = [SKShapeNode node];
    cloud1.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 65, 100, 40)].CGPath;
    cloud1.fillColor = [UIColor whiteColor];
    cloud1.strokeColor = [UIColor blackColor];
    [world addChild:cloud1];
    
    SKShapeNode* cloud2 = [SKShapeNode node];
    cloud2.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-250, 45, 100, 40)].CGPath;
    cloud2.fillColor = [UIColor whiteColor];
    cloud2.strokeColor = [UIColor blackColor];
    [world addChild:cloud2];
}

-(void)start{
    self.isStarted = YES;
    [[self childNodeWithName:@"tapToBeginLabel"]removeFromParent];
    [hero start];
}

-(void)clear{
    GameScene* scene = [[GameScene alloc] initWithSize:self.frame.size];
    scene.stage = self.stage;
    [self.view presentScene:scene];
}

-(void)gameOver{
    self.isGameOver = YES;
    [hero stop];
    [self runAction:[SKAction playSoundFileNamed:@"zapsplat_voice_game_over.mp3" waitForCompletion:NO]];
    
    SKLabelNode* gameOverLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    gameOverLabel.text = @"Game Over";
    gameOverLabel.position = CGPointMake(0, 60);
    [self addChild:gameOverLabel];
    
    SKLabelNode* tapToResetLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    tapToResetLabel.name = @"tapToResetLabel";
    tapToResetLabel.text = @"Tap to Reset";
    tapToResetLabel.fontSize = 22.0;
    //tapToBeginLabel.position = CGPointMake(100, 100);
    [self addChild:tapToResetLabel];
    
    [self animateWithPulse:tapToResetLabel];
    
    [self updateHighScore];
    
}

-(void)updateHighScore{
    MLPointsLabel* pointsLabel = (MLPointsLabel*)[self childNodeWithName:@"pointsLabel"];
    MLPointsLabel* highScoreLabel = (MLPointsLabel*)[self childNodeWithName:@"highScoreLabel"];
    
    if(pointsLabel.number > highScoreLabel.number){
        [highScoreLabel setPoints:pointsLabel.number];
        
        GameData* data = [GameData data];
        [data load];
        
        data.highScore = pointsLabel.number;
        data.stage = self.stage;
        
        if([self.stage isEqualToString:@"colombia-stage"]){
            data.highScoreColombia = pointsLabel.number;
        }else if([self.stage isEqualToString:@"arabia-stage"]){
            data.highScoreArabia = pointsLabel.number;
        }else if([self.stage isEqualToString:@"germany-stage"]){
            data.highScoreGermany = pointsLabel.number;
        }else if([self.stage isEqualToString:@"koreia-stage"]){
            data.highScoreKoreia = pointsLabel.number;
        }else if([self.stage isEqualToString:@"china-stage"]){
            data.highScoreChina = pointsLabel.number;
        }
        [data save];
        
    }

}

-(void)didSimulatePhysics{
    [self centerOnNode:hero];
    [self handlePoints];
    [self handleGeneration];
    [self handleCleanup];
}

-(void)handlePoints{
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if(node.position.x < hero.position.x){
            MLPointsLabel* pointsLabel = (MLPointsLabel*)[self childNodeWithName:@"pointsLabel"];
            [pointsLabel increment];
        }
    }];
}

-(void)handleGeneration{
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if(node.position.x < hero.position.x){
            node.name = @"obstacle_cancelled";
            [generator generate:self.stage];
        }
    }];
}

-(void)handleCleanup{
    [world enumerateChildNodesWithName:@"ground" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if(node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2){
            [node removeFromParent];
        }
    }];
    
    [world enumerateChildNodesWithName:@"obstacle_cancelled" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if(node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2){
            [node removeFromParent];
        }
    }];
}

-(void)centerOnNode:(SKNode *)node{
    CGPoint positionInScene = [self convertPoint:node.position fromNode:node.parent];
    world.position = CGPointMake(world.position.x - positionInScene.x, world.position.y);
}

- (void)touchDownAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor blueColor];
    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor redColor];
    [self addChild:n];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Run 'Pulse' action from 'Actions.sks'
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
    
    if(!self.isStarted)
        [self start];
    else if(self.isGameOver)
        [self clear];
    else
        [hero jump];
    //MLHero *hero = (MLHero *)[self childNodeWithName:@"hero"];
    
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}
-(void)didBeginContact:(SKPhysicsContact *)contact{
    if( [contact.bodyA.node.name isEqualToString:@"ground"] || [contact.bodyB.node.name isEqualToString:@"ground"]){
        [hero land];
    }else{
        [self gameOver];
//        if(self.life == 0 && !self.isGameOver){
//            [self gameOver];
//        }else{
//            self.life--;
//        }
    }
}
// ** Animation section ** //

-(void)animateWithPulse:(SKNode*)node{
    SKAction* disappear = [SKAction fadeAlphaTo:0.0 duration:0.6];
    SKAction* appear    = [SKAction fadeAlphaTo:1.0 duration:0.6];
    SKAction* pulse     = [SKAction sequence:@[disappear,appear]];
    [node runAction:[SKAction repeatActionForever:pulse]];
}
@end
