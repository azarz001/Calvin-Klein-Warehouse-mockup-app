//
//  SearchViewCDTVC.m
//  CKWarehouseR01
//
//  Created by Alejandro Zarza Martinez on 12/5/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import "SearchViewCDTVC.h"
#import "AppDelegate.h"
#import "Item.h"
#import "SearchItemDetailVC.h"

@interface SearchViewCDTVC ()

@end

@implementation SearchViewCDTVC{
    NSString *searching1;
}


@synthesize searchMatches, searchResults;


-(void)viewWillAppear:(BOOL)animated
{
    //change searching to false since we are not searching
    searching1 = @"false";
    
    //initialize mutable array.
    self.searchResult1 = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    self.managedObjectContext = context;
    
    //get the Items from Core Data
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item"
                                              inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error;
    //filling arrays with the items in core data
    self.searchMatches = [self.managedObjectContext executeFetchRequest:request error:&error];
    self.searchResults = [[NSMutableArray alloc] initWithArray:self.searchMatches];
    
    //reload tablew view to get new data to show in the table view
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //check which array will be counted for the right number of rows
    if ([searching1  isEqualToString:@"true"]) {
        return [self.searchResult1 count];
    }else{
        return [self.searchResults count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchViewController"];
    
    if (!cell){
        //initialize the uitableViewCell if there isnt any
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchViewController"];
    }
    
    //If its searching in the search bar then show the results for the search
    if ([searching1  isEqualToString:@"true"]) {
        Item *itemDetail = self.searchResult1[indexPath.row];
        
        cell.textLabel.text = itemDetail.style;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Location - %@   Section - %@    Shelf - %@", itemDetail.locationTitle, itemDetail.sectionTitle, itemDetail.shelfTitle];
        cell.imageView.image = itemDetail.thumbnail;
    }else{
        //if its not searching then show the items in core data
        Item *itemDetail = self.searchResults[indexPath.row];
        
        cell.textLabel.text = itemDetail.style;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Location - %@   Section - %@    Shelf - %@", itemDetail.locationTitle, itemDetail.sectionTitle, itemDetail.shelfTitle];
        cell.imageView.image = itemDetail.thumbnail;
    }
    
    return cell;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //check if the the search bar is empty then change the string searching to false
    if ([searchText length] == 0) {
        //search bar is blank
        searching1 = @"false";
    }else{
        //If we are searching for something then remove the objects that were previously in the array.
        
        //We have text in search bar
        [self.searchResult1 removeAllObjects];
        
        //check if in the array we have what we are lookign for, and save the results for being displayed latter.
        for (Item *info in self.searchMatches) {
            NSRange r = [info.style rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound) {
                [self.searchResult1 addObject:info];
            }
            //change the searching tring to true since we are searching
            searching1 = @"true";
        }
        
    }
    //reload the tableview
    [self.tableView reloadData];
}



 #pragma mark - Navigation
 

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchItemDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SearchItemDetailVC *destViewController = segue.destinationViewController;
        destViewController.detailItem = [self.searchResults objectAtIndex:indexPath.row];
        //destViewController.title = [self.searchResult1 objectAtIndex:indexPath.row];
    }
}

//hide cancel button in search bar if the user is not searching
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

//show cancel button is search bar if the user is searching
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar becomeFirstResponder];
    [searchBar setShowsCancelButton:YES animated:YES];
    
}

//do something if the cancel button is clicked
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //set the text to nill and the searching string to false.
    searchBar.text = nil;
    searching1 = @"false";
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

@end
