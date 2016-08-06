//
//  Item+Extends.m
//  GroupHCalvinKleinsProject
//
//  Created by Melba Avila on 11/29/15.
//  Copyright (c) 2015 alejandro zarza martinez. All rights reserved.
//

#import "Item+Extends.h"


@implementation Item (Extends)



+(Item *) addItemWithDescription:(NSString *)itemDescription
                       withColor:(NSString *)itemColor
                       withStyle:(NSString *)itemStyle
                    withLocation:(NSString *)itemLocation
                     withSection:(NSString *)itemSection
                       withShelf:(NSString *)itemShelf
          inManagedObjectContext:(NSManagedObjectContext *)context
{
    //returns YES if created and NO if not
    
    
    Item *item = nil;
    
    //check to see if this item description exist may want to add more checks
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", itemDescription];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    
    //Array is nil or have more than one match
    if (!matches || ([matches count] > 1)) {
        // handle error somehow
    } else if (![matches count]) {
        
        //Doesn't exist so need to create
        
        item = [NSEntityDescription insertNewObjectForEntityForName:@"Item"
                                                 inManagedObjectContext:context];
        
        item.name = itemDescription;
        item.color = itemColor;
        item.style = itemStyle;
        item.locationTitle = itemLocation;
        item.sectionTitle = itemSection;
        item.shelfTitle = itemShelf;
        
        
    }
    
    return item;
    
}

@end
