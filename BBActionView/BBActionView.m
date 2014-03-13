
/*_______________________________________________________________________
_________________________________________________________________________
___________________________________________.._.vr________________________
_________________________________________qBMBBBMBMY______________________
________________________________________8BBBBBOBMBMv_____________________
______________________________________iMBMM5vOY:BMBBv____________________
______________________.r,_____________OBM;___.:_rBBBBBY__________________
______________________vUL_____________7BB___.;7._LBMMBBM.________________
_____________________.@Wwz.___________:uvir_.i:.iLMOMOBM.._______________
______________________vv::r;_____________iY._...rv,@arqiao.______________
_______________________Li._i:_____________v:.::::7vOBBMBL..______________
_______________________,i7:_vSUi,_________:M7.:.,:u08OP._._______________
_________________________.N2k5u1ju7,.._____BMGiiL7___,i,i._______________
__________________________:rLjFYjvjLY7r::.__;v__vr..._rE8q;.:,,__________
_________________________751jSLXPFu5uU@guohezou.,1vjY2E8@Yizero._________
_________________________BB:FMu_rkM8Eq0PFjF15FZ0Xu15F25uuLuu25Gi.________
_______________________ivSvvXL____:v58ZOGZXF2UUkFSFkU1u125uUJUUZ,________
_____________________:@kevensun.______,iY20GOXSUXkSuS2F5XXkUX5SEv._______
_________________.:i0BMBMBBOOBMUi;,________,;8PkFP5NkPXkFqPEqqkZu._______
_______________.rqMqBBMOMMBMBBBM_.___________@kexianli.S11kFSU5q5________
_____________.7BBOi1L1MM8BBBOMBB..,__________8kqS52XkkU1Uqkk1kUEJ________
_____________.;MBZ;iiMBMBMMOBBBu_,___________1OkS1F1X5kPP112F51kU________
_______________.rPY__OMBMBBBMBB2_,.__________rME5SSSFk1XPqFNkSUPZ,.______
______________________;;JuBML::r:.:.,,________SZPX0SXSP5kXGNP15UBr.______
__________________________L,____:@huhao.______:MNZqNXqSqXk2E0PSXPE_._____
______________________viLBX.,,v8Bj._i:r7:,_____2Zkqq0XXSNN0NOXXSXOU______
____________________:r2._rMBGBMGi_.7Y,_1i::i___vO0PMNNSXXEqP@Secbone.____
____________________.i1r._.jkY,____vE._iY....__20Fq0q5X5F1S2F22uuv1M;____
_________________________________________________________________________
_________________________________________________________________________
_______________________________________________________________________*/

#import "BBActionView.h"
#import <QuartzCore/QuartzCore.h>

#import "BBBaseMenu.h"
#import "BBAlertMenu.h"
#import "BBAlertPicMenu.h"


@interface BBActionView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableArray *menus;
@property (nonatomic, strong) CAAnimation *showMenuAnimation;
@property (nonatomic, strong) CAAnimation *dismissMenuAnimation;
@property (nonatomic, strong) CAAnimation *dimingAnimation;
@property (nonatomic, strong) CAAnimation *lightingAnimation;
// 点击背景取消
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

// 点击了背景，在消失前 的处理函数
@property (nonatomic, strong) void(^beforeDisappear)(void);

@end


@implementation BBActionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _menus = [NSMutableArray array];
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        _tapGesture.delegate = self;
        [self addGestureRecognizer:_tapGesture];
    }
    return self;
}

- (void)dealloc{
    NSLog(@"bb action view dealloc");
    [self removeGestureRecognizer:_tapGesture];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture{
    CGPoint touchPoint = [tapGesture locationInView:self];

    BBBaseMenu *menu = self.menus.lastObject;
    if (!CGRectContainsPoint(menu.frame, touchPoint)) {
        if (_beforeDisappear != nil) {
            NSLog(@"before disapppear in taped");
            _beforeDisappear();
        }
        [self dismissMenu:menu Animated:YES];
        [self.menus removeObject:menu];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isEqual:self.tapGesture]) {
        CGPoint p = [gestureRecognizer locationInView:self];
        BBBaseMenu *topMenu = self.menus.lastObject;
        if (CGRectContainsPoint(topMenu.frame, p)) {
            return NO;
        }
    }
    return YES;
}

