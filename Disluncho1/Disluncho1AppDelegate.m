//
//  Disluncho1AppDelegate.m
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import "Disluncho1AppDelegate.h"

@implementation Disluncho1AppDelegate


@synthesize window=_window;

@synthesize navigationController=_navigationController;

@synthesize UserUNID,GroupUNID, RoundUNID, DATABASE_VERBOSE, image_type, imageFileString, receivedData,connection;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //create the file directories if they don't already exist
    NSArray *defaultFolders = [[NSArray alloc] initWithObjects:@"groups",@"users",@"places", nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    for(NSString *defaultFolder in defaultFolders)
    {
        //set the datapath 
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:defaultFolder];
        //if the file path already exists don't create it
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    
    /*Download Images*/
    [self downloadFile:@"0.png":@"places"];   
    [self downloadFile:@"1.png":@"places"];   
    
    [self downloadFile:@"0.png":@"groups"];   
    //UIImage *img = [[UIImage alloc] initWithData:theData];

	
	//will print out each database call and results
	DATABASE_VERBOSE = FALSE;
	
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}
-(void) downloadFile: (NSString*) filename : (NSString*) folder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder

    NSString *linkAsString = [[NSString alloc] initWithFormat:@"http://ponzeka.com/iphone_disluncho/images/%@/%@",folder,filename];
    NSLog(@"Getting Files From: %@", linkAsString);
    NSURL *link = [[NSURL alloc]initWithString:linkAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:linkAsString]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSString *localFilePath = [[documentsDirectory stringByAppendingPathComponent:folder]stringByAppendingPathComponent:filename];
    NSLog(@"Dropping Them: %@", localFilePath );
    NSData* theData = [NSData dataWithContentsOfURL:link];
    [theData writeToFile:localFilePath atomically:YES];
    

}
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
}

- (NSCachedURLResponse *) connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}
/*
 *will return 2D array of results[row,field] 
 *must send parameters as (@"action=____&otherParamName=___& ...")
 *all queries are therefore created and stored in the php file and called by their action= parameter
 *
 */
-(NSMutableArray *) sendAndRetrieve:(NSString *)parameters
{
	//set up urlRequest
	NSData *parametersData = [parameters dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:NO];
	NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] 
										initWithURL:[NSURL URLWithString:@"http://ponzeka.com/iphone_disluncho/disluncho_test.php"]]
									   autorelease];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setHTTPBody:parametersData];
	
	//variables to store retrieved data
	NSData *urlData; 
	NSURLResponse *response; 
	NSError *error;
	
	//connect to url and get response
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error]; 
	
	//check for errors
	if(!urlData) {
		NSLog(@"Connection Failed!");
		NSMutableArray *returnValues = [NSMutableArray arrayWithCapacity:0];
		return returnValues;
	}
	//turn response into String stripped of \n characters
	NSString *urlString = [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding] 
						   stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]; 
	
	//make string into 2D array [rows, fields]
    NSMutableArray *returnValues = [[[NSMutableArray alloc] initWithCapacity:100]autorelease];
	
	
	[returnValues setArray:[urlString componentsSeparatedByString:@"|"]];
	for(int row=0; row< [returnValues count]; row++){
		[returnValues replaceObjectAtIndex:row withObject:
		 [[returnValues objectAtIndex:row] componentsSeparatedByString:@","]];
	}
	
	//Array of size [1,1] will be "" if there was no results, remove blank object for logic
	NSString* string = [NSString stringWithString:[[returnValues objectAtIndex:0]objectAtIndex:0]];
	if (NSOrderedSame == [string compare:@""]){
		[returnValues removeLastObject];
		if(DATABASE_VERBOSE)NSLog(@"return arry of size [0,0] - NO RESULTS");
	}
	else{
		//print out return string size, row and fields
		if(DATABASE_VERBOSE)[self printResults:returnValues];
	}
	
	return returnValues;

}
/*
 *
 *
 */
-(void) send:(NSString *)parameters
{
	//set up urlRequest
	NSData *parametersData = [parameters dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:NO];
	NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] 
										initWithURL:[NSURL URLWithString:@"http://ponzeka.com/iphone_disluncho/disluncho_test.php"]]
									   autorelease];
	[urlRequest setHTTPMethod:@"POST"];
	[urlRequest setHTTPBody:parametersData];
	
	//variables to store retrieved data
	NSData *urlData; 
	NSURLResponse *response; 
	NSError *error;
	
	//connect to url and get response
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error]; 
	
	//check for errors
	if(!urlData) {
		NSLog(@"Connection Failed!");

	}
	//turn response into String stripped of \n characters
	NSString *urlString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]; 
	if(DATABASE_VERBOSE)NSLog(@"\n\t%@",urlString);
    [urlString release];

}

/*
 *	prints out the result array to Log 
 */
-(void)printResults:(NSMutableArray*)results{
	NSLog(@"returned array of size = [ %i , %i ]\n",[results count], [[results objectAtIndex:0]count]);
	for(int j = 0; j<[results count]; j++){
		NSString* fields = [NSString  stringWithString:@""];
		for(int k = 0; k<[[results objectAtIndex:0]count]; k++){
			fields = [fields stringByAppendingString:[@"[" stringByAppendingString:
													  [[[results objectAtIndex:j]objectAtIndex:k] 
													   stringByAppendingString:@"]"]]];
		}
		NSLog(@"[row #%i]- %@ ",j,fields);
	}
}
//loading image from Documents
- (UIImage*)loadImage:(NSString*)imgName {
	//default images are stored separately 
	if(([imgName length]>7)&&([[imgName substringToIndex:7] isEqualToString:@"default"])){
		
		return [UIImage imageNamed:imgName];
	}
	else{
		NSString *withoutPNG = [imgName stringByReplacingOccurrencesOfString:@".png" withString:@""];
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", withoutPNG]];
		return [UIImage imageWithContentsOfFile:fullPath];
	}
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [connection release];
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
