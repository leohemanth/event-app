//
//  SyncManager.m
//  event
//
//  Created by Hemanth Prasad on 05/07/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "SyncEngine.h"
#import "Speaker+Extended.h"
#import "Event+Extended.h"
#import "Session+Extended.h"
@implementation SyncEngine
+ (SyncEngine *)syncEngine{
    static SyncEngine *syncEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        syncEngine = [[SyncEngine alloc] init];
    });
    
    return syncEngine;
}

+ (void)startSync{
//    if (!self.isSyncInProgress) {
        [self willChangeValueForKey:@"syncInProgress"];
//        _isSyncInProgress = YES;
        [self didChangeValueForKey:@"syncInProgress"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [self updateAll];
        });
//    }
}

+ (void)updateAll{
    NSArray * models=[NSArray arrayWithObjects:[Event class], [Session class],[Speaker class],nil];
    for (Class model in models) {
    
    [[RKObjectManager sharedManager] getObjectsAtPath:[model listApi]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                                                  [self.refreshControl endRefreshing];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
//                                                  [self.refreshControl endRefreshing];
                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An Error Has Occurred" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                  NSLog(@"error: %@",error);
                                                  [alertView show];
                                              }];

    }
}
@end
