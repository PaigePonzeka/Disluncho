//
//  AddRestaurantViewController.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "AddRestaurantViewController.h"


@implementation AddRestaurantViewController
@synthesize root;
@synthesize photo_path;


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
	
    self.title = @"Add Restaurant";    //display an add button for this view controller

    eatery_name.borderStyle = UITextBorderStyleRoundedRect;
	eatery_name.placeholder = @"Name";
	[eatery_name setDelegate:self];
	
	//set 
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithRestuarant)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)doneWithRestuarant
{
	int place;	
	//search to see if this place exists in the database (possible similar finds screen/options)
	NSString *similarPlacesParams = [NSString stringWithFormat:@"action=GET_LIKE_PLACE&name=%@",eatery_name.text];
	NSMutableArray *similarPlaces;
	similarPlaces = [root sendAndRetrieve:similarPlacesParams];
	
	if([similarPlaces count]!=0)
	{
		NSLog(@"there is a similar restuarant already in the database: %@ <-- use that",[[similarPlaces objectAtIndex:0] objectAtIndex:1]);
		place = [[[similarPlaces objectAtIndex:0] objectAtIndex:0]intValue];
	}
	else{
		//add unique place to the database
		NSString *addPlaceParams = [NSString stringWithFormat:@"action=ADD_PLACE&name=%@",eatery_name.text];
		NSMutableArray *addPlace;
		addPlace = [root sendAndRetrieve:addPlaceParams];
	
		place = [[[addPlace objectAtIndex:0] objectAtIndex:0] intValue];
	}
	//if photo updates were done then update the photo
	if([self photo_path]!=NULL){
		NSString *photoUpdateParams = [NSString stringWithFormat:@"action=UPDATE_PHOTO&photo=%@&place=%i",[self photo_path],place];
		[root send:photoUpdateParams];
		
	}
	//user who added the place nominates it for this round 
	NSString *nominateParams = [NSString stringWithFormat:@"action=ADD_NOMINATION&user=%i&round=%i&place=%i",
								[root UserUNID],[root RoundUNID],place];
	[root send:nominateParams];
	
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


@end
