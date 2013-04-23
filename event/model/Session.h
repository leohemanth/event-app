//
//  Session.h
//  event
//
//  Created by Hemanth Prasad on 12/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, SessionCategory, Speaker, myLocation;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * event_id;
@property (nonatomic, retain) NSNumber * location_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * start_time;
@property (nonatomic, retain) NSNumber * session_id;
@property (nonatomic, retain) NSSet *categories;
@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) myLocation *location;
@property (nonatomic, retain) NSSet *speakers;
@end

@interface Session (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(SessionCategory *)value;
- (void)removeCategoriesObject:(SessionCategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

- (void)addSpeakersObject:(Speaker *)value;
- (void)removeSpeakersObject:(Speaker *)value;
- (void)addSpeakers:(NSSet *)values;
- (void)removeSpeakers:(NSSet *)values;

@end
