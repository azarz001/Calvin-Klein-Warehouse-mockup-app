//
//  SearchItemDetailVC.h
//  ckwarehouser01
//
//  Created by Alejandro Zarza Martinez on 12/6/15.
//  Copyright (c) 2015 Alejandro Zarza Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchItemDetailVC : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) NSMutableArray *detailItem;

@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblSection;
@property (strong, nonatomic) IBOutlet UILabel *lblShelf;

@property (strong, nonatomic) IBOutlet UILabel *lblStyle;
@property (strong, nonatomic) IBOutlet UILabel *lblColor;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblBarCode;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;



@end
