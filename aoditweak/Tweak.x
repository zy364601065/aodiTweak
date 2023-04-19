#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#define QTFile(path) @"/Library/PreferenceLoader/Preferences/audi/" #path
#define PluginPath @"/Library/PreferenceLoader/Preferences/audi/"

@interface _TtC11AudiVehicle30AudiVehicleIndexViewController : UIViewController

@property(nonatomic) __weak UIView *vehicleBaseInfoView; // @synthesize vehicleBaseInfoView;
@property(nonatomic) __weak UIView *vehicleImagePagerView; // @synthesize vehicleImagePagerView;

- (void)viewDidLoad;

@end

%hook _TtC11AudiVehicle30AudiVehicleIndexViewController

- (void)viewDidLoad {

	%orig;

	NSString *imageName = @"dt_icon";
    NSString *imagePath = [PluginPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.png",imageName]];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage imageWithData:imageData scale:2];

	UIView *baseInfoView =[self vehicleBaseInfoView];
	
	UIImageView *qt_photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, baseInfoView.frame.size.height)];
    qt_photoImage.contentMode = UIViewContentModeScaleAspectFill;
    qt_photoImage.image = image;
    [baseInfoView insertSubview:qt_photoImage atIndex:0];

    UIView *vehicleImageView = [self vehicleImagePagerView];
    vehicleImageView.backgroundColor = [UIColor clearColor];

    for (UIView *subView in vehicleImageView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *carImage = (UIImageView *)subView;
            // 加载原始图片
            UIImage *originalImage = carImage.image;

            // 创建一个图形上下文
            UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, originalImage.scale);

            // 将原始图片绘制到图形上下文中
            [originalImage drawAtPoint:CGPointZero];

            // 获取图形上下文中的图片
            UIImage *imageWithoutWhiteBackground = UIGraphicsGetImageFromCurrentImageContext();

            // 关闭图形上下文
            UIGraphicsEndImageContext();
            break;
        }
    }
}

%end
