//
//  Model.m
//  event
//
//  Created by Hemanth Prasad on 23/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "Model.h"
#import "Event.h"
#import "Session.h"
#import "Speaker.h"
#import "SyncEngine.h"
#import "CoreData+MagicalRecord.h"
@interface NSManagedObjectContext ()
+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context;
+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc;
@end

@implementation Model
id<ModelUpdate> modelUpdater;
RKEntityMapping *eventEntityMapping,*sessionEntitiyMapping,*speakerEntityMapping,*linksEntityMapping,*sessionCategoryEntityMapping;

+(void)init:(id<ModelUpdate>)uiModelUpdater{
    modelUpdater=uiModelUpdater;
}

+(Model *)sharedModel{
    static Model *sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[Model alloc] init];
    });
    return sharedModel;
}


+(void)update:(NSManagedObject*)object ofType:(Class)model{
    [modelUpdater beginUpdate];
    NSLog(@"my list api %@ nn model:%@",[model listApi],model);
    [[RKObjectManager sharedManager] getObjectsAtPath:[model listApi]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [modelUpdater finishUpdate];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  [modelUpdater updateError];
                                              }];
}

+(void)updateAll:(NSManagedObject *)managedObject{
    [Model update:managedObject ofType:[Event class]];
    [Model update:managedObject ofType:[Session class]];
}

-(void)applicationLaunched{
    NSError *error = nil;
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"event" ofType:@"momd"]];

    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    [self setManagedObjectStore: [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel]];
    
    [self.managedObjectStore createPersistentStoreCoordinator];
    
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"event.sqlite"];
    NSAssert(path, @"Failed to add persistent store: %@", error);
    
    [self.managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil
                                          withConfiguration:nil
                                                    options:@{NSInferMappingModelAutomaticallyOption: @YES,NSMigratePersistentStoresAutomaticallyOption: @YES}
                                                      error:nil];
    
    [self.managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:self.managedObjectStore];
    
    // Configure MagicalRecord to use RestKit's Core Data stack
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:self.managedObjectStore.persistentStoreCoordinator];
    [NSManagedObjectContext MR_setRootSavingContext:self.managedObjectStore.persistentStoreManagedObjectContext];
    [NSManagedObjectContext MR_setDefaultContext:self.managedObjectStore.mainQueueManagedObjectContext];
    
    
    
    NSString *url=@"http://aqueous-scrubland-8867.herokuapp.com";
    // NSString *url=@"http://localhost:3000";
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:url]];
     //   RKLogConfigureByName("RestKit", RKLogLevelWarning);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
//    NSLog(<#NSString *format, ...#>)
     //   RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    objectManager.managedObjectStore = self.managedObjectStore;
    
    [RKObjectManager setSharedManager:objectManager];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [self mapEntities];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:eventEntityMapping pathPattern:@"/api/v1/events" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    RKResponseDescriptor *responseDescriptor2 = [RKResponseDescriptor responseDescriptorWithMapping:sessionEntitiyMapping pathPattern:@"/api/v1/sessions" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor2];
    
    RKResponseDescriptor *responseDescriptor3 = [RKResponseDescriptor responseDescriptorWithMapping:speakerEntityMapping pathPattern:@"/api/v1/speakers" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor3];
    
    [SyncEngine startSync];
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
    
    speakerEntityMapping = [RKEntityMapping mappingForEntityForName:@"Speaker" inManagedObjectStore:self.managedObjectStore];
    [speakerEntityMapping addAttributeMappingsFromDictionary:@{
     @"name":           @"name",
     @"id":             @"speaker_id",
     }];
    
    RKRelationshipMapping *sessionRelationship =
    [RKRelationshipMapping relationshipMappingFromKeyPath:@"sessions"
                                                toKeyPath:@"sessions"
                                              withMapping:sessionEntitiyMapping];
    [speakerEntityMapping addPropertyMapping:sessionRelationship];
    
    speakerEntityMapping.identificationAttributes = @[ @"speaker_id" ];
}
@end
