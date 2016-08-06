//
//  Photo.h
//  ckwarehouser01
//
//  Created by Melba Avila on 12/6/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Photo : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) Item *item;

@end
