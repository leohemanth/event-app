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
#import "ListController.h"
@class DetailViewController;

#import <CoreData/CoreData.h>

@interface SessionListController : ListController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Session *detailItem;
@end
