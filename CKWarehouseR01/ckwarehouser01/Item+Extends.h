//
//  Item+Extends.h
//  GroupHCalvinKleinsProject
//
//  Created by Melba Avila on 11/29/15.
//  Copyright (c) 2015 alejandro zarza martinez. All rights reserved.
//

#import "Item.h"


@interface Item (Extends)



+(Item *)addItemWithDescription:(NSString *)itemDescription
                    withColor:(NSString *)itemColor
                    withStyle:(NSString *)itemStyle
                 withLocation:(NSString *)itemLocation
                  withSection:(NSString *)itemSection
                    withShelf:(NSString *)itemShelf
       inManagedObjectContext:(NSManagedObjectContext *)context;




@end
