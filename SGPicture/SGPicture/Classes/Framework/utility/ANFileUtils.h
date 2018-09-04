
#import <Foundation/Foundation.h>

@interface ANFileUtils : NSObject

+ (BOOL)pathExists:(NSString *)path isDir:(BOOL *)isDir;

+ (void)createDirectoryAtPath:(NSString *)dirPath;
+ (void)createFileAtPath:(NSString *)filePath;

+ (NSData *)readFileAtPath:(NSString *)filePath;
+ (NSString *)readFileAsStringAtPath:(NSString *)filePath;
+ (NSData *)readFileAtPath:(NSString *)filePath ofOffset:(long)readOffset;
+ (NSData *)readFileAtPath:(NSString *)filePath ofOffset:(long)readOffset ofLength:(long)readLength;

+ (void)writeData:(NSData *)data toFileAtPath:(NSString *)filePath;
+ (void)writeString:(NSString *)str toFileAtPath:(NSString *)filePath;

+ (void)appendData:(NSData *)data toFileAtPath:(NSString *)filePath;
+ (void)appendString:(NSString *)str toFileAtPath:(NSString *)filePath;

+ (BOOL)moveSrcPath:(NSString *)srcPath toDestPath:(NSString *)destPath overWrite:(bool)overWrite;
+ (BOOL)deletePath:(NSString *)path;
+ (void)mergeReplaceFilesFromSrcDir:(NSString *)srcDir toDestDir:(NSString *)destDir deleteSrcDir:(bool)deleteSrcDir;

+ (long)fileLengthOfPath:(NSString *)path;

@end
