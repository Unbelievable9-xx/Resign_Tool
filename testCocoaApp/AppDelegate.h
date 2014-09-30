#import <Cocoa/Cocoa.h>
#import "IRTextFieldDrag.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSTask *unzipIpaTask;
    NSTask *zipIpaTask;
    NSTask *mergeTask;
    NSTask *mergeTask2;
    NSTask *otoolTask;
    NSTask *otoolTask4Armv7;
    NSTask *otoolTask4Armv7s;
    NSTask *separateTask1;
    NSTask *separateTask2;
    NSTask *resignTask;
    NSTask *entitlementTask;
    
    NSString *originalWorkingPath;
    NSString *originalIpaPath;
    NSString *originalCertPath;
    NSString *currentIpaPath;
    NSString *crackedArmv7FilePath;
    NSString *crackedArmv7sFilePath;
    NSString *crackedArm64FilePath;

    NSString *appName;
    NSString *ExecutableName;
    NSMutableDictionary *infoList;
    
    NSInteger numOfArmSupported;
    NSInteger arcOffsize4v7;
    NSInteger arcOffsize4v7s;
    NSInteger arcOffsize464;
    NSInteger cryptoff4v7;
    NSInteger cryptsize4v7;
    NSInteger cryptoff4v7s;
    NSInteger cryptsize4v7s;
    //NSInteger arcOffsieze464;
    
    IBOutlet IRTextFieldDrag *ipaPathDrag;
    IBOutlet IRTextFieldDrag *armv7PathDrag;
    IBOutlet IRTextFieldDrag *armv7sPathDrag;
    IBOutlet IRTextFieldDrag *arm64PathDrag;
    
    IBOutlet NSButton *ipaBrowseButton;
    IBOutlet NSButton *armv7BrowseButton;
    IBOutlet NSButton *armv7sBrowseButton;
    IBOutlet NSButton *arm64BrowseButton;
    IBOutlet NSButton *mergeButton;
    IBOutlet NSButton *creatIpaButton;
    IBOutlet NSButton *resignButton;
    IBOutlet NSTextField *statusItem;
    IBOutlet NSTextField *showProgressItem;
    IBOutlet NSImageView *appIcon;
}
@property (assign) IBOutlet NSWindow *window;



- (void)analyzeIpa;
- (void)getInformationAboutIpa;
- (void)getParameters;

- (IBAction)browseIpa:(id)sender;
- (IBAction)browseArmv7:(id)sender;
- (IBAction)browseArmv7s:(id)sender;
- (IBAction)browseArm64:(id)sender;
- (IBAction)tap2Merge:(id)sender;
- (IBAction)tap2CreateIpa:(id)sender;
- (IBAction)tap2Resign:(id)sender;

@end
