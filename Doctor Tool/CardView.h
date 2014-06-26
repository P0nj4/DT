#import <UIKit/UIKit.h>

@protocol CardViewDelegate <NSObject>

- (void)CardFliped:(BOOL)isFlipped;

@end

@interface CardView : UIView

@property (assign, nonatomic, readonly) BOOL isFlipped;
@property (nonatomic, assign) BOOL useBackground;
@property (nonatomic, weak) id<CardViewDelegate> delegate;

- (id)initWithFrontView:(UIView *)frontView backView:(UIView *)backView Frame:(CGRect)frame withGesture:(BOOL)gesture;
- (void)flip;
@end
