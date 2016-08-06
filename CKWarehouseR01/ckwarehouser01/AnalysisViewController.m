
//
//  AnalysisViewController.m
//  GroupHCalvinKleinsProject
//
//  Created by rashad mosley whyce on 12/2/15.
//  Copyright (c) 2015 alejandro zarza martinez. All rights reserved.
//


#import "AnalysisViewController.h"
#import "AppDelegate.h"
#import "Item.h"


@implementation AnalysisViewController
@synthesize  controllers;




-(void) viewWillAppear:(BOOL)animated{
    [super viewDidLoad];
    
    self.itemShelf = [[NSMutableArray alloc] init];
    self.itemStyle = [[NSMutableArray alloc] init];
    self.itemStyleWithQty = [[NSMutableArray alloc] init];
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    //inventory count of records
    NSUInteger count = [context countForFetchRequest: request error: &error];
    if ([objects count] == 0)
    {
        NSLog(@"No Matches");
    }
    else
    {
        
        
        for (int i = 0; i < [objects count]; i++)
        {
            //prints objects to console
            NSLog(@"test %@", ((Item*)[objects objectAtIndex:i]).style);
            
            
            
            //adds item to table view
            [self.itemStyle addObject:((Item*)[objects objectAtIndex:i]).style];
            
            
        }
        
        //number of items in inventory
        NSArray *countItem = self.itemStyle;
        
        //place the inventory items in set
        NSCountedSet *set = [[NSCountedSet alloc] initWithArray:countItem];
        
        //total inventory item count
        NSString *InvCount = [NSString stringWithFormat:@"%lu", count];
        
        
        //concatenate first cell " Totalt InventoryItems"
        NSString *totalInv = [[@"Total Inventory items:" stringByAppendingString:@" " ]stringByAppendingString:InvCount];
        
        //add total inventory count io list
        [self.itemStyleWithQty addObject:totalInv];

        //count number of times inventory item in the list that are the same style
        for (id item in set)
        {
            
            NSLog(@"Name=%@, Count=%lu", item, (unsigned long)[set countForObject:item]);
            
            NSString *itemStyleName = item;
            NSString *itemStyleCount = [NSString stringWithFormat:@"%ld",[set countForObject:item]];
            NSString *ItemAnylisis = [[itemStyleName stringByAppendingString:@" X " ]stringByAppendingString:itemStyleCount];
            
            [self.itemStyleWithQty addObject:ItemAnylisis];
        }
    }
    //reload table view
    [self.tableView reloadData];
   
    
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.itemStyleWithQty count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnalysisViewController"];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AnalysisViewController"];
    }
    
    cell.textLabel.text = [self.itemStyleWithQty objectAtIndex:indexPath.row];
    
    return cell;
}

-(IBAction)showEmail:(id)sender
{
    // Email Subject
    NSString *emailTitle = @"Email";
    // Email Content
    NSString *messageBody = @"iOS programming is so fun!";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            
            
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)didTapBringInventory:(id)sender {
    [self performSegueWithIdentifier:@"SeagueToInventoryList" sender:self];
}
@end