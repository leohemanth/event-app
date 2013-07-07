//
//  MasterViewController.h
//  event
//
//  Created by Hemanth Prasad on 01/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@class DetailViewController;

#import <CoreData/CoreData.h>
#import "IIViewDeckController.h"
#import <RestKit/RestKit.h>

@interface ListController : UITableViewController <UISearchBarDelegate,NSFetchedResultsControllerDelegate,UISearchDisplayDelegate,UIGestureRecognizerDelegate, IIViewDeckControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *filteredFetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (assign,nonatomic) Class modell;

-(NSFetchedResultsController *) fetchedRCforTableView:(UITableView*)tableView;
@end
