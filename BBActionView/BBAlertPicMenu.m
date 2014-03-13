
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


#import "BBAlertPicMenu.h"
#import <QuartzCore/QuartzCore.h>

#import "BBMenuHeaderView.h"

@interface BBAlertPicMenu ()

@property (nonatomic, strong) BBMenuHeaderView *headerView;
@property (nonatomic, strong) UIImageView *contentImageView;;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) BBButton *cancelButton;

@property (nonatomic, strong) NSString *imgPath;

@property (nonatomic, strong) NSArray *itemTitles;
@property (nonatomic, strong) NSArray *itemImages;
@property (nonatomic, strong) NSArray *gridItems;


@property (nonatomic, strong) void(^actionHandle)(NSInteger);

@end

@implementation BBAlertPicMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _contentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentImageView];
        
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _contentScrollView.contentSize = _contentScrollView.bounds.size;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_contentScrollView];
        
        _cancelButton = [BBButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.clipsToBounds = YES;
        [_cancelButton setBackgroundColor:[UIColor lightGrayColor]];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton setTitleColor:BBActionViewTextColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self
                          action:@selector(cancelButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        [self addSubview:_cancelButton];
        
    }
    return self;
}

- (void)cancelButtonClicked:(id)sender {
    if (self.actionHandle) {
        double delayInSeconds = 0.15;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.actionHandle(12024);
        });
    }
}


- (instancetype)initWithImagePath:(NSString *)imagePath
                         subTitle:(NSString *)subStr
                      gridBtnType:(GridBtnType)type {
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        _headerView = [[BBMenuHeaderView alloc] initWithIcon:@"twitter.png" title:@"The Header View" subTitle:subStr];
        [self addSubview:_headerView];
        
        _contentImageView.image = [UIImage imageNamed:imagePath];
        
        [self setupWithSubTitle:subStr gridBtnType:type];
    }
    return self;
}


- (void)setupWithSubTitle:(NSString *)title gridBtnType:(GridBtnType)type
{
    [self setupGridItemsWithItemTitles:@[ @"Facebook",
//                                          @"Twitter",
//                                          @"Google+",
                                          @"Linkedin" ]
                                images:@[ [UIImage imageNamed:@"facebook"],
//                                          [UIImage imageNamed:@"twitter"],
//                                          [UIImage imageNamed:@"googleplus"],
                                          [UIImage imageNamed:@"linkedin"]]];
}


- (void)setupGridItemsWithItemTitles:(NSArray *)titles images:(NSArray *)images
{
    NSMutableArray *items = [NSMutableArray array];
    for (int i=0; i<titles.count; i++) {
        BBGridItem *item = [[BBGridItem alloc] initWithTitle:titles[i] image:images[i]];
        item.menu = self;
        item.tag = i+1077;
        [item addTarget:self action:@selector(BBGridItemTapAction:) forControlEvents:UIControlEventTouchUpInside];
        [items addObject:item];
        [_contentScrollView addSubview:item];
    }
    _gridItems = [NSArray arrayWithArray:items];
}

- (void)BBGridItemTapAction:(id)sender {
    BBGridItem *item = (BBGridItem *)sender;
    
    if (self.actionHandle) {
        double delayInSeconds = 0.15;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            self.actionHandle([sender tag] + 1);
        });
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float height = 0;
    float table_bottom_margin = 8;
    
    height += _headerView.bounds.size.height;
    height += table_bottom_margin+4;
    
    _contentImageView.frame = (CGRect){CGPointMake(10, height), CGSizeMake(300, 128.0)};
    height += _contentImageView.bounds.size.height;
    height += table_bottom_margin;
    
    [self layoutGridScrollView];
    _contentScrollView.frame = (CGRect){CGPointMake(0, height), self.contentScrollView.bounds.size};
    
    height += self.contentScrollView.frame.size.height;
    
    _cancelButton.frame = CGRectMake(0.0, height, self.bounds.size.width, 44);
    height += _cancelButton.frame.size.height;
    
    self.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, height)};
}

- (void)layoutGridScrollView
{
    NSInteger itemCount = self.gridItems.count;
    if (itemCount < 1) {
        self.contentScrollView.bounds = (CGRect){CGPointZero, CGSizeMake(SCREEN_WIDTH, 0)};
        return;
    }

    UIEdgeInsets margin = UIEdgeInsetsMake(0, 10, 15, 10);
    CGSize itemSize = CGSizeMake((self.bounds.size.width - margin.left - margin.right) / 4, 80);
    
    // x-margin-plus
    int lg = itemCount % 4;
    float width_offset= 0;
    if (lg != 0) {
        width_offset = (4-lg) * (itemSize.width/2);
    }

    float curContentWidth = itemCount * itemSize.width + margin.left + margin.right;
    float contentWidth =  (curContentWidth > SCREEN_WIDTH) ? curContentWidth : SCREEN_WIDTH ;
    
    _contentScrollView.contentSize = CGSizeMake(contentWidth, itemSize.height + 5);
    for (int i=0; i<itemCount; i++) {
        BBGridItem *item = self.gridItems[i];
        int column = i;
        CGPoint p = CGPointMake(margin.left + column * itemSize.width + width_offset, margin.top);
        item.frame = (CGRect){p, itemSize};
        [item layoutIfNeeded];
    }
    
    if (self.contentScrollView.contentSize.width > SCREEN_WIDTH) {
        self.contentScrollView.bounds = (CGRect){CGPointZero, CGSizeMake(SCREEN_WIDTH, 80)};
    }else{
        self.contentScrollView.bounds = (CGRect){CGPointZero, self.contentScrollView.contentSize};
    }
}


#pragma mark -
- (void)triggerSelectedAction:(void(^)(NSInteger))actionHandle
{
    self.actionHandle = actionHandle;
}

@end
