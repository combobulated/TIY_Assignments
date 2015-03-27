//
//  CityTableViewController.m
//  Forcaster
//
//  Created by Jim on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CityTableViewController.h"
#import "ViewController.h"
#import "Weather.h"
#import "CityNameCell.h"
#import "TempInDegreesTableViewCell.h"
#import "CurrentWeatherTableViewCell.h"


@interface CityTableViewController ()

{
     NSMutableArray *cityInfo;
}

@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cityInfo = [[NSMutableArray alloc]init];
    

    
    [self.tableView registerClass:[CurrentWeatherTableViewCell class]
           forCellReuseIdentifier:@"CurrentWeatherCell"];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
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
    
    
//    return [cityInfo count];
    return [cityInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
  UITableViewCell *cellCityName = [tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell" forIndexPath:indexPath];
 
 
     Weather *weatherItem = cityInfo[indexPath.row];
     cellCityName.textLabel.text = weatherItem.weatherCity;

    return cellCityName;
}

 // -----



   // -----

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellCurrentWeather = [tableView dequeueReusableCellWithIdentifier:@"CurrentWeatherCell" forIndexPath:indexPath];
   // for inital tests, lets use longitude data in place of weather
    Weather *weatherItem = cityInfo[indexPath.row];
    cellCurrentWeather.textLabel.text = weatherItem.weatherLng;
   
return cellCurrentWeather;
}

/*
  check for blank data in JSON
 
 if (repo[@"description"] != [NSNull null])
 {
 cell.detailTextLabel.text = repo[@"description"];
 }
*/
    // Configure the cell...
 
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
   
    
    //which segue?
    if ([segue.identifier isEqualToString:@"FindCitySegue"])
    {
//        PriorityTableViewController *destVC = (PriorityTableViewController *)[segue destinationViewController];
       
        // name of destination view... in this app we are
        // segueing to a navigation controller.
        
        UINavigationController *navC = (UINavigationController *)[segue destinationViewController];
     
        // now, what is next view controller on our stack
        // (first one above navigation controller. the
        // viewController method will return a list of stacked
        // viewcontrollers.  the [0] method returns the first one
        // in the array)
        
        ViewController *viewC = [navC viewControllers][0];
        // associate data sharing pointers
        // so city data downloaded in the viewcontroller
        // maybe utilized in this City Table View controller.
       
         viewC.cityInfo = cityInfo;
 //        viewC.weather = weather;
        
        // NSArray *priorityTypes = [TodoItem allPriorityTypes];
        
        // note standard cell height is 44points
        // we are setting contentHeight to a value that will fit
        // the number of priority types.
        
    }
   
}

@end
