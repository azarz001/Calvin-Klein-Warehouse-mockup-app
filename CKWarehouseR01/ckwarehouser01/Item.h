//
//  Item.h
//  ckwarehouser01
//
//  Created by Melba Avila on 12/10/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo, Shelf;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * locationTitle;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderingValue;
@property (nonatomic, retain) NSString * sectionTitle;
@property (nonatomic, retain) NSString * shelfTitle;
@property (nonatomic, retain) NSString * style;
@property (nonatomic, retain) id thumbnail;
@property (nonatomic, retain) NSString * barCode;
@property (nonatomic, retain) Photo *photo;
@property (nonatomic, retain) Shelf *shelf;

@end
