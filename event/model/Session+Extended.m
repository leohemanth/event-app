//
//  Session+Extended.m
//  event
//
//  Created by Hemanth Prasad on 06/07/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "Session+Extended.h"
#import "NSManagedObject+Extended.h"
@implementation Session (Extended)

+(NSString*)display{
    return @"Sessions";
}
+(NSString*)listApi{
    return @"/api/v1/sessions";
}
+(NSString*)entity{
    return @"Session";
}
+(NSString*)sortDescriptor{
    return @"session_id";
}
+(NSString*)textLabelFor:(NSManagedObject*)object{
    return ((Session*)object).name;
}
+(NSString*)detailLabelFor:(NSManagedObject*)object{
    return [NSString stringWithFormat:@"%d",((Session*)object).speakers.count];
    
}

@end
