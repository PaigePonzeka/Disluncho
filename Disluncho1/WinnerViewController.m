//
//  WinnerViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "WinnerViewController.h"


@implementation WinnerViewController
@synthesize waitingForVotes;
@synthesize root;
@synthesize nominees;

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
	
	PLACEUNID = 0;
	PLACENAME = 1;
	PLACEPHOTO = 2;
	PLACEVOTES = 3;
    // remove the back button
    self.navigationItem.hidesBackButton = YES;
	
	// Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)checkForVotingDone
{
	//get members who have not voted yet in this round
	NSString *waitingForVotesParams = [[NSString stringWithString:@"action=GET_NOT_VOTED_MEMBERS"]
									   stringByAppendingFormat:@"&round=%i",[root RoundUNID]];
	waitingForVotes = [root sendAndRetrieve:waitingForVotesParams];

	// set the status of voting (are we waiting for people to finish voting?)
	waiting_for_votes = ([waitingForVotes count]!=0);
	
	//tally the votes
	NSString *nomineesParams = [[NSString stringWithString:@"action=TALLY_VOTES"]
								stringByAppendingFormat:@"&round=%i",[root RoundUNID]];
	nominees = [root sendAndRetrieve:nomineesParams];
	[nominees retain];
	
	//------choose between screens -----
	if(!waiting_for_votes) // everyone has finished voting/the vote has ended
    {
        self.title = @"And The Winner is...";
        
		
        // add a back button back to the "Groups"
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Groups" style:UIBarButtonItemStylePlain  target:self action:@selector(goToGroups:)];
        self.navigationItem.leftBarButtonItem = backButton;
        [backButton release];
		
    }
    else // some one is still voting show the "tallying votes screen"
    {
        // user waits here until the voting process has complete
        self.title = @"Tallying Votes...";
        self.navigationItem.hidesBackButton = YES;
		
    }
}
-(void)goToGroups:(UIBarButtonItem*)button
{
    /* Reset back to the groups screen*/
    NSLog(@"Reset to Groups Controller");
    
    // navigate to the winnerViewController to see the results
    GroupsViewController *winnerview = [[GroupsViewController alloc] initWithNibName:@"GroupsViewController" bundle:nil];
    [self.navigationController pushViewController:winnerview animated:NO];
    [winnerview release];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	if(waiting_for_votes)[self checkForVotingDone];
	
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
    // Return the number of rows in the section.
    return [nominees count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    //set the cell subtitle (time of last visit)
    
    // add Subtitle (Last visit to the resturant)
    cell.detailTextLabel.text=@"Last visit 2 days ago";
    cell.detailTextLabel.font=[UIFont fontWithName:@"Helvetica" size:13];
    
    //create total number of votes label
    UILabel *voteCount;
    voteCount = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    NSString *vote = [NSString stringWithFormat:@"%i",[[[nominees objectAtIndex:indexPath.row]objectAtIndex:PLACEVOTES]intValue ]];
    voteCount.text = vote;
    voteCount.textAlignment =UITextAlignmentCenter;
    voteCount.backgroundColor = [UIColor grayColor];
    voteCount.textColor =[UIColor whiteColor];
    voteCount.font=[UIFont fontWithName:@"Helvetica Bold" size:12];
    voteCount.layer.cornerRadius= 4;
    // Add Destination Image Icon
    UIImage* theImage = [UIImage imageNamed:@"default_eatery.png"];
        if(!waiting_for_votes){ //all votes are finished so set the fade look for everyone but the winner
            if(indexPath.row!=0) //these are the losers - faded
            {
                CGFloat opacity= .3;
                cell.imageView.alpha = opacity;
                voteCount.alpha = opacity;
                cell.textLabel.alpha = opacity;
                voteCount.backgroundColor = [UIColor lightGrayColor];
            }
    }
    
   
    cell.imageView.image = theImage;
    // Configure the cell title...
    [cell.textLabel setText:[[nominees objectAtIndex:indexPath.row]objectAtIndex:PLACENAME]];
    cell.accessoryView = voteCount;
    

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
