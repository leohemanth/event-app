//
//  NSManagedObject+Extended.h
//  event
//
//  Created by Hemanth Prasad on 06/07/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ModelMethods.h"

@interface NSManagedObject (Extended) <ModelMethods>
+(NSString*)display;
+(NSString*)listApi;
+(NSString*)entity;
+(NSString*)sortDescriptor;
+(NSString*)textLabelFor:(NSManagedObject*)object;
+(NSString*)detailLabelFor:(NSManagedObject*)object;

@end
