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

%hook SBIconImageView
-(void)setIconView:(id)arg1 {
	%orig;
	SBHIconGridSize gridSize;
	gridSize.width = 4;
	gridSize.height = 6;
	[self.layer addAnimation:[%c(SBIconView) _jitterXTranslationAnimation] forKey:nil];
	[self.layer addAnimation:[%c(SBIconView) _jitterYTranslationAnimation] forKey:nil];
	[self.layer addAnimation:[%c(SBIconView) _jitterRotationAnimationForGridSize:gridSize] forKey:nil];
}
%end