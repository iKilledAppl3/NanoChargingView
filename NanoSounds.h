//Frameworks needed for NanoChargingView

//These are good for the sound and haptic feedback when the charger is plugged in!

//Sounds and Haptic Feedback code are based on Beep-Beep by @Ziph0n kudos to him! and VaultBoy Activator by @iKilledAppl3!

//Created by iKilledAppl3 on 8-3-2016

//No need to import the SpringBoard header since it's already done for us :P

#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <UIKit/UIKit.h>

#define chargeSound @"/System/Library/Audio/UISounds/connect_power.caf"
#define watchImagePath @"/Library/Application Support/NanoChargingView/image.png"
#define lockscreenImagePath @"/var/mobile/Library/SpringBoard/LockBackgroundThumbnail.jpg"

AVAudioPlayer *chimeAudio;


NSString *appleWatchChime = [[NSBundle bundleWithPath:@"/Library/Application Support/NanoChargingView/"] pathForResource:@"Charging" ofType:@"caf"];
NSURL *url = [[NSURL alloc] initFileURLWithPath:appleWatchChime];

