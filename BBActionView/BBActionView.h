
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


#import <UIKit/UIKit.h>

#define IMG_PATH(pic_name) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pic_name]
#define OBJ_IMG(img_name) [UIImage imageNamed:IMG_PATH(img_name)]
#define BBActionViewTextColor  [UIColor whiteColor]

typedef enum _BBActionSheetType {
	BBActionSheetTypeLocation = 0,
    BBActionSheetTypeLine = 1,
    BBActionSheetTypeStation
} BBActionSheetType;



@class BBActionView;
typedef void(^BBMenuActionHandler)(NSInteger index);
typedef void(^BBMenuBeginActionHandler)(void);
typedef void(^BBMenuEndActionHandler)(void);


@interface BBActionView : UIView

/**
 *	BBAlertView
 */
+ (void)showBBAlertMenuIn:(UIView  *)bgView
                withTitle:(NSString*)title
               itemTitles:(NSArray *)itemTitles
            itemSubTitles:(NSArray *)itemSubTitles
              startHandle:(BBMenuBeginActionHandler)startHandle
                endHandle:(BBMenuEndActionHandler)endHandle
           selectedHandle:(BBMenuActionHandler)handler;

/**
 *	BBAlertPicMenu
 */
+ (void)showBBImageMenuIn:(UIView   *)bgView
                 subTitle:(NSString *)subTitle
                imagePath:(NSString *)imgUrl
              startHandle:(BBMenuBeginActionHandler)startHandle
                endHandle:(BBMenuEndActionHandler)endHandle
           selectedHandle:(BBMenuActionHandler)handler;
@end

