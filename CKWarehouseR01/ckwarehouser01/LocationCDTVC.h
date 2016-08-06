 //
//  LocationCDTVC.h
//  CKWarehouseR01
//
//  Created by Melba Avila on 11/29/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface LocationCDTVC : UITableViewController <NSFetchedResultsControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIAlertView *alert;


-(void) showTextEntryAlert;

@end
