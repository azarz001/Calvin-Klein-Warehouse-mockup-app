//
//  Location+Create.m
//  GroupHCalvinKleinsProject
//
//  Created by Melba Avila on 11/29/15.
//  Copyright (c) 2015 alejandro zarza martinez. All rights reserved.
//

#import "Location+Create.h"

@implementation Location (Create)

+ (Location *) locationWithName:(NSString *)title
         inManagedObjectContext:(NSManagedObjectContext *)context
{
    Location *location = nil;
    
    //write code to create a new location
    if ([title length]) {
        
        //check to see if this location exist
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
        request.predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        
        
        //Array is nil or have more than one match
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            //Doesn't exist so need to create
            NSFetchRequest *requestCount = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
            
            NSError *error;
            NSArray *Location = [context executeFetchRequest:requestCount error:&error];
            
            location = [NSEntityDescription insertNewObjectForEntityForName:@"Location"
                                                         inManagedObjectContext:context];
            
            location.title = title;
            
            location.orderValue = [NSNumber numberWithDouble: [Location count] +1]; //need to increment orderValue
            
        } else {
            
            //already exist so return the one that's there
            location = [matches lastObject];
            
        }
    }
    
    return location;
}


@end
