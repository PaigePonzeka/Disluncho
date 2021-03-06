//
//  PhotoViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 5/3/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "PhotoViewController.h"


@implementation PhotoViewController
@synthesize imageView,choosePhotoBtn,takePhotoBtn, root, selectedImage, isImageSelected;

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
            NSString* filename; 
        
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];

            
            NSFileManager *manager = [NSFileManager defaultManager];
            
            //checking the files at the location get an array of all the files
            NSString *pathToCheck = [NSString stringWithFormat: @"%@/%@",documentsDirectory,folder];
            NSArray *fileList = [manager directoryContentsAtPath:pathToCheck];
                      

            //pop the view controller
            [self.navigationController popViewControllerAnimated:YES];
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
            NSString *saveFile = [[documentsDirectory stringByAppendingPathComponent:folder]stringByAppendingPathComponent:filename];
            
            //get the path relative to the file inside the document section of the applicaiton
            NSArray *folders = [saveFile componentsSeparatedByString: @"/"];
            //save the saveFile to the root
            NSMutableString *applicationFilePath=[[NSMutableString alloc]init];
            int i;
            for(i =([folders count]-2); i<([folders count]); i++)
            {
                NSLog(@"%@",[folders objectAtIndex:i]);
                [applicationFilePath appendFormat:@"%@",[folders objectAtIndex:i]];
                if(i!=([folders count]-1))
                {
                    [applicationFilePath appendFormat:@"%/"];
                }

               
            }
            //set the root imagefilestring
            root.imageFileString = applicationFilePath;
            
            NSData *imageData =  UIImagePNGRepresentation(selectedImage);
            [imageData writeToFile:saveFile atomically:YES];
            NSLog(@" file is %@ ... %@", applicationFilePath, root.imageFileString);
            //upload the image to the web
            [self uploadImage:folder:filename];

            
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
/*upload the image to the server*/
- (void)uploadImage: (NSString*) folder: (NSString*) filename {
    
	NSData *imageData = UIImagePNGRepresentation(selectedImage);
	// setting up the URL to post to
	NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@%@",@"http://ponzeka.com/iphone_disluncho/images/", folder,@"upload.php"];
    NSLog(@"Sending File to: %@", urlString);
	// setting up the request object now
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    
    
NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
	/*
	 now lets create the body of the post
     */
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	// setting the body of the post to the reqeust
	[request setHTTPBody:body];
    
	// now lets make the connection to the web
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
	NSLog(@"%@",returnString);
}
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
