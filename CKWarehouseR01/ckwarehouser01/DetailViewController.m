//
//PROGRAMMERS: Melba Avila
//
//CLASS: COP465501 TR 5:00
//
//INSTRUCTOR: Steve Luis ECS 282
//
//ASSIGNMENT:  Group Project
//
//DUE:  Thursday 12/10/15
//

#import "DetailViewController.h"
#import "Shelf+Create.h"
#import "Item.h"
#import "Photo.h"

@interface DetailViewController ()




@end

@implementation DetailViewController
{
    Shelf *myShelfItem;
    Item *myItem;
    
    NSString *myBarScanResults;
    
    NSString *myItemDescription;
    NSString *myItemColor;
    NSString *myItemStyle;
    
    UIImage *myThumbnail;
    
    BOOL isEditMode;
    BOOL hasCamera;
    BOOL isNewObject;
    
}

@synthesize userStyleInput, userColorInput, userDescriptionInput,editButton, doneButton, saveButton, imageView, itemImage, btnAddPhoto, btnChoosePhoto, btnDeletePhoto, btnDeleteItem;

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //used for the textField Responders
    isEditMode = NO;
    
    //used when first save happens
    isNewObject = YES;
    
    //Camera
    hasCamera = YES;
    
    //Device has camera check
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // There is not a camera on this device, so don't show the camera button.
        self.btnAddPhoto.hidden = YES;
        hasCamera  = NO;
    }
    
    //Value from Shelf
    myShelfItem = (Shelf *)self.detailItem;
    myItem = myShelfItem.item;
    

    //Create the two buttons
    saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(insertNewObject:)];
    editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editObject:)];
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneSaveObject:)];
    
    //If we are adding an Item we display Save Button
    if (!myItem)
    {
        NSLog(@"Item is Empty");
        self.navigationItem.rightBarButtonItem = saveButton;
        
        //Enable Editing from beginning because it's new item
        self.userStyleInput.userInteractionEnabled = YES;
        self.userDescriptionInput.userInteractionEnabled = YES;
        self.userColorInput.userInteractionEnabled = YES;
        self.btnBarScan.userInteractionEnabled = YES;
        
        if (hasCamera)
        {
            self.btnAddPhoto.hidden = NO;
        }
        self.btnChoosePhoto.userInteractionEnabled = YES;
        
        self.btnDeletePhoto.hidden = YES;
        self.btnDeleteItem.hidden = YES;
        
    }else{
        NSLog(@"Item is NOT Empty");
        //Else we are editing an Item we display Edit button
        self.navigationItem.rightBarButtonItem = editButton;
        
        //Enter values into textField because item exist
        self.userStyleInput.text = [myItem style];
        self.userColorInput.text = [myItem color];
        self.userDescriptionInput.text = [myItem name];
        self.lblBarScanItem.text = [myItem barCode];
        self.imageView.image = [myItem.photo image];
        
        //Disable editing until click on Edit Button
        self.userStyleInput.userInteractionEnabled = NO;
        self.userDescriptionInput.userInteractionEnabled = NO;
        self.userColorInput.userInteractionEnabled = NO;
        self.btnBarScan.userInteractionEnabled = NO;
        
        //Hide Photo Bottons
        self.btnAddPhoto.hidden = YES;
        self.btnChoosePhoto.hidden = YES;
        self.btnDeletePhoto.hidden = YES;
        self.btnDeleteItem.hidden = YES;
        
        //Already have data
        isNewObject = NO;
        
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
}

//gets object sent from previous controller
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != managedObjectContext) {
        _managedObjectContext = managedObjectContext;
        
    }
}

#pragma mark - Managing the detail item


//gets object sent from previous controller
- (void)setDetailItem:(id)newDetailItem {
    
    //Shelf Object
    _detailItem = (Shelf *)newDetailItem;

}

- (void) configureView
{
    
    // Update the user interface for the Loction, Section and Shelf Text
    if (self.detailItem) {
        
        self.lblLocation.text = [self.detailItem locationTitle];
        self.lblSection.text = [self.detailItem sectionTitle];
        self.lblShelf.text = [self.detailItem title];
        
    }
}


#pragma mark - Insert New Item Detail

