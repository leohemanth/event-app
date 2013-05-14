
//
//  MasterViewController.m
//  event
//
//  Created by Hemanth Prasad on 01/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "SessionListController.h"
#import "Session.h"
#import "DetailViewController.h"
#import "ListController.h"

@interface SessionListController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation SessionListController

- (void)awakeFromNib
{
     NSLog(@"in awake from nib");
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
//    [self loadLocs];
//    [self.refreshControl beginRefreshing];
//
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(loadLocs) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectStore.mainQueueManagedObjectContext;
    [super viewDidLoad];
    self.model=Sessionm;
    [self.refreshControl beginRefreshing];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        self.detailViewController.detailItem = object;
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Session *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = event.name;
    cell.detailTextLabel.text = event.desc;
}


@end
