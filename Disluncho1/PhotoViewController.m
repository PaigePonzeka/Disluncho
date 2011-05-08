//
//  PhotoViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 5/3/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "PhotoViewController.h"


@implementation PhotoViewController
@synthesize imageView,choosePhotoBtn,takePhotoBtn, root, selectedImage;

-(IBAction) getPhoto:(id) sender {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
	if((UIButton *) sender == choosePhotoBtn) {
        if(isImageSelected) //button is confirm, save the picture to the documents
        {
            //determine what folder to use
            NSString *folder; 
            if(root.image_type ==1) //set the path to groups
            {
                folder = @"groups/";
            }
            else if(root.image_type == 2) //set the path to places
            {
                folder = @"places/";
            }
            else
            {
                folder = @"users/";
            }
            //determine the file name
            NSString *filename; 
            /*put in the code to determine a generic file name*/
            filename;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];

            
            NSFileManager *manager = [NSFileManager defaultManager];
            
            //checking the files at the location get an array of all the files
            NSString *pathToCheck = [NSString stringWithFormat: @"%@/%@",documentsDirectory,folder];
            NSArray *fileList = [manager directoryContentsAtPath:pathToCheck];
                      
            //if the folder is empty then set the name to 00
            if(fileList.count ==0 )
            {
               filename = @"0.png"; 
            }
            else
            {
                //get the filename of the last listed file
                NSString *lastFileName = [fileList lastObject];
                //remove .png from the string
                lastFileName=[lastFileName stringByReplacingOccurrencesOfString:@".png" withString:@""];
                //convert it to an int
                int fileNumber = [lastFileName intValue];
                //increase it
                fileNumber = fileNumber +1;
                //set it to the new file name
                filename = [NSString stringWithFormat:@"%i.png", fileNumber];
            }
            //NSString lastFile = 
            NSString *saveFile = [[documentsDirectory stringByAppendingPathComponent:folder]stringByAppendingPathComponent:filename];
            
            NSData *imageData =  UIImagePNGRepresentation(selectedImage);
            [imageData writeToFile:saveFile atomically:YES];
            NSLog(@" file is %@", saveFile);
            //see if the files were written
            // Create file manager
           /* NSError *error;
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            
            // Write out the contents of home directory to console
            NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);*/

        }
        else //behave like normal
        {
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
		
	} else {
        if(isImageSelected) //button is cancel
        {
            //change the buttons back
            [choosePhotoBtn setTitle:@"Choose Photo" forState:UIControlStateNormal];
            [takePhotoBtn setTitle:@"Take Photo" forState:UIControlStateNormal];
           
            //reset isImageselected
            isImageSelected = false;
        }
        else //behave like normal
        {
            //check to see if camera is supported on current device
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;  
        }
		
	}
    
	[self presentModalViewController:picker animated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
    //user selected an image
	imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //get the image data from the image in the view
    selectedImage = imageView.image; 
    //the user has selected an image 
    isImageSelected = true;
    //user has selected an image change buttons to confirm or cancel their choice
    [choosePhotoBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    [takePhotoBtn setTitle:@"Cancel" forState:UIControlStateNormal];
}
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Loading Photo View Controller");
    
    //set up pointer to the root
	root = (Disluncho1AppDelegate*)[UIApplication sharedApplication].delegate;

    //initialize isImageSelected
    isImageSelected = false;
    //check to see if camera is supported on device
        //if it isn't disable the "Take Picture" button
    
   }

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
