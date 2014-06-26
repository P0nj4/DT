
#import "CardView.h"
#import <QuartzCore/QuartzCore.h>

@interface CardView ()

@property (assign, nonatomic, readwrite) BOOL isFlipped;



- (void)addSwipeRecognizerForDirection:(UISwipeGestureRecognizerDirection)direction;
- (void)flipCard:(UIViewAnimationOptions)options;
- (void)isTapped:(UITapGestureRecognizer *)recognizer;
- (void)isSwiped:(UISwipeGestureRecognizer *)recognizer;

@end

@implementation CardView

@synthesize isFlipped, useBackground;
@synthesize front, back;



- (id)initWithFrontView:(UIView *)frontView backView:(UIView *)backView Frame:(CGRect)frame withGesture:(BOOL)gesture
{
    CGRect rect = frame;
    
    self = [super initWithFrame:rect];
    if (self) {
        self.isFlipped = NO;
        self.backgroundColor = [UIColor clearColor];
        
        // Setip the front view
        self.front = frontView;

        // Setip the back view
        self.back = backView;

        // Add both views
        [self addSubview:self.front];
        [self addSubview:self.back];
        if(gesture){
            // Add gesture recognizers
            //[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isTapped:)]];
            
            [self addSwipeRecognizerForDirection:UISwipeGestureRecognizerDirectionLeft];
            [self addSwipeRecognizerForDirection:UISwipeGestureRecognizerDirectionRight];
        }
    }
    return self;
}

- (void)addSwipeRecognizerForDirection:(UISwipeGestureRecognizerDirection)direction
{
    // Create a swipe recognizer for the wanted direction
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(isSwiped:)];
    swipeRecognizer.direction = direction;
    [self addGestureRecognizer:swipeRecognizer];
}

- (void)flip{
    [self isTapped:nil];
}

- (void)flipWithoutAnimation{
    self.isFlipped = YES;
    [UIView transitionFromView:self.back toView:self.front duration:0. options:(UIViewAnimationOptionTransitionFlipFromRight) completion:^(BOOL finished) {
        [self.delegate CardFliped:!self.isFlipped];
        
    }];
}

#pragma mark - Gesture recognizer handlers
- (void)isTapped:(UITapGestureRecognizer *)recognizer
{
    if(self.isFlipped == NO){
        [self flipCard:UIViewAnimationOptionTransitionFlipFromRight];
    }else{
        if(!recognizer){
            [self flipCard:UIViewAnimationOptionTransitionFlipFromLeft];
        }
    }
}

- (void)isSwiped:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self flipCard:UIViewAnimationOptionTransitionFlipFromRight];
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self flipCard:UIViewAnimationOptionTransitionFlipFromLeft];
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        [self flipCard:UIViewAnimationOptionTransitionFlipFromTop];
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        [self flipCard:UIViewAnimationOptionTransitionFlipFromBottom];
    }
}

#pragma mark - flip action
- (void)flipCard:(UIViewAnimationOptions)options
{
    if (self.isFlipped == NO) {
        if(useBackground){
            UIView *background = [self.superview viewWithTag:58585];
            if(!background){
                background = [[UIView alloc] initWithFrame:self.superview.bounds];
                background.alpha = 0.;
                background.tag = 58585;
                background.backgroundColor = [UIColor blackColor];
                [self.superview insertSubview:background atIndex:3];
            }
            
            
            [UIView animateWithDuration:0.3 animations:^{
                background.alpha = 0.4;
            }];
        }
        [UIView transitionFromView:self.back toView:self.front duration:0.4 options:options completion:^(BOOL finished) {
            [self.delegate CardFliped:!self.isFlipped];
            
        }];

        self.isFlipped = YES;
    }
    else {
        if(useBackground){
            UIView *background = [self.superview viewWithTag:58585];
            if(background){
                [UIView animateWithDuration:0.2 animations:^{
                    background.alpha = 0.;
                }];
            }
        }
        [UIView transitionFromView:self.front toView:self.back duration:0.4 options:options completion:^(BOOL finished) {
            [self.delegate CardFliped:!self.isFlipped];
            
        }];
        self.isFlipped = NO;
    }
}

@end
