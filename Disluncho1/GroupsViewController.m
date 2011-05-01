//
//  GroupsViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "GroupsViewController.h"


@implementation GroupsViewController
@synthesize usersGroupsArray;
@synthesize root;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Groups";
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        UIBarButtonItem *tempButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNew)];
        self.navigationItem.rightBarButtonItem = tempButton;
        [tempButton release];
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
    
	self.title = @"Groups";
	
	
	//index variables for sql results
	GROUPNAME = 0;
	GROUPID = 1;
	
	//get all users from database --- later perhaps just users that have email/phone# in your contacts
	NSString* allUserGroups = [NSString stringWithString:@"action=LIST_USER_GROUPS"];
	NSMutableArray* userGroups = [root sendAndRetrieve:allUserGroups];
	
    //load the usernames
   usersGroupsArray = [[NSMutableArray alloc] initWithCapacity:3];	
	for(int group = 0; group < [userGroups count]; group++){
	    [usersGroupsArray addObject:[[userGroups objectAtIndex:group] objectAtIndex:GROUPNAME] ];
	}
	[usersGroupsArray retain];



    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    //display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
    //display an add button for this view controller
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewGroup:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
/*Selected when User wants to add a new group to the Group list*/
- (void)addNewGroup:(UIBarButtonItem*)button {
    NSLog(@"Adding New Group");
     AddGroupViewController *addGroup = [[AddGroupViewController alloc] initWithNibName:@"AddGroupViewController" bundle:nil];
    [self.navigationController pushViewController:addGroup animated:YES];
    
	
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [usersGroupsArray count];
}
/*set the height of the rows */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
       // Configure the cell
    //add the arrow to the cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //add the user group name to the cell
    [cell.textLabel setText:[usersGroupsArray objectAtIndex:indexPath.row]];
    //add the group image to the cell
    NSString *path = @"default_restuarant.png";
    UIImage *theImage = [UIImage imageNamed:path]; 
    cell.imageView.image = theImage;
    
    return cell;

}
/*When a user edits the table make sure to also remove the group name from the users list*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //make changes the to usersGroupsArray
        [usersGroupsArray removeObjectAtIndex:indexPath.row];
        
        //remove the group list from the array
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:YES];    
		
		//[self.tableView reloadData];
	}
	if (editingStyle == UITableViewCellEditingStyleInsert) {
	}
    
       
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


/*When a user selected a row move to the Nominate screen but store the current selected group*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.editing) //table is being edited change to the GroupDetails screen
    {
        //push the nominate table view screen
        GroupDetailsViewController *groupDetailsView = [[GroupDetailsViewController alloc] initWithNibName:@"GroupDetailsViewController" bundle:nil];
        [self.navigationController pushViewController:groupDetailsView animated:YES];
    }
    else //table is not being edited behave normally
    {
        // Navigation logic may go here. Create and push another view controller.
        //save selected row
        NSString *selected = [usersGroupsArray objectAtIndex:indexPath.row];
        NSLog(@"You Selected %@", selected);
        

        //push the nominate table view screen
        NominateViewController *nominateview = [[NominateViewController alloc] initWithNibName:@"NominateViewController" bundle:nil];
        [self.navigationController pushViewController:nominateview animated:YES];

        /*
         <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
         // ...
         // Pass the selected object to the new view controller.
         [self.navigationController pushViewController:detailViewController animated:YES];
         [detailViewController release];
         */
    }
}

@end
