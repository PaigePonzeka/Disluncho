//
//  AddMemberViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/28/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "AddMemberViewController.h"


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
-(void)doneWithMember
{
	NSMutableArray *userFromEmail;
	userFromEmail= [root sendAndRetrieve:[NSString stringWithFormat:@"action=GET_USER&email=%@",member_email.text]];
	NSLog(@"got the email\n");
	if([userFromEmail count]==0){
		/* the email does not exist in the database send the person an email to join and add them later 
			have a pop up to tell the person that they cannot add the member now
		 */
		NSLog(@"No User was found with Email: %@ <--- need to ask them to join", member_email.text);

		member_email.placeholder = @"Email Address";
        [self sendEmailTo: member_email.text];
        member_email.text = @"";
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
