//
//  Model.h
//  event
//
//  Created by Hemanth Prasad on 23/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ModelUpdate
+(void)beginUpdate;
+(void)finishUpdate;
+(void)updateError;
@end

@interface Model : NSObject
//typedef enum : NSInteger {
//    Eventm,
//    Speakerm,
//    Sessionm
//} Models;
typedef NS_ENUM(NSInteger, Models) {
    Eventm,
    Speakerm,
    Sessionm
};
+(void)init:(id<ModelUpdate>)uiModelUpdater;
+(NSString*)displayFor:(Models)model;
+(NSString*)listApiFor:(Models)model;
+(NSString*)entityFor:(Models)model;
+(NSString*)sortDescriptorFor:(Models)model;
+(NSString*)textLabelFor:(NSManagedObject*)object ofType:(Models)model;
+(NSString*)detailLabelFor:(NSManagedObject*)object ofType:(Models)model;
+(void)update:(NSManagedObject*)object ofType:(Models)model;
+(void)updateAll:(NSManagedObject *)managedObject;
@end
