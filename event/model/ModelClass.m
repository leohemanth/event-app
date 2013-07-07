//
//  Model.m
//  event
//
//  Created by Hemanth Prasad on 23/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "ModelClass.h"
#import "Event.h"
#import "Session.h"
#import "Speaker.h"

@implementation ModelClass
id<ModelUpdate> modelUpdater;
RKEntityMapping *eventEntityMapping,*sessionEntitiyMapping,*speakerEntityMapping,*linksEntityMapping,*sessionCategoryEntityMapping;

+(void)init:(id<ModelUpdate>)uiModelUpdater{
    modelUpdater=uiModelUpdater;
}

+(ModelClass *)sharedModel{
    static ModelClass *sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[ModelClass alloc] init];
    });
    return sharedModel;
}
+(NSString*)displayFor:(Models)model{
    switch (model) {
        case Eventm:
            return [Event display];
            break;
        case Speakerm:
            return @"Speakers";
            break;
        case Sessionm:
            return @"Sessions";
            break;
        default:
            break;
    }
}

+(NSString*)listApiFor:(Models)model{
    switch (model) {
        case Eventm:
            return [Event listApi];
            break;
        case Speakerm:
            return @"/api/v1/speakers";
            break;
        case Sessionm:
            return @"/api/v1/sessions";
            break;
        default:
            break;
    }
}

+(NSString*)entityFor:(Models)model{
    switch (model) {
        case Eventm:
            return [Event entity];
            break;
        case Speakerm:
            return @"Speaker";
            break;
        case Sessionm:
            return @"Session";
            break;
        default:
            break;
    }
    
}

+(NSString*)sortDescriptorFor:(Models)model{
    switch (model) {
        case Eventm:
            return [Event sortDescriptor];
            break;
        case Speakerm:
            return @"speaker_id";
            break;
        case Sessionm:
            return @"session_id";
            break;
        default:
            break;
    }
}

+(NSString*)textLabelFor:(NSManagedObject*)object ofType:(Models)model{
    switch (model) {
        case Eventm:
            return [Event textLabelFor:object];
            break;
        case Speakerm:
            return ((Speaker*)object).name;
            break;
        case Sessionm:
            return ((Session*)object).name;
            break;
        default:
            break;
    }
}

+(NSString*)detailLabelFor:(NSManagedObject*)object ofType:(Models)model{
    switch (model) {
        case Eventm:
            return [Event detailLabelFor:object];
            break;
        case Speakerm:
            return ((Speaker*)object).name;
            break;
        case Sessionm:
            return ((Session*)object).desc;
            break;
        default:
            break;
    }
}

+(void)update:(NSManagedObject*)object ofType:(Models)model{
    [modelUpdater beginUpdate];
    [[RKObjectManager sharedManager] getObjectsAtPath:[ModelClass listApiFor:model]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [modelUpdater finishUpdate];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  [modelUpdater updateError];
                                              }];
}

+(void)updateAll:(NSManagedObject *)managedObject{
    [ModelClass update:managedObject ofType:Eventm];
    [ModelClass update:managedObject ofType:Sessionm];
}

-(void)initModel{
    NSError *error = nil;
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"event" ofType:@"momd"]];

    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    [self setManagedObjectStore: [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel]];
    
    [self.managedObjectStore createPersistentStoreCoordinator];
    
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"event.sqlite"];
    NSAssert(path, @"Failed to add persistent store: %@", error);
    
    [self.managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil
                                                    options: @{
                     NSInferMappingModelAutomaticallyOption: @YES, NSMigratePersistentStoresAutomaticallyOption: @YES}
                                                      error:nil];
    
    [self.managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:self.managedObjectStore];
    
    
    
    NSString *url=@"http://aqueous-scrubland-8867.herokuapp.com";
    
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

- (id)optionsForSqliteStore {
    return @{
             NSInferMappingModelAutomaticallyOption: @YES,
             NSMigratePersistentStoresAutomaticallyOption: @YES
             };
}

@end
