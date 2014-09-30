
#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.window.title = @"自动破解小工具-1.1";
    
    numOfArmSupported = 0;
    
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    if (!flag) {
        
        self.window.isVisible = YES;
    }
    
    return YES;
}

- (void)browseIpa:(id)sender
{
    [armv7BrowseButton setHidden:NO];
    [armv7PathDrag setHidden:NO];
    [armv7sBrowseButton setHidden:NO];
    [armv7sPathDrag setHidden:NO];
    [arm64PathDrag setHidden:NO];
    [arm64BrowseButton setHidden:NO];
    
    NSOpenPanel *openPanel4Ipa = [NSOpenPanel openPanel];
    
    [openPanel4Ipa setCanChooseFiles:TRUE];
    [openPanel4Ipa setCanChooseDirectories:FALSE];
    [openPanel4Ipa setAllowsMultipleSelection:FALSE];
    [openPanel4Ipa setAllowsOtherFileTypes:FALSE];
    [openPanel4Ipa setAllowedFileTypes:@[@"ipa", @"IPA",@"Ipa",@"iPA"]];
    
    if ([openPanel4Ipa runModal] == NSOKButton) {
        
        NSString *ipaNameOfTheChosenOne = [[[openPanel4Ipa URLs] objectAtIndex:0] path];
        [ipaPathDrag setStringValue:[ipaNameOfTheChosenOne lastPathComponent]];
        originalWorkingPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Desktop/CrackFiles"];
        originalCertPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Desktop/Cert4Crack"];
        originalIpaPath = ipaNameOfTheChosenOne;
    }
    
    NSArray *array4FileName = [[ipaPathDrag.stringValue lastPathComponent] componentsSeparatedByString:@"."];
    currentIpaPath = [originalWorkingPath stringByAppendingPathComponent:[array4FileName objectAtIndex:0]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:originalWorkingPath]) {
        
        [[NSFileManager defaultManager] removeItemAtPath:originalWorkingPath error:nil];
    }
    
    [[NSFileManager defaultManager] createDirectoryAtPath:currentIpaPath withIntermediateDirectories:YES attributes:nil error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:[originalWorkingPath stringByAppendingPathComponent:@"tmp"] withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:originalCertPath]) {
     
        [[NSFileManager defaultManager] createDirectoryAtPath:originalCertPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    unzipIpaTask = [[NSTask alloc] init];
    [unzipIpaTask setLaunchPath:@"/usr/bin/unzip"];
    [unzipIpaTask setArguments:[NSArray arrayWithObjects:@"-q", originalIpaPath, @"-d", currentIpaPath,nil]];
    
    [unzipIpaTask launch];
    [unzipIpaTask waitUntilExit];
    
    numOfArmSupported = 0;
    
    if (ipaPathDrag.stringValue.length != 0) {
        
        showProgressItem.stringValue = @"ipa已读取";
    }
    
    [self displayPic];
    
    [self analyzeIpa];
    [self getInformationAboutIpa];
    

}

- (void)displayPic
{
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:[currentIpaPath stringByAppendingPathComponent:@"iTunesArtwork"]];
    
    NSLog(@"%hhd", [image isValid]);
    
    [appIcon setImage:image];
    [self.window.contentView addSubview:appIcon];
    
}

-(void)browseArmv7:(id)sender
{
    NSOpenPanel *openPanel4Armv7 = [NSOpenPanel openPanel];
    
    [openPanel4Armv7 setCanChooseFiles:TRUE];
    [openPanel4Armv7 setCanChooseDirectories:FALSE];
    [openPanel4Armv7 setAllowsMultipleSelection:FALSE];
    [openPanel4Armv7 setAllowsOtherFileTypes:NO];
    [openPanel4Armv7 setAllowedFileTypes:@[@"armv7"]];
    
    if ([openPanel4Armv7 runModal] == NSOKButton) {
        
        NSString *fileNameOfTheChosenOne = [[[openPanel4Armv7 URLs] objectAtIndex:0] path];
        crackedArmv7FilePath = fileNameOfTheChosenOne;
        [armv7PathDrag setStringValue:[fileNameOfTheChosenOne lastPathComponent]];
    }
    
    if (armv7PathDrag.stringValue.length != 0) {
        
        showProgressItem.stringValue = @"armv7破解文件已读取";
        
    }

}

