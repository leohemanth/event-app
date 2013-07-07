//
//  ModelMethods.h
//  event
//
//  Created by Hemanth Prasad on 05/07/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelMethods <NSObject>
@required
+(NSString*)display;
+(NSString*)listApi;
+(NSString*)entity;
+(NSString*)sortDescriptor;
+(NSString*)textLabelFor:(NSManagedObject*)object;
+(NSString*)detailLabelFor:(NSManagedObject*)object;
+(id)findById:(NSInteger)model_id;
@end
