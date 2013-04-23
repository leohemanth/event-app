//
//  Event.h
//  event
//
//  Created by Hemanth Prasad on 12/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Session, myLocation;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSNumber * event_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * no_of_days;
@property (nonatomic, retain) NSDate * start_date;
@property (nonatomic, retain) NSDate * updated_on;
@property (nonatomic, retain) NSSet *speakers;
@property (nonatomic, retain) NSSet *locations;
@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addSpeakersObject:(Session *)value;
- (void)removeSpeakersObject:(Session *)value;
- (void)addSpeakers:(NSSet *)values;
- (void)removeSpeakers:(NSSet *)values;

- (void)addLocationsObject:(myLocation *)value;
- (void)removeLocationsObject:(myLocation *)value;
- (void)addLocations:(NSSet *)values;
- (void)removeLocations:(NSSet *)values;

@end
