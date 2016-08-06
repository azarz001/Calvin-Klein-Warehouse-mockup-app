//
//  ShelfCDTVC.h
//  CKWarehouseR01
//
//  Created by Melba Avila on 11/30/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ShelfCDTVC : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsControllerSection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIAlertView *alert;
@property (strong, nonatomic) id SectionItem;


-(void) showTextEntryAlert;


@end
