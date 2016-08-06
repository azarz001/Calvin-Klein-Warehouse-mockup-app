//
//  Location+Create.h
//  GroupHCalvinKleinsProject
//
//  Created by Melba Avila on 11/29/15.
//  Copyright (c) 2015 alejandro zarza martinez. All rights reserved.
//

#import "Location.h"

@interface Location (Create)

+ (Location *) locationWithName:(NSString *)title
         inManagedObjectContext:(NSManagedObjectContext *)context;


@end
