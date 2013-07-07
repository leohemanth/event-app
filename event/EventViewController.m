//
//  EventViewController.m
//  event
//
//  Created by Hemanth Prasad on 26/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "EventViewController.h"
#import "SessionViewController.h"
#import "Event+Extended.h"
#import "Event.h"
@interface EventViewController ()

@end

@implementation EventViewController

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
    self.modell=[Event class];
    //self.model=Eventm;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView*)tableView{
    NSManagedObject *object = [[super fetchedRCforTableView:tableView] objectAtIndexPath:indexPath];
    cell.textLabel.text = [Event detailLabelFor:object];
    cell.detailTextLabel.text = [Event textLabelFor:object];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"eventToSession"]){
  //      [Event obj]
 //       [self.tableView indexPathForSelectedRow].row;
  //      ((SessionViewController*)sender).event=
    }
}
@end
