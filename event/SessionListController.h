//
//  MasterViewController.h
//  event
//
//  Created by Hemanth Prasad on 01/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"
#import "AppDelegate.h"
@class DetailViewController;

#import <CoreData/CoreData.h>

@interface SessionListController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Session *detailItem;
@end
