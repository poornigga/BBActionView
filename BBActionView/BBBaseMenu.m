
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


#import "BBBaseMenu.h"

#import <QuartzCore/QuartzCore.h>
#include <sys/sysctl.h>


///////////////////////////////////////////////////////////
///   BBButton
///////////////////////////////////////////////////////////
@implementation BBButton
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.backgroundColor = [UIColor grayColor];
    } else {
        double delayInSeconds = 0.15;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.backgroundColor = [UIColor clearColor];
        });
    }
}
@end



///////////////////////////////////////////////////////////
///   BBGridItem
///////////////////////////////////////////////////////////
@implementation BBGridItem
- (id)initWithTitle:(NSString *)title image:(UIImage *)image
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
#define EVENT_NUM_BASE 2530
        self.eventNum = EVENT_NUM_BASE;
        self.clipsToBounds = NO;
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    
    CGRect imageRect = CGRectMake(width * 0.2, width * 0.2, width * 0.6, width * 0.6);
    self.imageView.frame = imageRect;
    
    float labelHeight = height - (imageRect.origin.y + imageRect.size.height);
    CGRect labelRect = CGRectMake(width * 0.05, imageRect.origin.y + imageRect.size.height, width * 0.9, labelHeight);
    self.titleLabel.frame = labelRect;
}

@end


///////////////////////////////////////////////////////////
///   BBBaseMenu
///////////////////////////////////////////////////////////
@implementation BBBaseMenu

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setRoundedCorner:YES];
    }
    return self;
}

- (void)setRoundedCorner:(BOOL)roundedCorner {
    if (roundedCorner) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                                                         cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }else{
        self.layer.mask = nil;
    }
    _roundedCorner = roundedCorner;
    [self setNeedsDisplay];
}

- (BOOL)nicePerformance{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *name = malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    
    free(name);
    
    BOOL b = YES;
    if ([machine hasPrefix:@"iPhone"]) {
        b = [[machine substringWithRange:NSMakeRange(6, 1)] intValue] >= 4;
    }else if ([machine hasPrefix:@"iPod"]){
        b = [[machine substringWithRange:NSMakeRange(4, 1)] intValue] >= 5;
    }else if ([machine hasPrefix:@"iPad"]){
        b = [[machine substringWithRange:NSMakeRange(4, 1)] intValue] >= 2;
    }
    
    return b;
}



// 上车提醒
- (void)getOnRemind {
    
}

// 下车提醒
- (void)getOffRemind {
    
}

// 我要分享
- (void)shareTo:(id)other {
    
}

// 收藏路线
- (void)collectLine {
    
}

//   收藏位置
- (void)collectLocation {
    
}

//  收藏站台
- (void)collectStation {
    
}

// 设为起点
- (void)setAsBeginStation:(id)sender {
    
}

// 设为终点
- (void)setAsEndStation:(id)sender {
    
}

- (void)dealloc {
    NSLog(@"base menu dealloc");
}


@end
