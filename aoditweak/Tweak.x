#import <UIKit/UIKit.h>

#define QTFile(path) @"/Library/PreferenceLoader/Preferences/audi/" #path
#define PluginPath @"/Library/PreferenceLoader/Preferences/audi/"

@interface _TtC11AudiVehicle30AudiVehicleIndexViewController : UIViewController

@property(nonatomic) __weak UIView *vehicleBaseInfoView; // @synthesize vehicleBaseInfoView;
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
	
	UIImageView *qt_photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    qt_photoImage.contentMode = UIViewContentModeScaleAspectFill;
    qt_photoImage.image = image;
    [baseInfoView insertSubview:qt_photoImage atIndex:0];
}

%end
