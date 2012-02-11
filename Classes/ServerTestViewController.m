//
//  ServerTestViewController.m
//  ServerTest
//
//  Created by Blake Watters on 9/5/10.
//  Copyright RestKit 2010. All rights reserved.
//

#import "ServerTestViewController.h"
#import "RKTPost.h"

@interface ServerTestViewController (Private)
- (void)loadData;
@end

@implementation ServerTestViewController

- (void)loadPosts
{
    // Load the object model via RestKit	
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    
    //objectManager.client.baseURL = @"http://emptyapp.herokuapp.com/";
    //objectManager.client.baseURL = @"http://0.0.0.0:3000/";
    
    [objectManager loadObjectsAtResourcePath:@"/users/list.json" delegate:self block:^(RKObjectLoader* loader) {
        // Twitter returns statuses as a naked array in JSON, so we instruct the loader
        // to user the appropriate object mapping
        if ([objectManager.acceptMIMEType isEqualToString:RKMIMETypeJSON])
        {
            loader.objectMapping = [objectManager.mappingProvider objectMappingForClass:[RKTPost class]];
        }
    }];
}

- (void)loadView
{
    [super loadView];
	
	// Setup View and Table View	
	self.title = @"Posts";
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadPosts)] autorelease];
    
	UIImageView* imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG.png"]] autorelease];
	imageView.frame = CGRectOffset(imageView.frame, 0, -64);
	
	[self.view insertSubview:imageView atIndex:0];
	
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-64) style:UITableViewStylePlain];
	_tableView.dataSource = self;
	_tableView.delegate = self;		
	_tableView.backgroundColor = [UIColor clearColor];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
	
	[self loadPosts];
}

- (void)dealloc
{
	[_tableView release];
	[_posts release];
    [super dealloc];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response
{
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects
{
	NSLog(@"Loaded posts: %@", objects);    
	[_posts release];
	_posts = [objects retain];
	[_tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error
{
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
	NSLog(@"Hit error: %@", error);
}

#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGSize size = [[[_posts objectAtIndex:indexPath.row] name] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 9000)];
	return (size.height*3) + 10;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [_posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* reuseIdentifier = @"Tweet Cell";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
	if (nil == cell)
    {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
		cell.textLabel.font = [UIFont systemFontOfSize:14];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listbg.png"]];
	}

    NSLog(@"name: %@", [[_posts objectAtIndex:indexPath.row] name]);
    NSLog(@"email: %@", [[_posts objectAtIndex:indexPath.row] email]);

    NSString* str = [NSString stringWithFormat:@"Name: %@\nEmail: %@", 
                     [[_posts objectAtIndex:indexPath.row] name], 
                     [[_posts objectAtIndex:indexPath.row] email]];

    cell.textLabel.text = str;
    
	return cell;
}

@end
