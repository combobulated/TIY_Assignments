//
//  VenueTableViewController.m
//  LoopAmerica
//
//  Created by Jim on 4/18/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//

#import "VenueTableViewController.h"
#import "Venue.h"
#import "VenueNameTableViewCell.h"
#import "JMDLocationServices.h"

@interface VenueTableViewController ()
{
    NSMutableArray *venueList;
    double lat;
    double lng;
    
    
    JMDLocationServices *usersLocationManager;
}

@end

@implementation VenueTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    usersLocationManager = [[JMDLocationServices alloc]init];
    usersLocationManager.delegate = self;
    
    // core data
    
    // pass model name to coreDataStack
    
      self.cdStack = [CoreDataStack coreDataStackWithModelName:@"LoopAmericaModel"];
    
    
    // set coreDataStore type to SQL
    
      self.cdStack.coreDataStoreType = CDSStoreTypeSQL;
    
    
    
    // items stored in our list item array
    
    venueList = [[NSMutableArray alloc] init];
    
    
    //temporary data:
    
//    venue.lat =
//    venue.lng =
   
    //  store the text in the texfield into our model object
    
    Venue *aVenue = [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:self.cdStack.managedObjectContext];  // model object aVenue retrieved from core data stack.
    
//    aVenue.name = self.taskItemTextField.text;  // store the text
     aVenue.name = @"Dr Phillips Performing Arts Center";  // store the text
     aVenue.city = @"Orlando";
     aVenue.lat = [NSNumber numberWithFloat:28.537781];
     aVenue.lng = [NSNumber numberWithFloat:-81.377371];
   
     [venueList addObject:aVenue];
    
    
    
    
     [self saveCoreDataUpdates];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // will appear regularly updates the view as opposed to viewDidLoad which only updates view once.
    // for this reason, we add the coredata fetch request to retrieve our Venue model data.
    
    NSEntityDescription *entity = [ NSEntityDescription entityForName:@"Venue" inManagedObjectContext:self.cdStack.managedObjectContext ];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    
    fetch.entity = entity;
    
    venueList  = nil;
    
    venueList = [[self.cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
    
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
    
    return [venueList count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VenueNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueNameTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Venue *aVenue = venueList[indexPath.row];
    cell.venueNameLabel.text = aVenue.name;
    cell.cityOfVenueLabel.text = aVenue.city;
//    cell.milesFromCurrentLocationLabel.text = currentLocation - VenueLocation;
   
   //[current location:]
    NSLog(@"current latitude  = %f", lat);
    NSLog(@"current longitude = %f", lng);
    
    if (lat <= 0.0)
    {
        NSLog(@"NO LOCATION DATA!  Try Search again!");
    }
//    sample from ben's weather forcaster
//    City *aCity = cities[indexPath.row];
//    cell.cityNameLabel.text = aCity.name;
//    if (aCity.currentWeather)
//    {
//        cell.currentConditionsSummaryLabel.text = aCity.currentWeather.summary;
//        cell.currentTemperatureLabel.text = [aCity.currentWeather currentTemperature];
//    }
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Core Data

- (void) saveCoreDataUpdates
{
    [self.cdStack saveOrFail:^(NSError *errorOrNil)
     {
         if (errorOrNil)
         {
             NSLog(@"Error from CDStack: %@", [errorOrNil localizedDescription]);
         }
     }];
}

#pragma mark - Location Services Delegate

- (void) locationWasFound:(CLLocation *)location
{
    lat = location.coordinate.latitude;
    lng = location.coordinate.longitude;
    
}


@end
