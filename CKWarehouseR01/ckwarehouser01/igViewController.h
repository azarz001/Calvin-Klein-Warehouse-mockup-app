//
//  igViewController.h
//  ScanBarCodes
//
//  Created by Torrey Betts on 10/10/13.
//  Copyright (c) 2013 Infragistics. All rights reserved.
//


#import <UIKit/UIKit.h>

@class igViewController;

@protocol igViewControllerDelegate <NSObject>
-(void) addItemViewController:(igViewController *)controller barCodeScanString:(NSString *) barCodeResult;

@end


@interface igViewController : UIViewController

@property (nonatomic, weak) id<igViewControllerDelegate> delegate;

- (IBAction)btnCancel:(id)sender;



@end

