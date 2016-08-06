//
//  SearchItemDetailVC.m
//  ckwarehouser01
//
//  Created by Alejandro Zarza Martinez on 12/6/15.
//  Copyright (c) 2015 Alejandro Zarza Martinez. All rights reserved.
//

#import "SearchItemDetailVC.h"
#import "Shelf+Create.h"
#import "Item.h"
#import "Photo.h"

@interface SearchItemDetailVC ()

@end

@implementation SearchItemDetailVC

@synthesize imageView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"array: %@", self.detailItem);
    Item *items = self.detailItem;
    self.lblLocation.text = [items locationTitle];
    self.lblSection.text = [items sectionTitle];
    self.lblShelf.text = [items shelfTitle];
    self.lblStyle.text = [NSString stringWithFormat:@"%@ %@", @"Style: ", [items style]];
    self.lblColor.text = [NSString stringWithFormat:@"%@ %@", @"Color: ", [items color]];
    self.lblDescription.text = [NSString stringWithFormat:@"%@ %@", @"Description: ", [items name]];
    self.imageView.image = items.photo.image;
    self.lblBarCode.text = [NSString stringWithFormat:@"%@ %@", @"Bar Code:",items.barCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end