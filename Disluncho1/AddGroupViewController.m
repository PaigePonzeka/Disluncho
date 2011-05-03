//
//  AddGroupViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

//

#import "AddGroupViewController.h"


@implementation AddGroupViewController
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
	
    self.title = @"Add A Group";    //display an add button for this view controller
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithGroup)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
    //his the backbutton
    self.navigationItem.hidesBackButton = YES;
    
    //add cancel button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAddGroup)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    
    //change add group name
    add_group_name.borderStyle = UITextBorderStyleRoundedRect;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void) cancelAddGroup
{
    //pop this view off the screen (back to the previous view)
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) doneWithGroup
{
    NSLog(@"Done Adding New Group");
   
    // save and update all the set information
    
    //pop this view off the screen (back to the previous view)
    [self.navigationController popViewControllerAnimated:YES];
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
    // Return the number of rows in the section (add an extra row for "add Member"
    return section == 0 ? 0 : ([groupMembersArray count]+1);
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
        
        UIButton *add_photo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       add_photo.frame = CGRectMake(0, 0, 100, 100);
        [add_photo setTitle:@"Add Photo" forState:UIControlStateNormal];
       // add_photo.buttonType =UIButtonTypeRoundedRect ;
       // [add_photo buttonType=];
       // add_photo.borderStyle = UITextBorderStyleRoundedRect;
        [modalView addSubview:add_photo];
        
        UITextField *groupName= [[UITextField alloc] initWithFrame:CGRectMake(100, 0, 300, 100)];
        groupName.text = @"Name";
        groupName.borderStyle = UITextBorderStyleRoundedRect;
        groupName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        groupName.font=[UIFont fontWithName:@"Helvetica Bold" size:20];
        [modalView addSubview: groupName];
        
        return modalView;
        
        //return button;
    } else {
        UILabel *view =[[UILabel alloc] initWithFrame:CGRectMake(20.0, 20.0, 400.0, 200.0)];
        view.text = @"Members";
        view.backgroundColor =[UIColor clearColor];
        view.textColor = [UIColor grayColor];
        return view;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if(indexPath.row == [groupMembersArray count])
    {
        [cell.textLabel setText:@"Add a Member"];
        //add the arrow to the cell
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        // Configure the cell...
        [cell.textLabel setText:[groupMembersArray objectAtIndex:indexPath.row]];
   
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
        // Delete  the member from the group array
        /* Put in code here to save changes to the delete*/
        [groupMembersArray removeObjectAtIndex:indexPath.row]; 
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:YES];   
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    // if the user selected the last row then they want to add another member push to the "add member screen"
    if(indexPath.row ==[groupMembersArray count])
    {
        NSLog(@"Adding A New Member");
        // navigate to the AddMewmeberViewController to see the results
        AddMemberViewController *memberView = [[AddMemberViewController alloc] initWithNibName:@"AddMemberViewController" bundle:nil];
        [self.navigationController pushViewController:memberView animated:NO];
        [memberView release];
    }
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
