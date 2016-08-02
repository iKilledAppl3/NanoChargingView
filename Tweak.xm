//Developed by Billy Ellis (@bellis1000)

//Please credit me if you use this source code in your own tweaks

UIView *window;

@interface SBLockScreenBatteryChargingView : UIView


@end

	

%hook SBLockScreenBatteryChargingView

-(void)layoutSubviews{



NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/Preferences/%@",NSHomeDirectory(),@"com.billyellis.nanocharingviewsettings.plist"]];

NSNumber* shouldNotify = [settings objectForKey:@"AwesomeSwitch1"];

if ([shouldNotify boolValue] == YES)

{

window = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
window.backgroundColor = [UIColor clearColor];
[self addSubview:window];

//bg image

UIImageView *bg = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
bg.image = [UIImage imageWithContentsOfFile:@"/var/mobile/Library/SpringBoard/LockBackgroundThumbnail.jpg"];
[window addSubview:bg];


//blur

   UIVisualEffect *blurEffect;
blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

UIVisualEffectView *visualEffectView;
visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

visualEffectView.frame = window.bounds;
[window addSubview:visualEffectView];


//charging icon (originally from Carousel.app on the Apple Watch)

UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-65,[UIScreen mainScreen].bounds.size.height*0.40-65,130,130)];

image.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/NanoChargingView.bundle/image.png"];

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