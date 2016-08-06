//
//  Section+Create.m
//  CKWarehouseR01
//
//  Created by Melba Avila on 11/29/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import "Section+Create.h"
#import "Location+Create.h"

@implementation Section (Create)

+ (Section *) sectionWithName:(NSString *)title
      sectionWithLocationName:(NSString *)LocationTitle
         inManagedObjectContext:(NSManagedObjectContext *)context
{
    Section *section = nil;
    
    //write code to create a new location
    if ([title length]) {
        
        //check to see if this location exist
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Section"];
        request.predicate = [NSPredicate predicateWithFormat:@"(title = %@) AND (locationTitle = %@)", title, LocationTitle];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        
        
        //Array is nil or have more than one match
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            //Doesn't exist so need to create
            NSFetchRequest *requestCount = [NSFetchRequest fetchRequestWithEntityName:@"Section"];
            requestCount.predicate = [NSPredicate predicateWithFormat:@"location.title = %@", LocationTitle];
            
            NSError *error;
            NSArray *Section = [context executeFetchRequest:requestCount error:&error];
            
            section = [NSEntityDescription insertNewObjectForEntityForName:@"Section"
                                                     inManagedObjectContext:context];
            
            section.title = title;
            section.locationTitle = LocationTitle;
            section.location = [Location locationWithName:LocationTitle inManagedObjectContext:context];
            
            
            section.orderValue = [NSNumber numberWithDouble: [Section count] +1]; //need to increment orderValue
            
        } else {
            
            //already exist so return the one that's there
            section = [matches lastObject];
            
        }
    }
    
    return section;
}

+(Section *)  sectionWithName:(NSString *)title
        inManagedObjectContet:(NSManagedObjectContext *)context
{
    Section *section = nil;
    
    //check to see if this section exist
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Section"];
    request.predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    section = [matches lastObject];
    
    return section;
    
}


@end
