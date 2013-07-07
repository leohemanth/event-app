//
//  SessionViewController.m
//  event
//
//  Created by Hemanth Prasad on 26/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "SessionViewController.h"

@interface SessionViewController ()

@end

@implementation SessionViewController

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
    super.modell=[Session class];
    //   super.model=Sessionm;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView*)tableView{
    NSManagedObject *object = [[super fetchedRCforTableView:tableView] objectAtIndexPath:indexPath];
    cell.textLabel.text = [Session textLabelFor:object];
    cell.detailTextLabel.text = [Session detailLabelFor:object];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UITableView *tv = (UITableView*)[sender superview];
    Session *s = [[self fetchedRCforTableView:tv] objectAtIndexPath:[tv indexPathForCell:sender]];
    if([segue.identifier isEqualToString:@"SessionToSpeaker"]){
        ((SessionViewController*)segue.destinationViewController).filtered=YES;
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"any sessions.session_id = %@",[s session_id]];
        ((SessionViewController*)segue.destinationViewController).predicate=pred;
    }
}

@end
