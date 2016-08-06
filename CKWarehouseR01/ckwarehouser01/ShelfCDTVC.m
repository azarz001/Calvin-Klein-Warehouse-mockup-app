//
//  ShelfCDTVC.m
//  CKWarehouseR01
//
//  Created by Melba Avila on 11/30/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import "ShelfCDTVC.h"
#import "SectionCDTVC.h"
#import "LocationCDTVC.h"
#import "DetailViewController.h"
#import "Shelf+Create.h"
#import "Location+Create.h"
#import "Section+Create.h"
#import "Item.h"

@interface ShelfCDTVC ()

@end

@implementation ShelfCDTVC

-(void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.navigationItem.backBarButtonItem = backButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showTextEntryAlert
{
    self.alert = [[UIAlertView alloc] initWithTitle:@"New Shelf" message:@"Please Enter a New Shelf"
                                           delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Ok", nil];
    
    self.alert.alertViewStyle = UIAlertViewStylePlainTextInput;
}

//Shelf Title Exist or Empty Alert
-(void)showInputValidationAlert:(NSString *)message
{
    self.alert = [[UIAlertView alloc] initWithTitle:@"Input Shelf Error" message:message
                                           delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Ok", nil];
    
    self.alert.alertViewStyle = UIAlertViewStylePlainTextInput;
}

- (void)insertNewObject:(id)sender {
    
    [self showTextEntryAlert];
    [self.alert show];
    
}

//gets object sent from previous controller
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != managedObjectContext) {
        _managedObjectContext = managedObjectContext;
        
    }
}


//gets MO sent from previous controller - Section
- (void)setSectionItem:(id)newSectionItem
{
   
        _SectionItem = newSectionItem;
        

}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //NSManagedObjectContext *context = [self.fetchedResultsControllerSection managedObjectContext];
        
        //get title entered by user in Alert View
        NSString *shelfTitle = [self.alert textFieldAtIndex:0].text;
        NSString *sectionTitle = [self.SectionItem title];
        NSString *locTitle = [self.SectionItem locationTitle];
        
        //Input Validation
        [self checkLocationInput:shelfTitle];
              
        //Insert new Shelf
        [Shelf shelfWithName:shelfTitle
        shelfWithSectionName:sectionTitle
       shelfWithLocationName:locTitle
      inManagedObjectContext:self.managedObjectContext];
        
        // Save the context.
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        //Update View Controller
        [self.tableView reloadData];
    }
}

#pragma mark - Input Validatation

-(void)checkLocationInput:(NSString *)shelfName
{
    NSLog(@"Whoops, I've made it into checkLocationInput");
    
    if (![shelfName length])//Empty Title Name
    {
        NSString *message = (@"Shelf Name can't be blank. Please Enter a New Shelf");
        [self showInputValidationAlert:message];
        [self.alert show];
        
    }else{
        
        //check to see if this location exist
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Shelf"];
        request.predicate = [NSPredicate predicateWithFormat:@"title = %@", shelfName];
        
        NSError *error;
        NSArray *matches = [self.managedObjectContext executeFetchRequest:request error:&error];
        
        
        if ([matches count])//Already Exist Title Name
        {
            NSLog(@"Whoops, I've made it into matches Count");
            
            NSString *message = (@"Shelf Name Already Exist. Please Enter a New Shelf");
            [self showInputValidationAlert:message];
            [self.alert show];
        }
    }
    
}


#pragma mark - Managing the detail item

//if i get anything from location

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Sends moc to shelf
    [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
    
    //sends shelf object to next view
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSManagedObject *object = [[self fetchedResultsControllerSection] objectAtIndexPath:indexPath];
    [[segue destinationViewController] setDetailItem:object];
    
   
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsControllerSection sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsControllerSection sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsControllerSection managedObjectContext];
        [context deleteObject:[self.fetchedResultsControllerSection objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Shelf *shelf = [self.fetchedResultsControllerSection objectAtIndexPath:indexPath];
    Item *item = shelf.item;
    
    cell.textLabel.text = shelf.title;
    
    if (!item) {
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Empty Shelf"];
        cell.imageView.image = nil;
    }else{
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  -  %@  -  %@", item.style, item.color, item.name];
        cell.imageView.image = item.thumbnail;
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsControllerSection
{
    if (_fetchedResultsControllerSection != nil) {
        return _fetchedResultsControllerSection;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shelf" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    //Only want from location and section we came from
    NSString *SectionTitle = [self.SectionItem title];
    NSString *LocationTitle = [self.SectionItem locationTitle];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(section.title = %@) AND (section.locationTitle = %@)", SectionTitle, LocationTitle];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsControllerSection = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsControllerSection performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsControllerSection;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

@end