-(void)browseArmv7s:(id)sender
{
    NSOpenPanel *openPanel4Armv7s = [NSOpenPanel openPanel];
    
    [openPanel4Armv7s setCanChooseFiles:TRUE];
    [openPanel4Armv7s setCanChooseDirectories:FALSE];
    [openPanel4Armv7s setAllowsMultipleSelection:FALSE];
    [openPanel4Armv7s setAllowsOtherFileTypes:FALSE];
    [openPanel4Armv7s setAllowedFileTypes:@[@"armv7s"]];
    
    if ([openPanel4Armv7s runModal] == NSOKButton) {
        
        NSString *nameOfTheChosenOne = [[[openPanel4Armv7s URLs] objectAtIndex:0] path];
        crackedArmv7sFilePath = nameOfTheChosenOne;
        [armv7sPathDrag setStringValue:[nameOfTheChosenOne lastPathComponent]];
    }
    
    if (armv7sPathDrag.stringValue.length != 0) {
        
        showProgressItem.stringValue = @"armv7s破解文件已读取";
        
    }
    
}

- (void)browseArm64:(id)sender
{
    NSOpenPanel *openPanel4Arm64 = [NSOpenPanel openPanel];
    
    [openPanel4Arm64 setCanChooseFiles:TRUE];
    [openPanel4Arm64 setCanChooseDirectories:FALSE];
    [openPanel4Arm64 setAllowsMultipleSelection:FALSE];
    [openPanel4Arm64 setAllowsOtherFileTypes:FALSE];
    [openPanel4Arm64 setAllowedFileTypes:@[@"arm64"]];
    
    if ([openPanel4Arm64 runModal] == NSOKButton) {
    
        NSString *nameOfTheChosenOne = [[[openPanel4Arm64 URLs] objectAtIndex:0] path];
        crackedArm64FilePath = nameOfTheChosenOne;
        [arm64PathDrag setStringValue:[nameOfTheChosenOne lastPathComponent]];
    }
    
    if (arm64PathDrag.stringValue.length != 0) {
        
        showProgressItem.stringValue = @"arm64破解文件已读取";
    }
}

-(void)analyzeIpa
{
    
    NSArray *testPath = [[NSFileManager defaultManager] subpathsAtPath:currentIpaPath];
    
    
    
    for (NSString *filename in testPath) {
        
        
        if ([[filename pathExtension] isEqualToString:@"app"])
        {
            
            infoList = [[NSMutableDictionary alloc] initWithContentsOfFile:[currentIpaPath stringByAppendingPathComponent:[filename stringByAppendingPathComponent:@"Info.plist"]]];
            appName = filename;
            NSLog(@"The app Name is: %@", filename);
        }
        
    }
    
    
    ExecutableName = [NSString stringWithString:(NSString *)[infoList objectForKey:@"CFBundleExecutable"]];
    
    NSLog(@"The executable file name is: %@", ExecutableName);
    

}

