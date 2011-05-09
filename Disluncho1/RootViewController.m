//
//  RootViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "RootViewController.h"




@implementation RootViewController
@synthesize root, login_name, login_email,photo_path, hasSetPicture;;




- (void)viewDidLoad
{
    [super viewDidLoad];
	
    hasSetPicture = false;
	//set up pointer to the root
	root = (Disluncho1AppDelegate*)[UIApplication sharedApplication].delegate;
	
	USERUNID = 0;
	
    //change the navigation bar title 
    self.title = @"Register";
    
    //create an add a done button to the right navigation bar
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(registerUser:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];

    //set the height of the login_name text field
    login_name.borderStyle = UITextBorderStyleRoundedRect;
    
    //photoAdder = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:nil];

        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
//loading image from Documents
- (UIImage*)loadImage:(NSString*)imgName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imgName]];
	return [UIImage imageWithContentsOfFile:fullPath];
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(hasSetPicture)
    {
        add_photo.hidden = YES;
        //add the image view to that position instead
        //remove .png from the file 
        NSString *withoutPNG = [root.imageFileString stringByReplacingOccurrencesOfString:@".png" withString:@""];

        UIImageView *userImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
        UIImage *myUIImage = [self loadImage: withoutPNG];
        userImageView.image = myUIImage;
        [self.view addSubview:userImageView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}
/*Called when user selected option to add a Photo to a newly created eatery*/
-(IBAction) setPhoto:(id) sender
{
    NSLog(@"Changing to Add Photo Screen");
    hasSetPicture=true;
    //set the appdelegate global varable to determine if the photo is for users, places or groups
    root.image_type = 3; //set value to users
    //switch to the add photo screen
    PhotoViewController *photoAdder = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:nil];
    [self.navigationController pushViewController:photoAdder animated:YES];
    [photoAdder release];
    }

-(void) registerUser:(UIBarButtonItem*)button
{
    NSLog(@"Register User");
	//commented out for testing purposes to easily just set useruid
	NSString *loginParams = [[[NSString stringWithString:@"action=LOGIN"]
							   stringByAppendingFormat:@"&email=%@",login_email.text]
							 stringByAppendingFormat:@"&username=%@",login_name.text];
	NSMutableArray *login = [root sendAndRetrieve:loginParams];
	
	if([login count]==0){
		//some sort of error message
	}
	else {
		[root setUserUNID:[[[login objectAtIndex:0]objectAtIndex:USERUNID] intValue]];
		[root setUserPhoto:[[login objectAtIndex:0]objectAtIndex:USERPHOTO]];

		//push Groups View controller to the front
		GroupsViewController *groupview = [[GroupsViewController alloc] initWithNibName:@"GroupsViewController" bundle:nil];
		[self.navigationController pushViewController:groupview animated:YES];
        [groupview release];
	}

}

/* makes keyboard disappear on enter */
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
	[theTextField resignFirstResponder];
	return TRUE;
}
/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [login_name release];
    //[photoAdder release];

    [super dealloc];
}

@end
