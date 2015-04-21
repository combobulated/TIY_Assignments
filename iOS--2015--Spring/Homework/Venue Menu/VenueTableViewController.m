//
//  VenueTableViewController.m
//  Venue Menu
//
//  Created by Jim on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "VenueTableViewController.h"
#import "SearchViewController.h"

#import "CoreDataStack.h"
#import "Address.h"
//#import "_Address.h"
#import "Venue.h"
//#import  "_Venue.h"


@interface VenueTableViewController ()
{
    NSMutableArray *venues;
    CoreDataStack *cdStack;
}
@end

@implementation VenueTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//  why does this crashes sim ->   self.title = @"My Favorite Venues";
   
    
    // initialize our CoreDataStack model
    
    cdStack = [ CoreDataStack coreDataStackWithModelName:@"VenueMenuModel"];
    
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
  
    
    // init our venues array
   
    
    venues = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    /*  Core Data */
    
    NSEntityDescription *entity;
    NSFetchRequest *fetch;
    fetch = [[NSFetchRequest alloc] init];
  
    
    // restore the venue model
    
    // nab the handle to our model object
    entity = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:cdStack.managedObjectContext];
   
    // init search criteria data from a persistent store
    fetch.entity = entity;
   
    // populate model from persistant data!
    venues = nil;
    venues = [[ cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
   
    
   // reload table view
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [venues count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueTableViewCellRuseID" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Venue *aVenue = venues[indexPath.row];
    
      //  [cell.nameTextField becomeFirstResponder];
      cell.textLabel.text = aVenue.name;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    
    searchVC.venues = venues;
/*  Core Data
    // pass our coredata  ..to eventually be used in detail view controller
*/
    cdStack = nil;
    searchVC.cdStack = cdStack;

}


@end
