#import <Cephei/HBPreferences.h>

typedef struct SBHIconGridSize {
    short width;
    short height;
} SBHIconGridSize;

@interface SBIconView
+(id)_jitterXTranslationAnimation;
+(id)_jitterYTranslationAnimation;
+(id)_jitterRotationAnimationForGridSize:(SBHIconGridSize)arg1 ;
@end

@interface SBIconImageView : UIView
-(void)setIconView:(id)arg1 ;
@end

HBPreferences *preferences;
BOOL enabled;

%group JiggleMode
%hook SBIconImageView
-(void)setIconView:(id)arg1 {
	%orig;
	SBHIconGridSize gridSize;
	// I haven't found a big difference from changing the width and height values so I'm hoping it works relatively the same on any homescreen layout, if someone complains I'll probably do it right
	gridSize.width = 10;
	gridSize.height = 10;
	[self.layer addAnimation:[%c(SBIconView) _jitterXTranslationAnimation] forKey:nil];
	[self.layer addAnimation:[%c(SBIconView) _jitterYTranslationAnimation] forKey:nil];
	[self.layer addAnimation:[%c(SBIconView) _jitterRotationAnimationForGridSize:gridSize] forKey:nil];
}
%end
%end

%ctor {
  preferences = [[HBPreferences alloc] initWithIdentifier:@"com.chr1s.jigglemodeprefs"];
  [preferences registerBool:&enabled default:YES forKey:@"enabled"];
  if (enabled) %init(JiggleMode);
}