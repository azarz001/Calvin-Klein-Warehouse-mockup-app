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

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>

#import "igViewController.h"
#import "Item.h"

@interface DetailViewController : UIViewController <UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate, igViewControllerDelegate>

@property  (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblSection;
@property (strong, nonatomic) IBOutlet UILabel *lblShelf;
@property (strong, nonatomic) IBOutlet UILabel *lblBarScanItem;

@property (strong, nonatomic) IBOutlet UITextField *userStyleInput;
@property (strong, nonatomic) IBOutlet UITextField *userColorInput;
@property (strong, nonatomic) IBOutlet UITextField *userDescriptionInput;

@property (retain, nonatomic) UIBarButtonItem *editButton;
@property (retain, nonatomic) UIBarButtonItem *doneButton;
@property (retain, nonatomic) UIBarButtonItem *saveButton;

-(void) testItems;

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *itemImage;


- (IBAction)btnAddPhoto:(id)sender;
- (IBAction)btnChoosePhoto:(id)sender;
- (IBAction)btnDeletePhoto:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btnAddPhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnChoosePhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnDeletePhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnBarScan;



@property (strong, nonatomic) IBOutlet UIButton *btnDeleteItem;
- (IBAction)btnDeleteItem:(id)sender;

@end

