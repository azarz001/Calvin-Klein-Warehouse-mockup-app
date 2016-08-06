//
//  AnalysisViewController.h
//  GroupHCalvinKleinsProject
//
//  Created by rashad mosley whyce on 12/3/15.
//  Copyright (c) 2015 alejandro zarza martinez. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Item.h"


@interface  AnalysisViewController :UITableViewController <MFMailComposeViewControllerDelegate>
{
    NSMutableArray *controllers;
}
@property (strong, nonatomic) NSString *itemSection;
@property (strong, nonatomic) NSString *itemLocation;

//@property (strong, nonatomic) NSMutableArray *itemSection;
//@property (strong, nonatomic) NSMutableArray *itemLocation;
@property (strong, nonatomic) NSMutableArray *itemStyle;
@property (strong, nonatomic) NSMutableArray *itemStyleWithQty;
@property (strong, nonatomic) NSMutableArray *itemShelf;
- (IBAction)didTapBringInventory:(id)sender;

@property (nonatomic,retain)NSMutableArray *controllers;
-(IBAction)showEmail:(id)sender;

@end

