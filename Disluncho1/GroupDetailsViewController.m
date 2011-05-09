//
//  GroupDetailsViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "GroupDetailsViewController.h"


@implementation GroupDetailsViewController
@synthesize groupMembers;
@synthesize group;
@synthesize root;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	//set up pointer to the root
	root = (Disluncho1AppDelegate*)[UIApplication sharedApplication].delegate;
	GROUPNAME = 0;
	GROUPPHOTO = 1;
	MEMBERNAME = 1;
	MEMBERUNID = 0;
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
	//get group name
	NSString *groupParams = [NSString stringWithFormat:@"action=LIST_GROUP_INFO&group=%i",[root GroupUNID]];
	group = [root sendAndRetrieve:groupParams];
	[group retain];
	
    //set title to the name of the group
    self.title = [[group objectAtIndex:0] objectAtIndex:0];
    
	

	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	NSString *groupMembersParams = [NSString stringWithFormat:@"action=LIST_GROUP_MEMBERS&group=%i",[root GroupUNID]];
	groupMembers = [root sendAndRetrieve:groupMembersParams];
	[groupMembers retain];
	[[self tableView]reloadData];
	
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return section == 0 ? 0 : ([groupMembers count]+1);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 100;
    }
    else
    {
        return 20;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView *modalView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)] autorelease];
    
       
        UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [myImage setImage:[UIImage imageNamed:[[group objectAtIndex:0]objectAtIndex:GROUPPHOTO]]];//@"default_group.png"]];
        //myImage.opaque = YES; // explicitly opaque for performance
        [modalView addSubview:myImage];
        [myImage release];
        
        UIButton *button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(100, 0, 200.0, 100.0); // position in the parent view and set the size of the button
        [button setTitle:[[group objectAtIndex:0]objectAtIndex:0] forState:UIControlStateNormal];
        [modalView addSubview: button];
        // add targets and actions
        [button addTarget:self action:@selector(editNAME) forControlEvents:UIControlEventTouchUpInside];
        return modalView;

        //return button;
    } else {
        UILabel *view =[[[UILabel alloc] initWithFrame:CGRectMake(10.0, 20.0, 400.0, 200.0)]autorelease];
        view.text = @"Members";
        view.backgroundColor =[UIColor clearColor];
        return view;
    }
}
-(void)editNAME{
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	if(indexPath.row == [groupMembers count])
    {
        [cell.textLabel setText:@"Add a Member"];
        //add the arrow to the cell
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	else{
		// Configure the cell...
		[cell.textLabel setText:[[groupMembers objectAtIndex:indexPath.row] objectAtIndex:MEMBERNAME]];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
		// Delete  the member from the database
		NSString *deleteMemberParams = [NSString stringWithFormat:@"action=DELETE_MEMBER&member=%i",
										[[[groupMembers objectAtIndex:indexPath.row]objectAtIndex:MEMBERUNID] intValue]];
		[root send:deleteMemberParams];
		
		//delete member from local array
        [groupMembers removeObjectAtIndex:indexPath.row]; 
		
		//delete member from tableview
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:YES];   
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row ==[groupMembers count])
    {
        NSLog(@"Adding A New Member");
		
		
        // navigate to the AddMewmeberViewController to see the results
        AddMemberViewController *memberView = [[AddMemberViewController alloc] initWithNibName:@"AddMemberViewController" bundle:nil];
        [self.navigationController pushViewController:memberView animated:NO];
        [memberView release];
    }
	
	
	
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
