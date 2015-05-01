//
//  FriendsCollectionViewController.m
//  CardsAgainstGitHubACollectionView
//
//  Created by Jim on 4/20/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//

#import "FriendsCollectionViewController.h"
#import "FriendDetailViewController.h"
#import "NewFriendViewController.h"


@interface FriendsCollectionViewController ()

{  // backing store for our viewcontroller
    NSMutableArray *friends;
}

@end

@implementation FriendsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view.
    
    //create a button in nav bar to add a new friend
    
    UIBarButtonItem *addFriendButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = addFriendButton;
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
   
    NewFriendViewController *newFriendVC = [[NewFriendViewController alloc]init];
    
    newFriendVC.view.backgroundColor = [UIColor purpleColor];
    
    // next step is "call by reference" we are passing a pointer
    newFriendVC.friends = friends;  // pointer points to pointer
    // when friendVC is destroyed,
    // friends will remain
    
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [friends count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // configure the cell
    
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
   
    
    // get from our array our associated object that is paired with this cell
    // use a dictionary for our stores
    
    NSDictionary *friendInfo = friends[indexPath.row];
   
    
//   cell.textLabel.text = [friendInfo objectForKey:@"name"];
     label.text = [friendInfo objectForKey:@"name"];
    
    // let fetch the url, which is already in URL format from our json dictionary
    
    NSURL *avatarURL = [NSURL URLWithString:[friendInfo objectForKey:@"avatar_url"]];
    
    NSData *imageData = [NSData dataWithContentsOfURL:avatarURL];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    //cell.imageView.image = image;
    imageView.image = image;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

//  Jim use this to push to detail view when cell is tapped.

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath 
 
{
 NSDictionary *aFriend = friends[indexPath.row];
 
 
 //create new friend detail view controller
 
 FriendDetailViewController *friendsDetailVC = [[FriendDetailViewController alloc]init];
 
 
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
 
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


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
