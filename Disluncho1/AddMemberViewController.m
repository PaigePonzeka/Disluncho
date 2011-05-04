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
-(void)doneWithMember
{
	NSString *addMemberParams = [NSString stringWithFormat:@"action=ADD_MEMBER&email=%@&group=%i",member_email.text,[root GroupUNID]];
	[root send:addMemberParams];
        //get the email address of the new member
    NSString *new_member_email=member_email.text;
    NSLog(@"Done Adding Member with Email: %@", new_member_email);

    //pop this view off the screen (back to the previous view)
    [self.navigationController popViewControllerAnimated:YES];
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
