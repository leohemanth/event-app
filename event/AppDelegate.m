//
//  AppDelegate.m
//  event
//
//  Created by Hemanth Prasad on 01/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "AppDelegate.h"
#import "IIViewDeckController.h"
#import <UIKit/UIKit.h>
#import "Model.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[Model sharedModel] applicationLaunched];

    
    // Override point for customization after application launch.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"mainCenterController"];
    
    IIViewDeckController* secondDeckController =  [[IIViewDeckController alloc] initWithCenterViewController:navigationController
                                                                                          leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"sideBarController"]];
    secondDeckController.centerhiddenInteractivity=IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    self.window.rootViewController = secondDeckController;
    return YES;
}

@end
