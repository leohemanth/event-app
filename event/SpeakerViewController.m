//
//  SpeakerViewController.m
//  event
//
//  Created by Hemanth Prasad on 06/07/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "SpeakerViewController.h"

@interface SpeakerViewController ()

@end

@implementation SpeakerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    super.modell=[Speaker class];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView*)tableView{
    NSManagedObject *object = [[super fetchedRCforTableView:tableView] objectAtIndexPath:indexPath];
    cell.textLabel.text = [Speaker textLabelFor:object];
    cell.detailTextLabel.text = [Speaker detailLabelFor:object];
}
@end
