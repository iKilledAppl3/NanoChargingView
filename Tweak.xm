//Developed by Billy Ellis (@bellis1000)

//Please credit me if you use this source code in your own tweaks

//Modified by iKilledAppl3 (@iKilledAppl3) on August 1,2016

UIView *window;

#import "NanoSounds.h"

@interface SBLockScreenBatteryChargingView : UIView


@end


// Preferences stuff 

NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Preferences/%@",NSHomeDirectory(),@"com.billyellis.nanocharingviewsettings.plist"]];

NSNumber* shouldNotify = [settings objectForKey:@"AwesomeSwitch1"];
NSNumber* darkBlur = [settings objectForKey:@"darkBlur"];
NSNumber* lightBlur = [settings objectForKey:@"lightBlur"];
NSNumber* blurMyWall = [settings objectForKey:@"blurMyWall"];
NSNumber* blurDefaultImage = [settings objectForKey:@"blurDefaultImage"];
NSNumber* soundEnabled = [settings objectForKey:@"appleWatchSound"];
NSNumber* originalSoundEnabled = [settings objectForKey:@"OrignalSound"];
NSNumber* vibrateEnabled = [settings objectForKey:@"vibrationEnabled"];


%hook SBUIController 
	
-(void)ACPowerChanged {
	
	if ([soundEnabled boolValue] == YES)  {
		
		
	chimeAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
	chimeAudio.numberOfLoops = 0;
	chimeAudio.volume = 0.75;
	[chimeAudio play];
		
		
	}
	
	else if ([originalSoundEnabled boolValue] == YES) {
		
		%orig;
	} 

	
	 if ([vibrateEnabled boolValue] == YES) {
		
		//Borrowed from @Ziph0n thanks again!
		
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [NSThread sleepForTimeInterval:0.5];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
		
	}
}
	
%end

%hook SBLockScreenBatteryChargingView

-(void)layoutSubviews{


if ([shouldNotify boolValue] == YES)

{

window = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
window.backgroundColor = [UIColor clearColor];
[self addSubview:window];

//bg image
	
if ([blurMyWall boolValue] == YES) {
		//blur the user's lockscreen wallpaper
		UIImageView *bg = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
		bg.image = [UIImage imageWithContentsOfFile:lockscreenImagePath];
[window addSubview:bg];
		
	}


//blur
if ([darkBlur boolValue] == YES) {
		
		 UIVisualEffect *blurEffect;
blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];


UIVisualEffectView *visualEffectView;
visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

visualEffectView.frame = window.bounds;
[window addSubview:visualEffectView];
		
	}

	//light blur method
	else if ([lightBlur boolValue] == YES) {
		
		 UIVisualEffect *blurEffect;
		 blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];

UIVisualEffectView *visualEffectView;
visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

visualEffectView.frame = window.bounds;
[window addSubview:visualEffectView];
	} 


//charging icon (originally from Carousel.app on the Apple Watch)

UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-65,[UIScreen mainScreen].bounds.size.height*0.40-65,130,130)];

image.image = [UIImage imageWithContentsOfFile:watchImagePath];

[window addSubview:image];

[self performSelector:@selector(hide) withObject:nil afterDelay:1.5];


}

%orig;

}

%new

-(void)hide{


window.hidden = YES;
window = nil;


}

%end