- (void)getInformationAboutIpa
{
    otoolTask = [[NSTask alloc] init];
    [otoolTask setLaunchPath:@"/usr/bin/otool"];
    [otoolTask setCurrentDirectoryPath:[currentIpaPath stringByAppendingPathComponent:appName]];
    [otoolTask setArguments:[NSArray arrayWithObjects:@"-f", ExecutableName, nil]];
    
    NSPipe *pipe = [NSPipe pipe];
    [otoolTask setStandardOutput:pipe];
    
    NSFileHandle *handler = [pipe fileHandleForReading];
    
    [otoolTask launch];
    
    NSData *data = [handler readDataToEndOfFile];

    NSString *dataInString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *dataInArray   = [dataInString componentsSeparatedByString:@"\n"];
    
    if ([dataInArray count] <= 11)
    {
        numOfArmSupported = 1;
        
        [armv7sBrowseButton setHidden:YES];
        [armv7sPathDrag setHidden:YES];
        
        [arm64BrowseButton setHidden:YES];
        [arm64PathDrag setHidden:YES];
        
        statusItem.stringValue = @"需要\narmv7:\n(iPhone4/4s)\n破解文件";
        
    }else if([dataInArray count] <= 18)
    {
        numOfArmSupported = 2;
        NSArray *offsize1 = [[dataInArray objectAtIndex:7] componentsSeparatedByString:@" "];
        arcOffsize4v7     = [[offsize1 lastObject] intValue];
        NSArray *offsize2 = [[dataInArray objectAtIndex:14] componentsSeparatedByString:@" "];
        arcOffsize4v7s    = [[offsize2 lastObject] intValue];
        
        [armv7sBrowseButton setHidden:NO];
        [armv7sPathDrag setHidden:NO];
        
        [arm64BrowseButton setHidden:YES];
        [arm64PathDrag setHidden:YES];
        
        statusItem.stringValue = @"需要\narmv7:\n(iPhone4/4s)\narmv7s:\n(iPhone5/5c)\n两个破解文件";
        
    }else
    {
        numOfArmSupported = 3;
        
        [armv7sBrowseButton setHidden:NO];
        [armv7sPathDrag setHidden:NO];
        NSArray *offsize1 = [[dataInArray objectAtIndex:7] componentsSeparatedByString:@" "];
        arcOffsize4v7 = [[offsize1 lastObject] intValue];
        NSArray *offsize2 = [[dataInArray objectAtIndex:14] componentsSeparatedByString:@" "];
        arcOffsize4v7s = [[offsize2 lastObject] intValue];
        NSArray *offsize3 = [[dataInArray objectAtIndex:21] componentsSeparatedByString:@" "];
        arcOffsize464 = [[offsize3 lastObject] intValue];
        
        [arm64BrowseButton setHidden:NO];
        [arm64PathDrag setHidden:NO];
        
        statusItem.stringValue = @"需要\narmv7:\n(iPhone4/4s)\narmv7s:\n(iPhone5/5c)\narm64:\n(iPhone5s)\n三个破解文件";

    }
    
    if (numOfArmSupported == 1)
    {

    }else if (numOfArmSupported == 2)
    {
        separateTask1 = [[NSTask alloc] init];
        [separateTask1 setLaunchPath:@"/usr/bin/lipo"];
        [separateTask1 setCurrentDirectoryPath:originalWorkingPath];
        [separateTask1 setArguments:[NSArray arrayWithObjects:@"-thin", @"armv7", [[currentIpaPath stringByAppendingPathComponent:appName]stringByAppendingPathComponent:ExecutableName], @"-output", [ExecutableName stringByAppendingString:@".armv7"], nil]];
        
        [separateTask1 launch];
        [separateTask1 waitUntilExit];
        [separateTask1 terminate];
        
        separateTask2 = [[NSTask alloc] init];
        [separateTask2 setLaunchPath:@"/usr/bin/lipo"];
        [separateTask2 setCurrentDirectoryPath:originalWorkingPath];
        [separateTask2 setArguments:[NSArray arrayWithObjects:@"-thin", @"armv7s",[[currentIpaPath stringByAppendingPathComponent:appName] stringByAppendingPathComponent:ExecutableName], @"-output", [ExecutableName stringByAppendingString:@".armv7s"], nil]];
        
        [separateTask2 launch];
        [separateTask2 waitUntilExit];
        [separateTask2 terminate];
    }

}

