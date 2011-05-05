//
//  NominateViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "NominateViewController.h"


@implementation NominateViewController

@synthesize currentRestaurants;
@synthesize root;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title= @"Nominate";
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
	
	PLACENAME = 1;
	PLACEUNID = 0;
	//set up pointer to the root
	root = (Disluncho1AppDelegate*)[UIApplication sharedApplication].delegate;
	
    //set the tab bar title
    self.title = @"Nominate";
    
    //display an add button for this view controller
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNomination:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
/*Selected when User wants to add a new Nomination to the Nomination list*/
- (void)addNewNomination:(UIBarButtonItem*)button {
    NSLog(@"Adding New Nominee");
    
    //push the add Restaurent View Controller
    AddRestaurantViewController *addRestaurantView = [[AddRestaurantViewController alloc] initWithNibName:@"AddRestaurantViewController" bundle:nil];
    [self.navigationController pushViewController:addRestaurantView animated:YES];
    [addRestaurantView release];
	[self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	NSString *currentResturantParams = [[[NSString stringWithString:@"action=LIST_GROUP_PLACES"] 
										 stringByAppendingString:@"&group="]
										stringByAppendingString:[NSString stringWithFormat:@"%i",[root GroupUNID]]];
	currentRestaurants = [root sendAndRetrieve:currentResturantParams];
	[currentRestaurants retain];
	
	[[self tableView] reloadData];

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
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return ([currentRestaurants count]+1); //set the rows one cell largers for Skip Nomination Option
}
/* set the height of the rows */
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
    // add the arrow to the cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if((indexPath.row > ([currentRestaurants count]-1))||([currentRestaurants count]==0))
    {
        // set the last cell with "skip Nomination Option"
        [cell.textLabel setText:@"Skip nomination"];
    }
    else
    {
        // Add the Destination Title
        [cell.textLabel setText:[[currentRestaurants objectAtIndex:indexPath.row]objectAtIndex:PLACENAME]];
        // add Subtitle (Last visit to the resturant)
        cell.detailTextLabel.text=@"Last visit 2 days ago";
        cell.detailTextLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
        
       
        // Add Destination Image Icon
        UIImage* theImage = [UIImage imageNamed:@"default_eatery.png"];
        cell.imageView.image = theImage;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//UNID of nominated place (zero = no nomination)
	int place =0;
    
    /*If the User did not select "Skip Nomination" go to the next screen*/
    if(indexPath.row < ([currentRestaurants count]))
    {
		//set the place to add to database
		place = [[[currentRestaurants objectAtIndex:indexPath.row]objectAtIndex:PLACEUNID] intValue];
	
        NSString *selected = [[currentRestaurants objectAtIndex:indexPath.row]objectAtIndex:PLACENAME];
        NSLog(@"You Nominated %@", selected);

    }
    else
    {
		//place will remain 0 signifying no nomination but to not wait for the user
        NSLog(@"You skipped Nomination Process");
    }
	//adds the nomination to the database
	NSString *nominateParams =[[[[NSString stringWithString:@"action=NOMINATE"] 
								stringByAppendingFormat:@"&round=%i",[root RoundUNID]]
								stringByAppendingFormat:@"&place=%i",place]
								stringByAppendingFormat:@"&user=",[root UserUNID]];
	[root sendAndRetrieve:nominateParams];


    //push the Vote table view screen
    VoteViewController *voteview = [[VoteViewController alloc] initWithNibName:@"VoteViewController" bundle:nil];
    [self.navigationController pushViewController:voteview animated:YES];
    [voteview release];
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
