#import "header/PSListController.h"
#import "header/PSViewController.h"

@interface NanoChargingViewListController: PSListController {
}
@end

@implementation NanoChargingViewListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"NanoChargingView" target:self] retain];
	}
	return _specifiers;
}

-(void)killSpringBoard {
	
	system("killall -9 backboardd");
}

@end

// vim:ft=objc
