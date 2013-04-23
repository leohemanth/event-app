//
//  Speaker.h
//  event
//
//  Created by Hemanth Prasad on 12/04/13.
//  Copyright (c) 2013 Hemanth Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Links, Session;

@interface Speaker : NSManagedObject

@property (nonatomic, retain) NSSet *sessions;
@property (nonatomic, retain) NSSet *links;
@end

@interface Speaker (CoreDataGeneratedAccessors)

- (void)addSessionsObject:(Session *)value;
- (void)removeSessionsObject:(Session *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

- (void)addLinksObject:(Links *)value;
- (void)removeLinksObject:(Links *)value;
- (void)addLinks:(NSSet *)values;
- (void)removeLinks:(NSSet *)values;

@end