- (void)getParameters
{
    
    if (numOfArmSupported == 1)
    {
        
    }else if (numOfArmSupported == 2)
    {
        otoolTask4Armv7 = [[NSTask alloc] init];
        [otoolTask4Armv7 setLaunchPath:@"/usr/bin/otool"];
        [otoolTask4Armv7 setCurrentDirectoryPath:originalWorkingPath];
        [otoolTask4Armv7 setArguments:[NSArray arrayWithObjects:@"-l", [ExecutableName stringByAppendingString:@".armv7"], nil]];
        
        NSPipe *pipe1 = [NSPipe pipe];
        
        [otoolTask4Armv7 setStandardOutput:pipe1];
        
        NSFileHandle *handler1 = [pipe1 fileHandleForReading];
        
        [otoolTask4Armv7 launch];
        [otoolTask4Armv7 waitUntilExit];
        [otoolTask4Armv7 terminate];
        
        NSData *data1           = [handler1 readDataToEndOfFile];
        NSString *dataInString1 = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
        NSArray *dataInArray1   = [dataInString1 componentsSeparatedByString:@"cryptoff"];
        NSArray *findArray1     = [[dataInArray1 objectAtIndex:1] componentsSeparatedByString:@"\n"];
        cryptoff4v7             = [[[[findArray1 objectAtIndex:0] componentsSeparatedByString:@" "] lastObject] intValue];
        cryptsize4v7            = [[[[findArray1 objectAtIndex:1] componentsSeparatedByString:@" "] lastObject] intValue];
        
        NSLog(@"%ld\n %ld", (long)cryptoff4v7, (long)cryptsize4v7);
        
        otoolTask4Armv7s = [[NSTask alloc] init];
        [otoolTask4Armv7s setLaunchPath:@"/usr/bin/otool"];
        [otoolTask4Armv7s setCurrentDirectoryPath:originalWorkingPath];
        [otoolTask4Armv7s setArguments:[NSArray arrayWithObjects:@"-l",[ExecutableName stringByAppendingString:@".armv7s"], nil]];
        
        NSPipe *pipe2 = [NSPipe pipe];
        
        [otoolTask4Armv7s setStandardOutput:pipe2];
        
        NSFileHandle *handler2 = [pipe2 fileHandleForReading];
        
        [otoolTask4Armv7s launch];
        [otoolTask4Armv7s waitUntilExit];
        [otoolTask4Armv7s terminate];
        
        NSData *data2           = [handler2 readDataToEndOfFile];
        NSString *dataInString2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        NSArray *dataInArray2   = [dataInString2 componentsSeparatedByString:@"cryptoff"];
        NSArray *findArray2     = [[dataInArray2 objectAtIndex:1] componentsSeparatedByString:@"\n"];
        cryptoff4v7s            = [[[[findArray2 objectAtIndex:0] componentsSeparatedByString:@" "] lastObject] integerValue];
        cryptsize4v7s           = [[[[findArray2 objectAtIndex:1] componentsSeparatedByString:@" "] lastObject] integerValue];
        
        NSLog(@"%ld\n %ld\n", (long)cryptoff4v7s, (long)cryptsize4v7s);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        [fileManager removeItemAtPath:[originalWorkingPath stringByAppendingPathComponent:[ExecutableName stringByAppendingString:@".armv7"]] error:nil];
        [fileManager removeItemAtPath:[originalWorkingPath stringByAppendingPathComponent:[ExecutableName stringByAppendingString:@".armv7s"]] error:nil];
    }
    
    entitlementTask = [[NSTask alloc] init];
    [entitlementTask setLaunchPath:@"/usr/bin/codesign"];
    
    [entitlementTask setArguments:[NSArray arrayWithObjects:@"--display", @"--entitlements", @"-", [currentIpaPath stringByAppendingPathComponent:appName], nil]];
    
    NSPipe *pipe3 = [NSPipe pipe];
    
    [entitlementTask setStandardOutput:pipe3];
    
    NSFileHandle *handler3 = [pipe3 fileHandleForReading];
    
    [entitlementTask launch];
    
    NSData *data3 = [handler3 readDataToEndOfFile];
    NSString *dataInString3 = [[NSString alloc] initWithData:data3 encoding:NSUnicodeStringEncoding];
    
    NSLog(@"%@", dataInString3);
    
    
}

