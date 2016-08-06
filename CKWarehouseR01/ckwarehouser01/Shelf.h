//
//  Shelf.h
//  ckwarehouser01
//
//  Created by Melba Avila on 12/6/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item, Section;

@interface Shelf : NSManagedObject

@property (nonatomic, retain) NSString * locationTitle;
@property (nonatomic, retain) NSNumber * orderValue;
@property (nonatomic, retain) NSString * sectionTitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) Section *section;

@end
