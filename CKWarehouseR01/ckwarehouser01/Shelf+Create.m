//
//  Shelf+Create.m
//  CKWarehouseR01
//
//  Created by Melba Avila on 12/1/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import "Shelf+Create.h"
#import "Section+Create.h"

@implementation Shelf (Create)

+ (Shelf *) shelfWithName:(NSString *)title
     shelfWithSectionName:(NSString *)sectionTitle
    shelfWithLocationName:(NSString *)locationTitle
       inManagedObjectContext:(NSManagedObjectContext *)context
{
    Shelf *shelf = nil;
    
    //write code to create a new location
    if ([title length]) {
        
        //check to see if this location exist
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Shelf"];
        
        //compound predicate (title and sectionTitle and locationTitle
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"title = %@", title];
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"sectionTitle = %@", sectionTitle];
        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"locationTitle = %@", locationTitle];
        
        NSArray *array = @[predicate1, predicate2, predicate3];
        
        request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:(array)];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        
        
        //Array is nil or have more than one match
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            //Doesn't exist so need to create
            NSFetchRequest *requestCount = [NSFetchRequest fetchRequestWithEntityName:@"Shelf"];
            requestCount.predicate = [NSPredicate predicateWithFormat:@"(section.title = %@) AND (locationTitle = %@)", sectionTitle, locationTitle];
            
            NSError *error;
            NSArray *Shelf = [context executeFetchRequest:requestCount error:&error];
            
            shelf = [NSEntityDescription insertNewObjectForEntityForName:@"Shelf"
                                                    inManagedObjectContext:context];
            
            shelf.title = title;
            shelf.sectionTitle = sectionTitle;
            shelf.locationTitle = locationTitle;
            shelf.section = [Section sectionWithName:sectionTitle inManagedObjectContet:context];
            
            shelf.orderValue = [NSNumber numberWithDouble: [Shelf count] +1]; //need to increment orderValue
            
        } else {
            
            //already exist so return the one that's there
            shelf = [matches lastObject];
            
        }
    }
    
    return shelf;
}


@end
