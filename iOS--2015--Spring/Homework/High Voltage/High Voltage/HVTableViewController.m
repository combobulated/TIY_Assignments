//
//  HVTableViewController.m
//  High Voltage
//
//  Created by Jim on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "HVTableViewController.h"
#import "Power Brain.h"

//@interface HVTableViewController () <UITextFieldDelegate,          UIPopoverPresentationControllerDelegate>

@interface HVTableViewController () <UITextFieldDelegate>
{

    // list of parameter values
    
    NSMutableArray *parameters;
    
    NSString *epText;
    NSString *currentText;
    NSString *resistanceText;
    NSString *powerText;
    
}

@property (weak,nonatomic) IBOutlet UITextField *epText;
@property (weak,nonatomic) IBOutlet UITextField *currentText;
@property (weak,nonatomic) IBOutlet UITextField *resistanceText;
@property (weak,nonatomic) IBOutlet UITextField *powerText;


@end

@implementation HVTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // set title
    self.title = @"High Voltage";
    
  //  *brain = [Power_Brain init];
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
   
//    return [allParameters count];
    return 4;  // ideally set to [allParameters count]
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EPTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...a
    
//    TodoItem *item = taskList[indexPath.row]; // one item in our task list
    // item has a) task and b) a priority
    
    
    UITextField *epTextField = (UITextField *)[cell viewWithTag:1];
    UITextField *currentTextField = (UITextField *)[cell viewWithTag:2];
    UITextField *resistanceTextField = (UITextField *)[cell viewWithTag:3];
    UITextField *powerTextField = (UITextField *)[cell viewWithTag:4];
   
    
 //  [epTextField]
    
    
//    textField.delegate = self;

    
//    textField.delegate = self;
    
//        if(item.taskName)
//        {
//            [textField setText:item.taskName];          // display the task
//        }
//        else
//        {   // textfield is empty
            // lets add focus to text field and bring keyboard
            
//            [textField becomeFirstResponder];
//        }
        
//        priorityLabel.text = [item priorityAsString];   //display the priority
        
 //   }
 //  */
    
    
/*    // if it were a button
    UITableViewCell *cell = [self.tableListRegion dequeueReusableCellWithIdentifier:@"EPTableViewCell" ];
    
    UITextField *textOfLabel1 = (UITextField *)[CellLast viewWithTag:1];
    
    [textOfLabel1 adTarget:self action:@selector(YourSelector:) forControlEvents:UIControlEventAllEditingEvents]
    // Configure the cell...
    
   // sample of custom tagged cell with button
    
    UITableViewCell *Cell = [self.TableListRegion dequeueReusableCellWithIdentifier:@"List"];
    
    UIButton *objectOfButton = (UIButton *)[CellLast viewWithTag:200];
    
    [objectOfButton addTarget:self action:@selector(YourSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    return Cell;
  */
    
    
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
     
     a) if [segue.identifier isEqualToString:"@:HVP...Seque"]
      b) 
         
         
     
}


@end
