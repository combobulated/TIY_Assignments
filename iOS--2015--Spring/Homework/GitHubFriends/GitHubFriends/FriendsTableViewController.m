//
//  FriendsTableViewController.m
//  GitHubFriends
//
//  Created by Jim on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "NewFriendViewController.h"
#import "FriendDetailViewController.h"

#import "FriendsCell.h"

@interface FriendsTableViewController ()

{  // backing store for our viewcontroller
    NSMutableArray *friends;
}

@end

@implementation FriendsTableViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    friends = [[NSMutableArray alloc]init];
   
    
    // register class for custom cell only required if storyboard not used.
    
    [self.tableView registerClass:[FriendsCell class]
           forCellReuseIdentifier:@"FriendsCell"];
    
    //create a button in nav bar to add a new friend
    
    UIBarButtonItem *addFriendButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
        self.navigationItem.rightBarButtonItem = addFriendButton;
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
    return [ friends count ];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell" forIndexPath:indexPath];
    
    // Configure the cell...
   
   // get from our array our associated object that is paired with this cell
   // use a dictionary for our stores
    
    NSDictionary *friendInfo = friends[indexPath.row];
    
    cell.textLabel.text = [friendInfo objectForKey:@"name"];
    
    // let fetch the url, which is already in URL format from our json dictionary
    
    NSURL *avatarURL = [NSURL URLWithString:[friendInfo objectForKey:@"avatar_url"]];
    
    NSData *imageData = [NSData dataWithContentsOfURL:avatarURL];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    cell.imageView.image = image;
    
    return cell;
}

//  which friend selected?
//  User taps a cell, this section of code will create a new detail view controller,
//  friendsDetailVC

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *aFriend = friends[indexPath.row];
   
   
    //create new friend detail view controller
    
    FriendDetailViewController * friendsDetailVC = [[FriendDetailViewController alloc]init];
    
   
    // pass a pointer to the friend dictionary (defined in FriendDetailViewController) to the new view
    
    friendsDetailVC.friendInfo = aFriend;
   
    
    //set color of background
    
    friendsDetailVC.view.backgroundColor = [UIColor whiteColor];

    
    // We have an instance of this new view controller
    // Push it onto the navigation stack when a FriendCell is tapped.
    // Take view controller just created and place on view stack.
    
    [self.navigationController pushViewController:friendsDetailVC animated:YES ];
   
   //next step:  ( in the friends detail view controller )
   // * [ ] Create a public property called friendInfo that is an NSDictionary.
   // * [ ] Create a private instance variable called repos that is an NSArray
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {:
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
}

#pragma mark Action Handlers

- (void) addFriend
{
   
    NewFriendViewController *newFriendVC =
    [[NewFriendViewController alloc] init];
    
    UINavigationController *navController =
    [[UINavigationController alloc]
    initWithRootViewController:newFriendVC];
    
    newFriendVC.view.backgroundColor = [UIColor purpleColor];
    
   // next step is "call by reference" we are passing a pointer
    newFriendVC.friends = friends;  // pointer points to pointer
                                    // when friendVC is destroyed,
                                    // friends will remain
    
    [self presentViewController:navController animated:YES completion:nil];
    
}

@end
