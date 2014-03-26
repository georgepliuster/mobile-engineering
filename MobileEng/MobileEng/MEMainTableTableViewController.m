//
//  MEMainTableTableViewController.m
//  MobileEng
//
//  Created by esther liu on 3/25/14.
//  Copyright (c) 2014 george liu. All rights reserved.
//

#import "MEMainTableTableViewController.h"
#import "MEResponse.h"


@interface MEMainTableTableViewController ()

@end

@implementation MEMainTableTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"MAINTBVC: viewDidLoad");
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://sheltered-bastion-2512.herokuapp.com/feed.json"]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}

- (void) viewWillAppear:(BOOL)animated {
    NSLog(@"MAINTBVC: viewWillAppear");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *** this really is a hack, cuz i am making too many assumptions about the href.
- (NSString *) getShortHrefNameWith: (NSString *) hrefName {
    
    NSRange wwwRange = [hrefName rangeOfString:@"www."];
    NSRange comRange = [hrefName rangeOfString:@".com"];
    NSRange hrefRange;
    hrefRange.location = wwwRange.location + wwwRange.length;
    hrefRange.length = comRange.location - hrefRange.location + 4;
    
    NSString *shortHref = [hrefName substringWithRange:hrefRange];
    return shortHref;
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
    NSLog(@"MAINTBVC: numberOfRowsInSection: %d", [_responseArray count]);
    
    return [_responseArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"MAINTBVC: cellForRowAtIndexPath");

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MECell" forIndexPath:indexPath];
    
    // Configure the cell...
    MEResponse *mer = [[MEResponse alloc] init];
    NSDictionary *nsd = [_responseArray objectAtIndex:indexPath.row];
    
    MEResponse *mr = [mer extractFromResponseDictionary:nsd];
    
 
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    nameLabel.text = mr.name;

    UIImageView *srcImageView = (UIImageView *)[cell viewWithTag:101];
    srcImageView.image = mr.srcImage;

    UIImageView *srcIconView = (UIImageView *)[cell viewWithTag:102];
    srcIconView.image = mr.avatarSrcImage;

    UILabel *avatarName = (UILabel *)[cell viewWithTag:103];
    avatarName.text = [mr.name uppercaseString];

    UILabel *href = (UILabel *)[cell viewWithTag:104];
    href.text = [self getShortHrefNameWith: mr.href];

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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark process json to nsdictionary


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    NSLog(@"MAINTBVC: didReceiveResponse");
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    NSLog(@"MAINTBVC: didReceiveData");
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
//    NSLog(@"MAINTBVC: willCacheResponse");
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"MAINTBVC: connectionDidFinishLoading");
    _responseArray = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:NULL];

    [self.tableView reloadData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"MAINTBVC: didFailWithError");
    // The request has failed for some reason!
    // Check the error var
}

@end
