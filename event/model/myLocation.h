//
//  myLocation.h
//  event
//
//  Created by Hemanth Prasad on 12/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, Session;

@interface myLocation : NSManagedObject

@property (nonatomic, retain) NSString * loc_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * event_id;
@property (nonatomic, retain) NSSet *session;
@property (nonatomic, retain) Event *event;
@end

@interface myLocation (CoreDataGeneratedAccessors)

- (void)addSessionObject:(Session *)value;
- (void)removeSessionObject:(Session *)value;
- (void)addSession:(NSSet *)values;
- (void)removeSession:(NSSet *)values;

@end
