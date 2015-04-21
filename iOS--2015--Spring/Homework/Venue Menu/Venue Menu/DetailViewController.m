//
//  DetailViewController.m
//  Venue Menu
//
//  Created by Jim on 4/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "DetailViewController.h"
#import "VenueTableViewController.h"

#import "CoreDataStack.h"

#import "Venue.h"
#import "Address.h"

double *lat;
double *lng;

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UISlider *ratingSlider;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@",self.selectedVenue);
    
    self.nameTextField.text = self.selectedVenue[@"name"];
    self.addressTextField.text = [self.selectedVenue[@"location"][@"formattedAddress"] objectAtIndex:0];
   
  //  NSString *latText = [self.selectedVenue[@"location"][@"lat"] objectAtIndex:0];
  //  NSString *lngText = [self.selectedVenue[@"location"][@"lng"] objectAtIndex:0];
    
    
   // NSLog(@" Venue Lat = %@",latText);
   // NSLog(@" Venue Lng = %@",lngText);
    
    
   // lat = self.selectedVenue
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)sliderValueChanged:(id)sender
{
    
// Set the label text to the value of the slider as it changes
    self.ratingTextField.text = [NSString stringWithFormat:@"%ld", (long)[ @(self.ratingSlider.value) integerValue ]];
    
//    [@(myFloat) integerValue]
}
- (IBAction)saveFavoriteVenue:(id)sender
{

//  update coredata
   
//  store data into our persistant model object

/* Core Data
    Venue *aVenue = [ NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:self.cdStack.managedObjectContext ];  // model object aVenue retrieved from core data stack.

    aVenue.name = self.nameTextField.text;  // store the text name
    aVenue.rating = [NSNumber numberWithFloat: self.ratingSlider.value];
    aVenue.lat = [self.selectedVenue[@"location"][@"lat"];
    aVenue.lng = [self.selectedVenue[@"location"][@"lng"];
 
 */

/* Core Data
    [self saveCoreDataUpdates];
*/

    
//  return to VenueTableViewController
   
    VenueTableViewController *VenueTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VenueTableViewID"];
    
    [self.navigationController pushViewController:VenueTVC animated:YES];
    
}


#pragma mark - Core Data

/*
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
*/

@end
