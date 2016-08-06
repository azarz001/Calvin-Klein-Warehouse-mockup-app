//
//  Item.m
//  ckwarehouser01
//
//  Created by Melba Avila on 12/10/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import "Item.h"
#import "Photo.h"
#import "Shelf.h"
#import "ImageToDataTransformer.h"


@implementation Item

@dynamic color;
@dynamic locationTitle;
@dynamic name;
@dynamic orderingValue;
@dynamic sectionTitle;
@dynamic shelfTitle;
@dynamic style;
@dynamic thumbnail;
@dynamic barCode;
@dynamic photo;
@dynamic shelf;

+ (void)initialize
{
    if (self == [Item class]) {
        ImageToDataTransformer *transformer = [[ImageToDataTransformer alloc] init];
        [NSValueTransformer setValueTransformer:transformer forName:@"ImageToDataTransformer"];
    }
}

@end