//
//  Model.h
//  event
//
//  Created by Hemanth Prasad on 23/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelMethods.h"
#import "Event+Extended.h"

@protocol ModelUpdate
@required
+(void)beginUpdate;
+(void)finishUpdate;
+(void)updateError;
@end

@interface Model : NSObject
@property (strong,nonatomic) RKManagedObjectStore *managedObjectStore;
+ (Model *)sharedModel;
-(void)applicationLaunched;
+(void)init:(id<ModelUpdate>)uiModelUpdater;
+(void)update:(NSManagedObject*)object ofType:(Class)model;
+(void)updateAll:(NSManagedObject *)managedObject;
@end
