//
//  Session+Extended.m
//  event
//
//  Created by Hemanth Prasad on 06/07/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "Speaker+Extended.h"
@implementation Speaker (Extended)

+(NSString*)display{
    return @"Speakers";
}
+(NSString*)listApi{
    return @"/api/v1/speakers";
}
+(NSString*)entity{
    return @"Speaker";
}
+(NSString*)sortDescriptor{
    return @"speaker_id";
}
+(NSString*)textLabelFor:(NSManagedObject*)object{
    return ((Speaker*)object).name;
}
+(NSString*)detailLabelFor:(NSManagedObject*)object{
     return [NSString stringWithFormat:@"%d",((Speaker*)object).sessions.count];
}

@end
