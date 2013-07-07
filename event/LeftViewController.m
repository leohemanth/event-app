//
//  LeftViewController.m
//  event
//
//  Created by Hemanth Prasad on 22/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "LeftViewController.h"
#import "IIViewDeckController.h"
#import <UIKit/UIKit.h>

@interface LeftViewController ()  <IIViewDeckControllerDelegate>

@end

@implementation LeftViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UINavigationController * nav=(UINavigationController*)self.viewDeckController.centerController;
    ListController *list;
    switch (indexPath.row) {
        case 0:
            list = [storyboard instantiateViewControllerWithIdentifier:@"eventTable"];
            nav.viewControllers=[NSArray arrayWithObject:list];
            break;
        case 1:
            list = [storyboard instantiateViewControllerWithIdentifier:@"sessionTable"];
            nav.viewControllers=[NSArray arrayWithObject:list];
            break;
        default:
            break;
    }
    [self.viewDeckController closeLeftView];
}
-(void)viewDidDisappear:(BOOL)animated{
}

@end