- (void)tap2Merge:(id)sender
{
    if (ipaPathDrag.stringValue.length == 0) {
        
        [self showAlertOfKind:NSCriticalAlertStyle WithTitle:@"错误" AndMessage:@"没有选择ipa文件 :("];
        
        [showProgressItem setStringValue:@"请重试 :)"];
        
    }else if((armv7PathDrag.stringValue.length || armv7sPathDrag.stringValue.length || arm64PathDrag.stringValue.length) == 0)
    {
        [self showAlertOfKind:NSCriticalAlertStyle WithTitle:@"错误" AndMessage:@"没有选择任何破解文件"];
            
        [showProgressItem setStringValue:@"请重试 :)"];
    }
    
        
        [self getParameters];
        
        if (numOfArmSupported == 1 ) {
            
            NSError *err;
            
            [[NSFileManager defaultManager] removeItemAtPath:[[currentIpaPath stringByAppendingPathComponent:appName] stringByAppendingPathComponent:ExecutableName] error:&err];
            
            if (err) {
                
                NSLog(@"%@", err);
            }
            
            [[NSFileManager defaultManager] copyItemAtPath: crackedArmv7FilePath toPath:[[currentIpaPath stringByAppendingPathComponent:appName] stringByAppendingPathComponent:ExecutableName] error:nil];
            
        }
        else if (numOfArmSupported == 2)
        {
            if ((armv7sPathDrag.stringValue.length || armv7PathDrag.stringValue.length) == 0) {
                
                [self showAlertOfKind:NSCriticalAlertStyle WithTitle:@"错误" AndMessage:@"ipa需要Armv7和Armv7s两个破解文件~"];
                [showProgressItem setStringValue:@"请重试 :)"];
            }
            
            mergeTask = [[NSTask alloc] init];
            [mergeTask setLaunchPath:@"/bin/dd"];
            [mergeTask setCurrentDirectoryPath:[originalWorkingPath stringByAppendingPathComponent:@"tmp"]];
            
            NSError *err1 = nil;
            
            [[NSFileManager defaultManager] copyItemAtPath:crackedArmv7FilePath toPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".armv7"] error:&err1];
            
            if (err1) {
                NSLog(@"%@", err1);
            }
            
            NSError *err2;
            
            [[NSFileManager defaultManager] copyItemAtPath:crackedArmv7sFilePath toPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".armv7s"] error:&err2];
            
            if (err2) {
                NSLog(@"%@",err2);
            }
            
            NSString *parameter3 = [NSString stringWithFormat:@"if=%@",[ExecutableName stringByAppendingString:@".armv7"]];
            NSString *parameter4 = [NSString stringWithFormat:@"of=%@",[ExecutableName stringByAppendingString:@".armv7s"]];
            NSString *parameter6 = [NSString stringWithFormat:@"count=%ld", (arcOffsize4v7s-1)];
            
            [mergeTask setArguments:[NSArray arrayWithObjects:@"bs=1", @"conv=notrunc", parameter3, parameter4, @"skip=0", @"seek=0", parameter6, nil]];
            
            [mergeTask launch];
            [mergeTask waitUntilExit];
            [mergeTask terminate];
            
            NSError *err;
            
            [[NSFileManager defaultManager] removeItemAtPath:[[currentIpaPath stringByAppendingPathComponent:appName] stringByAppendingPathComponent:ExecutableName] error:&err];
            
            if (err) {
                
                NSLog(@"%@", err);
            }
            
            [[NSFileManager defaultManager] moveItemAtPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".armv7s"] toPath:[[currentIpaPath stringByAppendingPathComponent:appName] stringByAppendingPathComponent:ExecutableName] error:nil];
            
            [[NSFileManager defaultManager] removeItemAtPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".armv7"] error:nil];
        }
        else if (numOfArmSupported == 3)
        {
            if ((armv7sPathDrag.stringValue || armv7sPathDrag.stringValue || arm64PathDrag.stringValue) == 0) {
                
                [self showAlertOfKind:NSCriticalAlertStyle WithTitle:@"错误" AndMessage:@"ipa需要Armv7s、Armv7s以及Arm64三个破解文件~"];
                
            }
            
            mergeTask = [[NSTask alloc] init];
            [mergeTask setLaunchPath:@"/bin/dd"];
            [mergeTask setCurrentDirectoryPath:[originalWorkingPath stringByAppendingPathComponent:@"tmp"]];
            
            mergeTask2 = [[NSTask alloc] init];
            [mergeTask2 setLaunchPath:@"/bin/dd"];
            [mergeTask2 setCurrentDirectoryPath:[originalWorkingPath stringByAppendingPathComponent:@"tmp"]];
            
            NSError *err1 = nil;
            
            [[NSFileManager defaultManager] copyItemAtPath:crackedArmv7FilePath toPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".armv7"] error:&err1];
            
            if (err1) {
                NSLog(@"%@", err1);
            }
            
            NSError *err2;
            
            [[NSFileManager defaultManager] copyItemAtPath:crackedArmv7sFilePath toPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".armv7s"] error:&err2];
            
            if (err2) {
                NSLog(@"%@",err2);
            }
            
            NSError *err3;
            
            [[NSFileManager defaultManager] copyItemAtPath:crackedArm64FilePath toPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".arm64"] error:&err2];
            
            if (err3) {
                NSLog(@"%@",err3);
            }
            
            NSString *parameter3     = [NSString stringWithFormat:@"if=%@",[ExecutableName stringByAppendingString:@".armv7s"]];
            NSString *parameter3Plus = [NSString stringWithFormat:@"if=%@",[ExecutableName stringByAppendingString:@".armv7"]];
            NSString *parameter4     = [NSString stringWithFormat:@"of=%@",[ExecutableName stringByAppendingString:@".arm64"]];
            NSString *parameter6     = [NSString stringWithFormat:@"count=%ld", (arcOffsize464-1)];
            NSString *parameter6Plus = [NSString stringWithFormat:@"count=%ld", (arcOffsize4v7s-1)];
            
            [mergeTask setArguments:[NSArray arrayWithObjects:@"bs=1", @"conv=notrunc", parameter3, parameter4, @"skip=0", @"seek=0", parameter6, nil]];
            
            [mergeTask launch];
            [mergeTask waitUntilExit];
            [mergeTask terminate];
            
            [mergeTask2 setArguments:[NSArray arrayWithObjects:@"bs=1", @"conv=notrunc", parameter3Plus, parameter4, @"skip=0", @"seek=0", parameter6Plus, nil]];
            
            [mergeTask2 launch];
            [mergeTask2 waitUntilExit];
            [mergeTask2 terminate];
            
            
            
            NSError *err;
            
            [[NSFileManager defaultManager] removeItemAtPath:[[currentIpaPath stringByAppendingPathComponent:appName] stringByAppendingPathComponent:ExecutableName] error:&err];
            
            if (err) {
                
                NSLog(@"%@", err);
            }
            
            [[NSFileManager defaultManager] moveItemAtPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".arm64"] toPath:[[currentIpaPath stringByAppendingPathComponent:appName] stringByAppendingPathComponent:ExecutableName] error:nil];
            
            [[NSFileManager defaultManager] removeItemAtPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".armv7s"] error:nil];
            
            [[NSFileManager defaultManager] removeItemAtPath:[[[originalWorkingPath stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:ExecutableName] stringByAppendingString:@".armv7"] error:nil];
        }
    
        [showProgressItem setStringValue:@"已合并"];
    
}

