
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


#import "BBMenuHeaderView.h"


@interface BBMenuHeaderView ()

@property(nonatomic) UIImageView *imageView;
@property(nonatomic) UILabel  *title;
@property(nonatomic) UILabel  *subTitle;

@end

@implementation BBMenuHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = nil;
        _subTitle = nil;
        _imageView = nil;
    }
    return self;
}

- (instancetype)initWithIcon:(NSString *)iconPath title:(NSString *)name subTitle:(NSString *)subname;
{
#define DEF_HEADER_RECT CGRectMake(0, 0, 320, 50.0)
    self = [self initWithFrame:DEF_HEADER_RECT];
    if (self) {
        [self setupViewWithIcon:iconPath title:name SubTitle:subname];
    }
    return self;

}

- (void)setupViewWithIcon:(NSString *)icon title:(NSString *)name SubTitle:(NSString *)subname {
    self.backgroundColor = [UIColor yellowColor];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    [self addSubview:_imageView];
    
    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    _title.backgroundColor = [UIColor clearColor];
    _title.font = [UIFont boldSystemFontOfSize:20.0];
    _title.textAlignment = NSTextAlignmentLeft;
    _title.textColor = [UIColor brownColor];
    _title.text = name;
    [self addSubview:_title];
    
    if (subname) {
        _subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitle.backgroundColor = [UIColor clearColor];
        _subTitle.font = [UIFont systemFontOfSize:15];
        _subTitle.textAlignment = NSTextAlignmentRight;
        _subTitle.textColor = [UIColor blackColor];
        _subTitle.numberOfLines = 0;
        _subTitle.text = subname;
        [self addSubview:_subTitle];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
 
    float top_margin = 5.0;
    
    if (_imageView) {
        _imageView.frame = CGRectMake(5.0, top_margin, 40.0, 40.0);
    }
    
    if (_title) {
        _title.frame = (CGRect){CGPointMake(50.0, top_margin), CGSizeMake(200.0, 44)};
    }
    if (_subTitle) {
        _subTitle.frame = (CGRect){CGPointMake(255, top_margin+6), CGSizeMake(60, 34)};
    }
    
    self.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, 50.0)};
}

@end
