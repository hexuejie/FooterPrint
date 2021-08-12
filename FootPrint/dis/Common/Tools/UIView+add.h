

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (add)


- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity;

- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity withAlpha:(CGFloat)alpha ;

- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity withAlpha:(CGFloat)alpha withCGSize:(CGSize)size;

- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withShadowRadius:(CGFloat)shadowRadius withOpacity:(CGFloat)opacity withAlpha:(CGFloat)alpha withCGSize:(CGSize)size;
- (void)setBorderWithView;
- (void)setBorderWithView:(CGRect)frame;

- (void)clearCustomLayer;

- (void)setChangeColorsBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor beginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint;
@end

NS_ASSUME_NONNULL_END