- (void)insertNewObject:(id)sender  //Save Button Action Invoked
{
    
   //Add Item
    //Don't need to do an checks because to get here I've done checks and shelves can have duplicate items names, colors, styles
    Item *myNewItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
    
    // Create a new photo object and set the image.
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
    photo.image = self.imageView.image;
    
    // NEED Check to make sure input values are not empty
    
    //Grab textField inputs just in case user didn't click Return.
    myItemDescription = userDescriptionInput.text;
    myItemColor = userColorInput.text;
    myItemStyle = userStyleInput.text;
    
    
    myNewItem.name = myItemDescription;
    myNewItem.color = myItemColor;
    myNewItem.style = myItemStyle;
    myNewItem.locationTitle = [self.detailItem locationTitle];
    myNewItem.sectionTitle = [self.detailItem sectionTitle];
    myNewItem.shelfTitle = [self.detailItem title];
    myNewItem.shelf = self.detailItem; //sets shelf Object to item
    
    // Associate the photo object with the item.
    myNewItem.photo = photo;
    //Save Thumbnail
    myNewItem.thumbnail = myThumbnail;
    
    //Assign Bar Code
    myNewItem.barCode = myBarScanResults;
    
    NSError *error = nil;
    // Save the context.
    if (![self.managedObjectContext save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Whoops, couldn't save New Item: %@", [error localizedDescription]);
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        
    }
    
    //disable editing in UITextField and change Save button to EDIT
    
    //Disable editing until click on Edit Button
    self.userStyleInput.userInteractionEnabled = NO;
    self.userDescriptionInput.userInteractionEnabled = NO;
    self.userColorInput.userInteractionEnabled = NO;
    self.btnBarScan.userInteractionEnabled = NO;
    
    self.btnAddPhoto.hidden = YES;
    self.btnChoosePhoto.hidden = YES;
    self.btnDeletePhoto.hidden = YES;
    self.btnDeleteItem.hidden = YES;

    
    //show edit button
    self.navigationItem.rightBarButtonItem = self.editButton;
    
    //Isn't new item anymore
    isNewObject = NO;
    
    //Used to test if my enteries work.  comment out when not needed
    [self testItems];
  
}

#pragma mark - Edit Item Detail

- (void) editObject:(id)sender //Edit Button Action Invoked
{
    
    //Enable editing until click on Done Button
    self.userStyleInput.userInteractionEnabled = YES;
    self.userDescriptionInput.userInteractionEnabled = YES;
    self.userColorInput.userInteractionEnabled = YES;
    self.btnBarScan.userInteractionEnabled = YES;
    
    //Show Photo Bottons
    if (hasCamera)
    {
        self.btnAddPhoto.hidden = NO;
    }
    self.btnChoosePhoto.hidden = NO;
    self.btnDeletePhoto.hidden = NO;
    self.btnDeleteItem.hidden = NO;
    
    //show done button
    self.navigationItem.rightBarButtonItem = self.doneButton;
    
    //I'm in edit Mode
    isEditMode = YES;
}

- (void) doneSaveObject:(id)sender //Done Button Action Invoked
{
    NSLog(@"Whoops, I've made it into doneSave Item Detail");
    
    
    //NEED TO CHECK INPUT NOT EMPTY
    
    //Grab Values to update Item Detail Object
    myItemDescription = userDescriptionInput.text;
    myItemColor = userColorInput.text;
    myItemStyle = userStyleInput.text;
    myBarScanResults = self.lblBarScanItem.text;
    myThumbnail = myItem.thumbnail;
    
    // Create a new photo object and set the image.
    //Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
    //photo.image = self.imageView.image;
    
    //have to fetch existing item
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    
    //compound predicate (title and sectionTitle and locationTitle)
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"shelfTitle = %@", [self.detailItem title]]; //Shelf
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"sectionTitle = %@", [self.detailItem sectionTitle]];//Section
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"locationTitle = %@", [self.detailItem locationTitle]];//Location
    
    NSArray *array = @[predicate1, predicate2, predicate3];
    
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:(array)];
    
    NSError *error;
    
    //Find item to update
    Item *updateItem = [[self.managedObjectContext executeFetchRequest:request error:&error]lastObject];
    
    //updateItem nil no item match
    if (!updateItem)
    {
        // handle error
        NSLog(@"Whoops, couldn't edit Item (Item not Found): %@", [error localizedDescription]);
        abort();
    }else{
        
        updateItem.name = myItemDescription;
        updateItem.color = myItemColor;
        updateItem.style = myItemStyle;
        //updateItem.photo = photo;
        updateItem.thumbnail = myThumbnail;
        updateItem.barCode = myBarScanResults;
        
    }
    
    // Save the context.
    if (![self.managedObjectContext save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Whoops, couldn't save Done item Edit: %@", [error localizedDescription]);
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        
    }
    
    //Disable editing until click on Edit Button
    self.userStyleInput.userInteractionEnabled = NO;
    self.userDescriptionInput.userInteractionEnabled = NO;
    self.userColorInput.userInteractionEnabled = NO;
    self.btnBarScan.userInteractionEnabled = NO;
    
    //Hide Photo Bottons
    self.btnAddPhoto.hidden = YES;
    self.btnChoosePhoto.hidden = YES;
    self.btnDeletePhoto.hidden = YES;
    self.btnDeleteItem.hidden = YES;
    
    //show edit button
    self.navigationItem.rightBarButtonItem = editButton;
    
    //Out of edit Mode
    isEditMode = NO;
    
    [self testItems];//verify my changes are good
    
}


