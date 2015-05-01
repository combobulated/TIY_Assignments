//
//  ViewController.m
//  IronTunes
//
//  Created by Jim on 4/23/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//

// see notes in NSHipster.com for more details
// NSNotifications and...?see video at 35 minutes April 23, 2015

#import "ViewController.h"
@import AVFoundation;
@import MediaPlayer;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIImage *songTitleLabel;

@property (nonatomic) AVQueuePlayer *avQueuePlayer;

- (IBAction)playPauseSong:(UIButton *)sender;
- (IBAction)restartSong:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupAudioSession];
   
    // create an AV Q player  ... to que up songs and play in succession
    
    self.avQueuePlayer = [[AVQueuePlayer alloc] init];
    
    AVPlayerItem *playerItem = [[AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]
        pathForResource:@"CannedHeat" ofType:@"mp3"]]];
                                
    if (playerItem)
        {
            [self.avQueuePlayer insertItem:playerItem afterItem:nil];
            [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo =
            @{MPMediaItemPropertyArtist: @"Jamiroquai",
              MPMediaItemPropertyTitle:@"Canned Heat"}
            ;
            self.artistLabel.text = @"Jamiroquai";
            self.songTitleLabel.text = @"Canned Heat";
                                    
        }
}
                                
- (void)viewDidAppear:(BOOL)animated
    {
        [super viewDidAppear:animated];
        
        [[UIApplication sharedApplication]
         beginReceivingRemoteControlEvents];
        
        [self becomeFirstResponder];
                               // see bottom for audio session management
}
                                
- (void) viewWillDisappear:(BOOL)animated
{
 //   we dont need this in this app, but toremove observer ...
//    [[[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionInterruptionNotification object:
//      AVAudioSession sharedInstance]];
   
    [[UIApplication sharedApplication]
     endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    
    [self.avQueuePlayer removeAllItems];
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupAudioSession
{
     // One notification center per app
    [[[NSNotificationCenter defaultCenter] ] addObserver:self
                                                selector:@selector(AudioSessionInterrupted:)
                                                    name:AVAudioSessionInterruptionNotification
                                                  object:[AVAudioSession sharedInstance]];
    
    NSError *categoryError = nil;
    [[[AVAudioSession sharedInstance] ] setCategory:
     AVAudioSessionCategoryPlayback error:&categoryError];
    
    if (categoryError)
    {
        NSLog(@"Error setting category: %@", [categoryError localizedDescription]);
    }
    
    NSError *activationError = nil;
    BOOL success = [[AVAudioSession sharedInstance] setActive:YES
                                                        error:&activationError];
    if(!success)
    {
        NSLog(@"Audio session could not be activated.");
        if  (activationError)
        {
            NSLog(@"Session error: %@", [activationError localizedDescription]);
        }
    }
}
#pragma mark - notifications
- (void)AudioSessionInterrupted:(NSNotifiation *)notification
{    // in case of phone call interruption...
    NSLog(@"Interruption received: %@", [notification name]);
    
}

#pragma mark - Playback control
                                
- (void)togglePlayback:(BOOL)play
{
    if (play)
    {
        [self.avQueuePlayer play];
        [self.playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else
    {
        [self.avQueuePlayer pause];
    }
}
    
                                
#pragma mark - Action handlers

- (IBAction)playPauseSong:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Pause"])
    {
        [self togglePlayback:NO];
    }
    else
    {
        [self togglePlayback:YES];
    }
}

- (IBAction)restartSong:(UIButton *)sender
{
    [self.avQueuePlayer seekToTime:CMTimeMakeWithSeconds(0.0, 1)]; // go back to beginning
    if ([self.avQueuePlayer rate] == 0.0)
    {
        [self togglePlayback:YES];
    }
}
                                
#pragma mark - Remote control events
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
    {
        if (event.type == UIEventTypeRemoteControl)
        {
            switch (event.subtype)
            {
                case UIEventSubtypeRemoteControlTogglePlayPause:
                    if (self.avQueuePlayer.rate > 0.0)
                    {
                        [self togglePlayback:NO];
                    }
                    else
                    {
                        [self togglePlayback:YES];
                    }
                    break;
                case UIEventSubtypeRemoteControlPlay:
                    [self togglePlayback:YES];
                    break;
                    
                case UIEventSubtypeRemoteControlPause:
                    [self togglePlayback:NO];
                    break;
                    
                default:
                    break;
            }
        }
    }
#pragma mark - Audio session management
- (BOOL)canBecomeFirstResponder
    {
        return YES;
        
    }
                                
@end
