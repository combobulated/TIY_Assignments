//
//  LeadViewController.m
//  DanceConnect
//
//  Created by Jim on 4/29/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//


@import MediaPlayer;
@import MultipeerConnectivity;
@import AVFoundation;

#import "LeadViewController.h"
#import "TDAudioStreamer.h"
#import "TDSession.h"

@interface LeadViewController () <MPMediaPickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UILabel *songTitle;
@property (weak, nonatomic) IBOutlet UILabel *songArtist;

@property (strong, nonatomic) MPMediaItem *song;

@property (strong, nonatomic) TDAudioOutputStreamer *outputStreamer;
@property (strong, nonatomic) TDSession *session;
@property (strong, nonatomic) AVPlayer *player;

@end

@implementation LeadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // create and init a session
	self.session = [[TDSession alloc] initWithPeerDisplayName:@"LEAD"];
}

- (void)didReceiveMemoryWarning
{
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

#pragma mark - Media Picker delegate

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // User has picked a song. Lets stream it!
    
    // First, make sure streamer is not already streaming
    
    if (self.outputStreamer) return;

    
    // point our song model pointer to proper location
    
    self.song = mediaItemCollection.items[0];

    
    //  load the info dictionary with title, artist, image
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    info[@"title"] = [self.song valueForProperty:MPMediaItemPropertyTitle] ? [self.song valueForProperty:MPMediaItemPropertyTitle] : @"";
    
    info[@"artist"] = [self.song valueForProperty:MPMediaItemPropertyArtist] ? [self.song valueForProperty:MPMediaItemPropertyArtist] : @"";
    
    MPMediaItemArtwork *artwork = [self.song valueForProperty:MPMediaItemPropertyArtwork];
    
    UIImage *image = [artwork imageWithSize:self.albumImage.frame.size];
    
    if (image)
        info[@"artwork"] = image;
   
    
    // save the info dictionary values to image and text
    
    if (info[@"artwork"])
        self.albumImage.image = info[@"artwork"];
    else
        self.albumImage.image = nil;
   
    
    self.songTitle.text = info[@"title"];
    self.songArtist.text = info[@"artist"];
   
   
    
    // send the info dictionary data
    
    [self.session sendData:[NSKeyedArchiver archivedDataWithRootObject:[info copy]]];
    
    NSArray *peers = [self.session connectedPeers];
    
    if (peers.count)
    {
        self.outputStreamer = [[TDAudioOutputStreamer alloc] initWithOutputStream:[self.session outputStreamForPeer:peers[0]]];
        
        [self.outputStreamer streamAudioFromURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
        
        [self.outputStreamer start];
    }
    
    // start host player (see AudioTapProcessor example from developer library for
    // how to set up the player)
   //  not like this: [self.player  initWithURL:[self.song valueForProperty:MPMediaItemPropertyAssetURL]];
   //  for time sync, best to start player before output streamer starts in above code.
}


- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    // dismisses table view of song selections
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View Actions

- (IBAction)invite:(id)sender
{
    [self presentViewController:[self.session browserViewControllerForSeriviceType:@"dance-party"] animated:YES completion:nil];
}

- (IBAction)addSongs:(id)sender
{
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
   
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}


@end
