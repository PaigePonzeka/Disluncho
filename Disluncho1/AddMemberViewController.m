//
//  AddMemberViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/28/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "AddMemberViewController.h"
#import <MessageUI/MessageUI.h>



@implementation AddMemberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
/* makes keyboard disappear on enter */
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
	[theTextField resignFirstResponder];
	return TRUE;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	//set up pointer to the root
	root = (Disluncho1AppDelegate*)[UIApplication sharedApplication].delegate;
	
    //set navigation bar title
    self.title = @"Add a member";
    
    //set 
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithMember)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
    member_email.borderStyle =UITextBorderStyleRoundedRect;

}
/*Send an email*/
- (void) sendEmailTo:(NSString *)to {
    NSString *body = @"A User has invited you to Disluncho, Download the App at the iTunes Store to take part...Just kidding It's currently unavailable.";
    NSString *subject = @"Disluncho Invite";
	NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
							[to stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
							[subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
							[body  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
}
-(IBAction) setPhoto:(id) sender
{
    NSLog(@"Changing to Add Photo Screen");
    
    //set the appdelegate global varable to determine if the photo is for users, places or groups
    root.image_type = 3; 
    //switch to the add photo screen
    PhotoViewController *photoAdder = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:nil];
    [self.navigationController pushViewController:photoAdder animated:YES];
    [photoAdder release];
}
-(void)doneWithMember
{
	NSMutableArray *userFromEmail;
	userFromEmail= [root sendAndRetrieve:[NSString stringWithFormat:@"action=GET_USER&email=%@",member_email.text]];
	//NSLog(@"got the email\n");
	if([userFromEmail count]==0){
		/* the email does not exist in the database send the person an email to join and add them later 
			have a pop up to tell the person that they cannot add the member now
		 */
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invite Them to Disluncho" message:[NSString stringWithFormat:@"The email provide doesn't match any of our current users.  Send an Invite to %@ and add them later.",member_email.text]
													   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
		[alert setDelegate:self];
		[alert show];
		[alert release];

      	}
	else{
		NSString *addMemberParams = [NSString stringWithFormat:@"action=ADD_MEMBER&user=%i&group=%i",
									 [[[userFromEmail objectAtIndex:0]objectAtIndex:0]intValue ],
									 [root GroupUNID]];
		[root send:addMemberParams];
			//get the email address of the new member
		NSLog(@"Done Adding Member with Name: %@", [[userFromEmail objectAtIndex:0]objectAtIndex:1]);

		//pop this view off the screen (back to the previous view)
		[self.navigationController popViewControllerAnimated:YES];
	}
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex ==0)//cancel button 
	{
		member_email.placeholder = @"Email Address";
        member_email.text = @"";
	}
	else
	{		
		NSLog(@"Sending Email to: %@ Asking Them to Join", member_email.text);
        //send email to the user
        [self sendEmailTo: member_email.text];
        member_email.placeholder = @"Email Address";
        member_email.text = @"";

	}
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
