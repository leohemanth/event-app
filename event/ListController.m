
//
//  MasterViewController.m
//  event
//
//  Created by Hemanth Prasad on 01/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "ListController.h"
#import "Event.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "NSManagedObject+Extended.h"

@interface ListController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView*)tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSString* searchString;
@end

@implementation ListController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(loadLocs) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    self.managedObjectContext = [Model sharedModel].managedObjectStore.mainQueueManagedObjectContext;

}


-(void)setModell:(Class)model{
        _modell=model;
        self.title=[self.modell display];
    NSLog(@"title set to %@",[self.modell display]);
        _fetchedResultsController = nil;
        _filteredFetchedResultsController = nil;
        [self.tableView reloadData];
//        [self.refreshControl beginRefreshing];
}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:[gestureRecognizer locationInView:self.tableView]];
//    return indexPath.section < 2;
//}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController willOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self.viewDeckController action:@selector(toggleLeftView)];
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController willCloseViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self.viewDeckController action:@selector(toggleLeftView)];
    [(IIViewDeckController*)self.viewDeckController.leftController closeLeftView];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedRCforTableView:tableView] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.tableView==tableView){
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        //        NSLog(@"count %d %@", [sectionInfo numberOfObjects],self.fetchedResultsController.);
        return [sectionInfo numberOfObjects];
    }
    else{
        return self.filteredFetchedResultsController.fetchedObjects.count;
        //return [[self.filteredFetchedResultsController sections][section] numberOfObjects];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath forTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        self.detailViewController.detailItem = object;
//    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    // if ([[segue identifier] isEqualToString:@"showDetail"]) {
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//    [[segue destinationViewController] setDetailItem:object];
//    // }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self.modell entity] inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[self.modell sortDescriptor] ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:[self.modell display]];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    NSLog(@"_fetchedResultsController count %d",_fetchedResultsController.fetchedObjects.count);
    return _fetchedResultsController;
}

- (NSFetchedResultsController *)filteredFetchedResultsController
{
    if (_filteredFetchedResultsController != nil && self.searchBar.text==self.searchString) {
        return _filteredFetchedResultsController;
    }
    [self UpdatefilteredFetchedResultsController];
    return _filteredFetchedResultsController;
}

-(NSFetchedResultsController *) fetchedRCforTableView:(UITableView*)tableView
{
    if (self.tableView==tableView)
        return self.fetchedResultsController;
    else
        return self.filteredFetchedResultsController;
}

- (void)UpdatefilteredFetchedResultsController
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self.modell entity] inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[self.modell sortDescriptor] ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    if (self.searchBar.text.length) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name contains[cd] %@", self.searchBar.text];
        [fetchRequest setPredicate:pred];
        self.searchString=self.searchBar.text;
    }
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.filteredFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![_filteredFetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    //  NSLog(@"Updating\n");
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString*)searchString searchScope:(NSInteger)searchOption {
    //[self UpdatefilteredFetchedResultsController];
    return YES;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

@end
