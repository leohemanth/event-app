//
//  SyncManager.h
//  event
//
//  Created by Hemanth Prasad on 05/07/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncEngine : NSObject
@property (atomic, readonly) BOOL isSyncInProgress;

+ (SyncEngine *)syncEngine;
- (void)registerModelToSync:(Class)aClass;
+ (void)startSync;

@end
