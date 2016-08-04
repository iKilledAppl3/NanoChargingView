ARCHS = armv7 arm64
TARGET = iphone:clang:latest
SDK = iPhoneOS8.1
THEOS_BUILD_DIR = DEBs


include theos/makefiles/common.mk

TWEAK_NAME = NanoChargingView
NanoChargingView_FILES = Tweak.xm
NanoChargingView_FRAMEWORKS = UIKit AudioToolbox AVFoundation
NanoChargingView_CFLAGS = -Wno-error
NanoChargingView_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += nanochargingview
include $(THEOS_MAKE_PATH)/aggregate.mk