#pragma mark -
- (void)setMenu:(UIView *)menu animation:(BOOL)animated{
    if (![self superview]) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:self];
    }
    
    BBBaseMenu *topMenu = (BBBaseMenu *)menu;
    
    [self.menus makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.menus addObject:topMenu];
    
    [self addSubview:topMenu];
    [topMenu layoutIfNeeded];
    topMenu.frame = (CGRect){CGPointMake(0, self.bounds.size.height - topMenu.bounds.size.height), topMenu.bounds.size};
    
    if (animated && self.menus.count == 1) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.2];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [self.layer addAnimation:self.dimingAnimation forKey:@"diming"];
        [topMenu.layer addAnimation:self.showMenuAnimation forKey:@"showMenu"];
        [CATransaction commit];
    }
}

- (void)dismissMenu:(BBBaseMenu *)menu Animated:(BOOL)animated
{
    if ([self superview]) {
        [self.menus removeObject:menu];
        if (animated && self.menus.count == 0) {
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.2];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
            [CATransaction setCompletionBlock:^{
                [self removeFromSuperview];
                [menu removeFromSuperview];
            }];
            [self.layer addAnimation:self.lightingAnimation forKey:@"lighting"];
            [menu.layer addAnimation:self.dismissMenuAnimation forKey:@"dismissMenu"];
            [CATransaction commit];
        }else{
            [menu removeFromSuperview];
            
            BBBaseMenu *topMenu = self.menus.lastObject;
            [self addSubview:topMenu];
            [topMenu layoutIfNeeded];
            topMenu.frame = (CGRect){CGPointMake(0, self.bounds.size.height - topMenu.bounds.size.height), topMenu.bounds.size};
        }
    }
}

- (void)setMenu:(UIView *)menu inView:(UIView *)bgView animation:(BOOL)animated{
    if (![self superview]) {
        [bgView addSubview:self];
    }
    
    BBBaseMenu *topMenu = (BBBaseMenu *)menu;
    
    [self.menus makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.menus addObject:topMenu];
    
    [self addSubview:topMenu];
    [topMenu layoutIfNeeded];
    topMenu.frame = (CGRect){CGPointMake(0, self.bounds.size.height - topMenu.bounds.size.height), topMenu.bounds.size};
    
    if (animated && self.menus.count == 1) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.2];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [self.layer addAnimation:self.dimingAnimation forKey:@"diming"];
        [topMenu.layer addAnimation:self.showMenuAnimation forKey:@"showMenu"];
        [CATransaction commit];
    }
}

- (void)dismissMenu:(BBBaseMenu *)menu inView:(UIView *)bgView Animated:(BOOL)animated
{
    if ([self superview]) {
        [self.menus removeObject:menu];
        if (animated && self.menus.count == 0) {
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.2];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
            [CATransaction setCompletionBlock:^{
                [menu removeFromSuperview];
                [self removeFromSuperview];
            }];
            [self.layer addAnimation:self.lightingAnimation forKey:@"lighting"];
            [menu.layer addAnimation:self.dismissMenuAnimation forKey:@"dismissMenu"];
            [CATransaction commit];
        }else{
            [menu removeFromSuperview];
            
            BBBaseMenu *topMenu = self.menus.lastObject;
            [self addSubview:topMenu];
            [topMenu layoutIfNeeded];
            topMenu.frame = (CGRect){CGPointMake(0, self.bounds.size.height - topMenu.bounds.size.height), topMenu.bounds.size};
        }
    }
}


#pragma mark -

- (CAAnimation *)dimingAnimation
{
    if (_dimingAnimation == nil) {
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        opacityAnimation.fromValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.0] CGColor];
        opacityAnimation.toValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.4] CGColor];
        [opacityAnimation setRemovedOnCompletion:NO];
        [opacityAnimation setFillMode:kCAFillModeBoth];
        _dimingAnimation = opacityAnimation;
    }
    return _dimingAnimation;
}

- (CAAnimation *)lightingAnimation
{
    if (_lightingAnimation == nil ) {
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        opacityAnimation.fromValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.4] CGColor];
        opacityAnimation.toValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.0] CGColor];
        [opacityAnimation setRemovedOnCompletion:NO];
        [opacityAnimation setFillMode:kCAFillModeBoth];
        _lightingAnimation = opacityAnimation;
    }
    return _lightingAnimation;
}

