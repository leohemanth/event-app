//
//  AppDelegate.m
//  event
//
//  Created by Hemanth Prasad on 01/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "AppDelegate.h"
#import "IIViewDeckController.h"
#import <UIKit/UIKit.h>
@implementation AppDelegate

RKEntityMapping *eventEntityMapping,*sessionEntitiyMapping,*speakerEntityMapping,*linksEntityMapping,*sessionCategoryEntityMapping;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSError *error = nil;
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"event" ofType:@"momd"]];
    // NOTE: Due to an iOS 5 bug, the managed object model returned is immutable.
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    [self setManagedObjectStore: [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel]];
    
    // Initialize the Core Data stack
    [self.managedObjectStore createPersistentStoreCoordinator];
    
    NSPersistentStore __unused *persistentStore = [self.managedObjectStore addInMemoryPersistentStore:&error];
    NSAssert(persistentStore, @"Failed to add persistent store: %@", error);
    
    [self.managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:self.managedObjectStore];
    
    NSString *url=@"http://192.168.11.11:3000";
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:url]];
//    RKLogConfigureByName("RestKit", RKLogLevelWarning);
//    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
//    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    objectManager.managedObjectStore = self.managedObjectStore;
    
    [RKObjectManager setSharedManager:objectManager];
    
    [self mapEntities];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:eventEntityMapping pathPattern:@"/api/v1/events" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    RKResponseDescriptor *responseDescriptor2 = [RKResponseDescriptor responseDescriptorWithMapping:sessionEntitiyMapping pathPattern:@"/api/v1/sessions" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor2];
    
    
    // Override point for customization after application launch.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"mainCenterController"];
    
    IIViewDeckController* secondDeckController =  [[IIViewDeckController alloc] initWithCenterViewController:navigationController
                                                                                          leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"sideBarController"]];
    secondDeckController.centerhiddenInteractivity=IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    self.window.rootViewController = secondDeckController;
    return YES;
}

-(void)mapEntities{
    //event
    eventEntityMapping = [RKEntityMapping mappingForEntityForName:@"Event" inManagedObjectStore:self.managedObjectStore];
    [eventEntityMapping addAttributeMappingsFromDictionary:@{
     @"id":             @"event_id",
     @"name":           @"name",
     @"description":    @"desc",
     @"no_of_days":     @"no_of_days",
     @"start_date":     @"start_date",
     }];
    eventEntityMapping.identificationAttributes = @[ @"event_id" ];
    
    sessionEntitiyMapping = [RKEntityMapping mappingForEntityForName:@"Session" inManagedObjectStore:self.managedObjectStore];
    [sessionEntitiyMapping addAttributeMappingsFromDictionary:@{
     @"name":           @"name",
     @"description":    @"desc",
     @"start_time":     @"start_time",
     @"duration":       @"duration",
     @"location_id":    @"location_id",
     @"event_id":       @"event_id",
     @"id":             @"session_id",
     }];
    sessionEntitiyMapping.identificationAttributes = @[ @"session_id" ];
}
@end
