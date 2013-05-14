//
//  Model.m
//  event
//
//  Created by Hemanth Prasad on 23/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import "Model.h"
#import "Event.h"
#import "Session.h"
#import "Speaker.h"
@implementation Model

+(NSString*)displayFor:(Models)model{
    switch (model) {
        case Eventm:
            return @"Events";
            break;
        case Speakerm:
            return @"Speakers";
            break;
        case Sessionm:
            return @"Sessions";
            break;
        default:
            break;
    }
}

+(NSString*)listApiFor:(Models)model{
    switch (model) {
        case Eventm:
            return @"/api/v1/events";
            break;
        case Speakerm:
            return @"/api/v1/speakers";
            break;
        case Sessionm:
            return @"/api/v1/sessions";
            break;
        default:
            break;
    }
}

+(NSString*)entityFor:(Models)model{
    switch (model) {
        case Eventm:
            return @"Event";
            break;
        case Speakerm:
            return @"Speaker";
            break;
        case Sessionm:
            return @"Session";
            break;
        default:
            break;
    }
    
}

+(NSString*)sortDescriptorFor:(Models)model{
    switch (model) {
        case Eventm:
            return @"event_id";
            break;
        case Speakerm:
            return @"speaker_id";
            break;
        case Sessionm:
            return @"session_id";
            break;
        default:
            break;
    }
}

+(NSString*)textLabelFor:(NSManagedObject*)object ofType:(Models)model{
    switch (model) {
        case Eventm:
            return ((Event*)object).name;
            break;
        case Speakerm:
            return ((Speaker*)object).name;
            break;
        case Sessionm:
            return ((Session*)object).name;
            break;
        default:
            break;
    }
}

+(NSString*)detailLabelFor:(NSManagedObject*)object ofType:(Models)model{
    switch (model) {
        case Eventm:
            return ((Event*)object).desc;
            break;
        case Speakerm:
            return ((Speaker*)object).name;
            break;
        case Sessionm:
            return ((Session*)object).desc;
            break;
        default:
            break;
    }
}

@end
