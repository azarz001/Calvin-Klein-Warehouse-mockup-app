//
//  Section+Create.h
//  CKWarehouseR01
//
//  Created by Melba Avila on 11/29/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import "Section.h"

@interface Section (Create)

+ (Section *) sectionWithName:(NSString *)title
      sectionWithLocationName:(NSString *)LocationTitle
         inManagedObjectContext:(NSManagedObjectContext *)context;

+(Section *)  sectionWithName:(NSString *)title
        inManagedObjectContet:(NSManagedObjectContext *)context;

@end