- (CAAnimation *)showMenuAnimation
{
    if (_showMenuAnimation == nil) {
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 1 / -500.0f;
        CATransform3D from = CATransform3DRotate(t, -30.0f * M_PI / 180.0f, 1, 0, 0);
        CATransform3D to = CATransform3DIdentity;
        [rotateAnimation setFromValue:[NSValue valueWithCATransform3D:from]];
        [rotateAnimation setToValue:[NSValue valueWithCATransform3D:to]];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [scaleAnimation setFromValue:@0.9];
        [scaleAnimation setToValue:@1.0];
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        [positionAnimation setFromValue:[NSNumber numberWithFloat:50.0]];
        [positionAnimation setToValue:[NSNumber numberWithFloat:0.0]];
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [opacityAnimation setFromValue:@0.0];
        [opacityAnimation setToValue:@1.0];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        [group setAnimations:@[rotateAnimation, scaleAnimation, opacityAnimation, positionAnimation]];
        [group setRemovedOnCompletion:NO];
        [group setFillMode:kCAFillModeBoth];
        _showMenuAnimation = group;
    }
    return _showMenuAnimation;
}

- (CAAnimation *)dismissMenuAnimation
{
    if (_dismissMenuAnimation == nil) {
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 1 / -500.0f;
        CATransform3D from = CATransform3DIdentity;
        CATransform3D to = CATransform3DRotate(t, -30.0f * M_PI / 180.0f, 1, 0, 0);
        [rotateAnimation setFromValue:[NSValue valueWithCATransform3D:from]];
        [rotateAnimation setToValue:[NSValue valueWithCATransform3D:to]];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [scaleAnimation setFromValue:@1.0];
        [scaleAnimation setToValue:@0.9];
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        [positionAnimation setFromValue:[NSNumber numberWithFloat:0.0]];
        [positionAnimation setToValue:[NSNumber numberWithFloat:50.0]];
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [opacityAnimation setFromValue:@1.0];
        [opacityAnimation setToValue:@0.0];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        [group setAnimations:@[rotateAnimation, scaleAnimation, opacityAnimation, positionAnimation]];
        [group setRemovedOnCompletion:NO];
        [group setFillMode:kCAFillModeBoth];
        _dismissMenuAnimation = group;
    }
    return _dismissMenuAnimation;
}

#pragma mark -
+ (void)showBBAlertMenuIn:(UIView  *)bgView
                withTitle:(NSString*)title
               itemTitles:(NSArray *)itemTitles
            itemSubTitles:(NSArray *)itemSubTitles
              startHandle:(BBMenuBeginActionHandler)startHandle
                endHandle:(BBMenuEndActionHandler)endHandle
           selectedHandle:(BBMenuActionHandler)handler {
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    BBActionView *sv = [[BBActionView alloc] initWithFrame:rect];
    BBAlertMenu *menu = [[BBAlertMenu alloc] initWithTitle:title itemTitles:itemTitles subTitles:itemSubTitles];
    
    if (endHandle) {
        sv.beforeDisappear = endHandle;
    }
    
    if (startHandle) {
        NSLog(@"start hander");
        startHandle();
    }
    
    __weak BBActionView *s = sv;
    __weak BBAlertMenu  *a = menu;
    [menu triggerSelectedAction:^(NSInteger index) {
        if (index == 11024) {
            if (endHandle) {
                NSLog(@"end hander");
                endHandle();
            }
            [s dismissMenu:a Animated:YES];
        } else {
            if (handler) {
                NSLog(@"in hander");
                handler(index);
            }
        }
    }];
    
    [sv setMenu:menu inView:bgView animation:YES];
}


+ (void)showBBImageMenuIn:(UIView *) bgView
                 subTitle:(NSString *)subTitle
                imagePath:(NSString *)imgUrl
              startHandle:(BBMenuBeginActionHandler)startHandle
                endHandle:(BBMenuEndActionHandler)endHandle
           selectedHandle:(BBMenuActionHandler)handler {
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    BBActionView *sv = [[BBActionView alloc] initWithFrame:rect];
    BBAlertPicMenu *menu = [[BBAlertPicMenu alloc] initWithImagePath:imgUrl subTitle:subTitle gridBtnType:GridBtnEventShare|GridBtnEventSetAsEnd|GridBtnEventCollectStation];
    if (endHandle) {
        sv.beforeDisappear = endHandle;
    }
    
    if (startHandle) {
        NSLog(@"start pic hander");
        startHandle();
    }
    __weak BBActionView *s = sv;
    __weak BBAlertPicMenu  *a = menu;
    [menu triggerSelectedAction:^(NSInteger index) {
        if (index == 12024) {
            if (endHandle) {
                NSLog(@"end  pic hander");
                endHandle();
            }
            [s dismissMenu:a Animated:YES];
        } else {
            if (handler) {
                NSLog(@"in pic hander");
                handler(index);
            }
        }
    }];
    
    [sv setMenu:menu inView:bgView animation:YES];
}


@end
