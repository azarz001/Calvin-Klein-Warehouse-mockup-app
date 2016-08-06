//
//  Location.h
//  CKWarehouseR01
//
//  Created by Melba Avila on 12/2/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Section;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * orderValue;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *listSections;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addListSectionsObject:(Section *)value;
- (void)removeListSectionsObject:(Section *)value;
- (void)addListSections:(NSSet *)values;
- (void)removeListSections:(NSSet *)values;

@end
