//
//  GameViewController.m
//  game-trump
//
//  Created by Jailson Cavalcanti on 25/12/2017.
//  Copyright © 2017 Jailson Cavalcanti. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
    //GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    //scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    //[skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
//    SKScene *scene = [GameScene sceneWithSize:skView.bounds.size];
    GameScene *scene = [GameScene sceneWithSize:skView.bounds.size];
    scene.stage = self.stage;
    //NSLog(@"Stage : %@",scene.stage);
    //SKScene *scene = [GameScene sceneWithSize:CGSizeMake(skView.frame.size.height, skView.frame.size.width)];
    scene.scaleMode = SKSceneScaleModeFill;
    
    [skView presentScene:scene];
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
