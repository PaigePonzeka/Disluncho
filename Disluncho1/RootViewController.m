//
//  RootViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "RootViewController.h"




@implementation RootViewController
@synthesize root;
//@synthesize login_name=_login_name;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
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

        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}
-(void) registerUser:(UIBarButtonItem*)button
{
    NSLog(@"Register User");
	//commented out for testing purposes to easily just set useruid
	/*NSString *loginParams = [[[NSString stringWithString:@"action=LOGIN"]
							   stringByAppendingString:@"&email=%@",email.text]
							 stringByAppendingFormat:@"&username=%@",username.text];
	NSMutableArray *login = [root sendAndRetrieve:loginParams];
	
	if([login count]==0){
		//some sort of error message
	}
	else {
		[root setUserUNID:[[login objectAtIndex:0]objectAtIndex:USERUNID]];
*/
		//push Groups View controller to the front
		GroupsViewController *groupview = [[GroupsViewController alloc] initWithNibName:@"GroupsViewController" bundle:nil];
		[self.navigationController pushViewController:groupview animated:YES];
    [groupview release];
	//}

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
    [super dealloc];
}

@end
