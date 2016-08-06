//
//  SearchViewCDTVC.h
//  CKWarehouseR01
//
//  Created by Alejandro Zarza Martinez on 12/5/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewCDTVC : UITableViewController <UISearchBarDelegate>


@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableArray *searchResult1;
@property (strong, nonatomic) NSArray *searchMatches;



@end
