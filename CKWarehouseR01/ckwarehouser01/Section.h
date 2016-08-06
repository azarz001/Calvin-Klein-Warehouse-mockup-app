//
//  Section.h
//  CKWarehouseR01
//
//  Created by Melba Avila on 12/2/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location, Shelf;

@interface Section : NSManagedObject

@property (nonatomic, retain) NSNumber * orderValue;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * locationTitle;
@property (nonatomic, retain) NSSet *listShelves;
@property (nonatomic, retain) Location *location;
@end

@interface Section (CoreDataGeneratedAccessors)

- (void)addListShelvesObject:(Shelf *)value;
- (void)removeListShelvesObject:(Shelf *)value;
- (void)addListShelves:(NSSet *)values;
- (void)removeListShelves:(NSSet *)values;

@end