#pragma mark - TextField Delegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == userStyleInput){
        if (isEditMode) {
            [userStyleInput resignFirstResponder];
        }else{
            [userColorInput becomeFirstResponder];
        }
        
        myItemStyle = userStyleInput.text;
        //NSLog(@"TextField Style: %@", myItemStyle);
        
    }else if (textField == userColorInput){
        
        if (isEditMode) {
            [userColorInput resignFirstResponder];
        }else{
            [userDescriptionInput becomeFirstResponder];
        }
        
        myItemColor = userColorInput.text;
        //NSLog(@"TextField Color: %@", myItemColor);
        
    }else{
        
        //must be description
        [userDescriptionInput resignFirstResponder];
        myItemDescription = userDescriptionInput.text;
        //NSLog(@"TextField Description: %@", myItemDescription);
        
    }
    
    return TRUE;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [userStyleInput resignFirstResponder];
    [userColorInput resignFirstResponder];
    [userDescriptionInput resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];
}


#pragma mark - Scanner

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    [[segue destinationViewController] setDelegate:self];
    
}


//delegate from igViewController to get bar code results
-(void)addItemViewController:(igViewController *)controller barCodeScanString:(NSString *)barCodeResult
{
    NSLog(@"this was returned from igViewController %@", barCodeResult);
    
    myBarScanResults = barCodeResult;
    
    self.lblBarScanItem.text = myBarScanResults;
    
}


#pragma mark - Camera Image Interface


- (IBAction)btnChoosePhoto:(id)sender
{
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)btnDeletePhoto:(id)sender
{
    /*
     If the item already has a photo, delete the Photo object and dispose of the thumbnail.
     Because the relationship was modeled in both directions, the item's relationship to the photo will automatically be set to nil.
     */
    
    //have to fetch existing item
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    
    //compound predicate (title and sectionTitle and locationTitle)
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"shelfTitle = %@", [self.detailItem title]]; //Shelf
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"sectionTitle = %@", [self.detailItem sectionTitle]];//Section
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"locationTitle = %@", [self.detailItem locationTitle]];//Location
    
    NSArray *array = @[predicate1, predicate2, predicate3];
    
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:(array)];
    
    NSError *error;
    
    //Find item to delete photo and thumbnail
    Item *updateItem = [[self.managedObjectContext executeFetchRequest:request error:&error]lastObject];
    
    //updateItem nil no item match
    if (!updateItem)
    {
        // handle error
        NSLog(@"Whoops, couldn't find Item (btnDeletePhoto): %@", [error localizedDescription]);
        abort();
    }else{
        
        [self.managedObjectContext deleteObject:updateItem.photo];
        updateItem.thumbnail = nil;
    }
    
    if (![self.managedObjectContext save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Whoops, couldn't Delete Image and Thumbnail from Item: %@", [error localizedDescription]);
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    // Update the user interface appropriately.
    [self updatePhotoInfo];
    
}

- (IBAction)btnAddPhoto:(id)sender
{
  
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
}


- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
   
    
    //Create the picker object
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) //is going to use Camera
    {
        
        //The user wants to use the camera interface.
        // Specify the types of camera features available
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
        // Displays a control that allows the user to take pictures only.
        imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        
        
        // Hides the controls for moving & scaling pictures, or for
        // trimming movies. To instead show the controls, use YES.
        imagePickerController.allowsEditing = NO;
        
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)updatePhotoInfo
{
    // Synchronize the photo image view 
    UIImage *image = myItem.photo.image;
    
    self.imageView.image = image;
    
}

#pragma mark - Image picker delegate methods

