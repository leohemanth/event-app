//
//  LeftViewController.m
//  event
//
//  Created by Hemanth Prasad on 22/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "LeftViewController.h"
#import "IIViewDeckController.h"

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
    [self.viewDeckController closeLeftView];
}

@end
