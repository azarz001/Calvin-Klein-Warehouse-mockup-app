//
//  Shelf+Create.h
//  CKWarehouseR01
//
//  Created by Melba Avila on 12/1/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import "Shelf.h"

@interface Shelf (Create)

+ (Shelf *) shelfWithName:(NSString *)title
     shelfWithSectionName:(NSString *)sectionTitle
    shelfWithLocationName:(NSString *)locationTitle
   inManagedObjectContext:(NSManagedObjectContext *)context;

@end