- (void)tap2CreateIpa:(id)sender
{
    zipIpaTask = [[NSTask alloc] init];
    [zipIpaTask setLaunchPath:@"/usr/bin/zip"];
    [zipIpaTask setCurrentDirectoryPath:currentIpaPath];
    
    NSString *newIpaName = [NSString stringWithFormat:@"New_%@.ipa",ExecutableName];
    
    [zipIpaTask setArguments:[NSArray arrayWithObjects:@"-r", newIpaName, @"Payload",nil]];
    
    [zipIpaTask launch];
    
    [showProgressItem setStringValue:@"生成ipa"];
    
    [zipIpaTask waitUntilExit];
    
    [showProgressItem setStringValue:@"完成!"];
    
    NSString *filePath = currentIpaPath;
    NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
    [workspace openFile:filePath];
}


- (void)tap2Resign:(id)sender
{
    [[NSFileManager defaultManager] removeItemAtPath:[[currentIpaPath  stringByAppendingPathComponent:appName] stringByAppendingPathComponent:@"_CodeSignature"] error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:[[currentIpaPath  stringByAppendingPathComponent:appName] stringByAppendingPathComponent:@"SC_Info"] error:nil];
    [[NSFileManager defaultManager] copyItemAtPath:[originalCertPath stringByAppendingPathComponent:@"embedded.mobileprovision"] toPath:[[currentIpaPath stringByAppendingPathComponent:appName] stringByAppendingPathComponent:@"embedded.mobileprovision"] error:nil];
    [[NSFileManager defaultManager] copyItemAtPath:[originalCertPath stringByAppendingPathComponent:@"entitlements.plist"] toPath:[currentIpaPath stringByAppendingPathComponent:@"entitlements.plist"] error:nil];
    
    resignTask = [[NSTask alloc] init];
    [resignTask setLaunchPath:@"/usr/bin/codesign"];
    [resignTask setCurrentDirectoryPath:currentIpaPath];
    
    NSString *parameters1 = [NSString stringWithFormat:@"%@/ResourceRules.plist", appName];
    NSString *parameters2 = [NSString stringWithFormat:@"%@",appName];
    NSString *parametersExtra = @"entitlements.plist";
    
    
    [resignTask setArguments:[NSArray arrayWithObjects:@"-f", @"-s", @"Beijing Yirun Weiye Software technology co., LTD", @"--resource-rules", parameters1, @"--entitlements", parametersExtra, parameters2,nil]];
    
    [resignTask launch];
    [resignTask waitUntilExit];
    
    [showProgressItem setStringValue:@"已签名"];
    
}



#pragma 提示窗

- (void)showAlertOfKind:(NSAlertStyle)style WithTitle:(NSString *)title AndMessage:(NSString *)message {
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"确定"];
    [alert setMessageText:title];
    [alert setInformativeText:message];
    [alert setAlertStyle:style];
    [alert runModal];
}


@end