//Whichever Media I use this returns my selections - Camera or Photo Library
- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    
    // Create an image and store the acquired picture
    UIImage  *imageToSave;
    imageToSave = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Save the new image to the Camera Roll
    //UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    
    // View the image on screen
    imageView.image = imageToSave;
    
    // Create a thumbnail version of the image for the item object.
    CGSize size = imageToSave.size;
    CGFloat ratio = 0;
    if (size.width > size.height) {
        ratio = 44.0 / size.width;
    }
    else {
        ratio = 44.0 / size.height;
    }
    CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [imageToSave drawInRect:rect];
    
    myThumbnail = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    if (isNewObject)
    {
        // Tell controller to remove the picker from the view hierarchy and release object.
        [self dismissViewControllerAnimated: YES completion: ^{[self doNothingElse];} ];
    }else{
        //Not new and need to save
        [self dismissViewControllerAnimated: YES completion: ^{[self saveToDatabase];} ];
    }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // The user canceled -- simply dismiss the image picker.
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void) doNothingElse
{
    NSLog(@"Camera Dismissed");
    
}

- (void) saveToDatabase
{
    NSLog(@"Not a new Item and Saving Photo");
    
    //if item has a photo need to delete it don't want ophrans out there
    Item *picSavingItem = myItem;
    NSLog(@"PhotoSaveToDatabase: %@", picSavingItem.name);
    
    if (picSavingItem.photo) {
        [self.managedObjectContext deleteObject:picSavingItem.photo];
        picSavingItem.thumbnail = nil;
    }
    
    // Create a new photo object and set the image.
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
    photo.image = self.imageView.image;
    
    //have to fetch existing item
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    
    //compound predicate (title and sectionTitle and locationTitle)
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"shelfTitle = %@", [self.detailItem title]]; //Shelf
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"sectionTitle = %@", [self.detailItem sectionTitle]];//Section
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"locationTitle = %@", [self.detailItem locationTitle]];//Location
    
    NSArray *array = @[predicate1, predicate2, predicate3];
    
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:(array)];
    
    NSError *error;
    
    //Find item to delete photo and thumbnail
    Item *photoUpdateItem = [[self.managedObjectContext executeFetchRequest:request error:&error]lastObject];
    
    //updateItem nil no item match
    if (!photoUpdateItem)
    {
        // handle error
        NSLog(@"Whoops, couldn't find Item (saveToDatabase): %@", [error localizedDescription]);
        abort();
    }else{
        
        photoUpdateItem.photo = photo;
        photoUpdateItem.thumbnail = myThumbnail;
    }
    
    if (![self.managedObjectContext save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Whoops, couldn't Save Photo to Item: %@", [error localizedDescription]);
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


#pragma mark - Detail ITEM

- (IBAction)btnDeleteItem:(id)sender
{
    //have to fetch existing Shelf Item to delete item from Shelf and it will cascade down because rules of Core Data
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Shelf"];
    
    //compound predicate (title and sectionTitle and locationTitle)
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"title = %@", [self.detailItem title]]; //Shelf
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"sectionTitle = %@", [self.detailItem sectionTitle]];//Section
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"locationTitle = %@", [self.detailItem locationTitle]];//Location
    
    NSArray *array = @[predicate1, predicate2, predicate3];
    
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:(array)];
    
    NSError *error;
    
    //Find item to delete
    Shelf *shelfItem = [[self.managedObjectContext executeFetchRequest:request error:&error]lastObject];
    
    //updateItem nil no item match
    if (!shelfItem)
    {
        // handle error
        NSLog(@"Whoops, couldn't find Item (btnDeleteItem): %@", [error localizedDescription]);
        abort();
    }else{
        
        [self.managedObjectContext deleteObject:shelfItem.item];
    }
    
    if (![self.managedObjectContext save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Whoops, couldn't Delete Item: %@", [error localizedDescription]);
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    //Return to shelf CDTVC once you delete item
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Testing Entries with NSLOG

//test if items are saved
-(void) testItems
{
    NSError *error;
    
    // Test listing all Item from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //compound predicate (title and sectionTitle and locationTitle
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"shelfTitle = %@",[self.detailItem title]]; //Shelf
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"sectionTitle = %@", [self.detailItem sectionTitle]];//Section
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"locationTitle = %@", [self.detailItem locationTitle]];//Location

    
    NSArray *array = @[predicate1, predicate2, predicate3];
    
    fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:(array)];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (Item *info in fetchedObjects)
    {
        NSLog(@"---------------");
        NSLog(@"Description: %@", info.name);
        NSLog(@"Color: %@", info.color);
        NSLog(@"Style: %@", info.style);
        NSLog(@"Bar Code: %@", info.barCode);
        NSLog(@"Location: %@", info.locationTitle);
        NSLog(@"Section: %@", info.sectionTitle);
        NSLog(@"Shelf: %@", info.shelfTitle);
        NSLog(@"---------------");
        
    }
    
}

@end
