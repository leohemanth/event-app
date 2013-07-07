//
//  Event+My.m
//  event
//
//  Created by Hemanth Prasad on 05/07/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "Event+Extended.h"

@implementation Event (Extended)
+(NSString*)display{
    return @"Events";
}
+(NSString*)listApi{
    return @"/api/v1/events";
}
+(NSString*)entity{
    return @"Event";
}
+(NSString*)sortDescriptor{
    return @"event_id";
}
+(NSString*)textLabelFor:(NSManagedObject*)object{
    return ((Event*)object).name;
}
+(NSString*)detailLabelFor:(NSManagedObject*)object{
    return ((Event*)object).desc;
}
@end
