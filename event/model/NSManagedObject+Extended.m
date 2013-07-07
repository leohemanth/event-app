//
//  NSManagedObject+Extended.m
//  event
//
//  Created by Hemanth Prasad on 06/07/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "NSManagedObject+Extended.h"


@implementation NSManagedObject (Extended)
+(NSString*)display{
    return  NSStringFromClass(self);
}
+(NSString*)listApi{
    return @"";
}
+(NSString*)entity{
    return NSStringFromClass(self);
}
+(NSString*)sortDescriptor{
    return @"";
}
+(NSString*)textLabelFor:(NSManagedObject*)object{
    return nil;
}
+(NSString*)detailLabelFor:(NSManagedObject*)object{
    return nil;
}
@end
