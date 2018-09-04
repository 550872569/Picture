
#import "ANFileUtils.h"

@implementation ANFileUtils

+ (BOOL)pathExists:(NSString *)path isDir:(BOOL *)isDir{
    BOOL tmp;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:isDir ? isDir : &tmp];
    return isExist;
}

+ (void)createDirectoryAtPath:(NSString *)dirPath {
    BOOL isDir = YES;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir];
    if (!isExist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
+ (void)createFileAtPath:(NSString *)filePath {
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!isExist) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }}

+ (NSData *)readFileAtPath:(NSString *)filePath {
    return [NSData dataWithContentsOfFile:filePath];
}
+ (NSString *)readFileAsStringAtPath:(NSString *)filePath {
    NSData *dataResult = [self readFileAtPath:filePath readOffset:0];
    if (dataResult == nil) {
        return nil;
    }
    return [[NSString alloc]initWithData:dataResult encoding:NSUTF8StringEncoding];
}
+ (NSData *)readFileAtPath:(NSString *)filePath ofOffset:(long)readOffset {
    return [self readFileAtPath:filePath readOffset:readOffset];
}

+ (void)writeData:(NSData *)data toFileAtPath:(NSString *)filePath {
    if (data == nil) {
        data = [NSData data];
    }
    [data writeToFile:filePath atomically:YES];
}
+ (void)writeString:(NSString *)str toFileAtPath:(NSString *)filePath {
    NSData *dataWrite = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self writeData:dataWrite toFileAtPath:filePath];
}

+ (void)appendData:(NSData *)data toFileAtPath:(NSString *)filePath {
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if (fileHandle == nil) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    }
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:data];
    [fileHandle closeFile];
}
+ (void)appendString:(NSString *)str toFileAtPath:(NSString *)filePath {
    NSData *dataWrite = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self appendData:dataWrite toFileAtPath:filePath];
}

+ (NSData *)readFileAtPath:(NSString *)filePath readOffset:(long)readOffset {
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if(fileHandle == nil){
        return nil;
    }
    [fileHandle seekToFileOffset:readOffset];
    NSData *dataResult = [fileHandle readDataToEndOfFile];
    [fileHandle closeFile];
    return dataResult;
}

+ (NSData *)readFileAtPath:(NSString *)filePath ofOffset:(long)readOffset ofLength:(long)readLength{
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if(fileHandle == nil){
        return nil;
    }
    [fileHandle seekToFileOffset:readOffset];
    NSData *dataResult = [fileHandle readDataOfLength:readLength];
    [fileHandle closeFile];
    return dataResult;
}

+ (BOOL)moveSrcPath:(NSString *)srcPath toDestPath:(NSString *)destPath overWrite:(bool)overWrite{
    if(![self pathExists:srcPath isDir:0]){
        return NO;
    }
    if([self pathExists:destPath isDir:0] && !overWrite){
        return NO;
    }
    
    NSError *error = nil;
    BOOL r =  [[NSFileManager defaultManager] replaceItemAtURL:[NSURL fileURLWithPath:destPath] withItemAtURL:[NSURL fileURLWithPath:srcPath] backupItemName:nil options:NSFileManagerItemReplacementUsingNewMetadataOnly resultingItemURL:nil error:&error];
    return r;
}

+ (BOOL)deletePath:(NSString *)path{
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (void)mergeReplaceFilesFromSrcDir:(NSString *)srcDir toDestDir:(NSString *)destDir deleteSrcDir:(bool)deleteSrcDir{
    [self _recurseMergeReplaceFilesFromSrcDir:srcDir toDestDir:destDir];
    if (deleteSrcDir) {
        [self deletePath:srcDir];
    }
}

+ (void)_recurseMergeReplaceFilesFromSrcDir:(NSString *)srcDir toDestDir:(NSString *)destDir{
    if (![self pathExists:destDir isDir:0]) {
        [self moveSrcPath:srcDir toDestPath:destDir overWrite:true];
    }else{
        NSArray<NSString *> *subFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:srcDir error:nil];
        [subFiles enumerateObjectsUsingBlock:^(NSString * _Nonnull subFileName, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *srcFilePath = [srcDir stringByAppendingPathComponent:subFileName];
            NSString *destFilePath = [destDir stringByAppendingPathComponent:subFileName];
            BOOL isDir = NO;
            if([self pathExists:srcFilePath isDir:&isDir]){
                if (!isDir) {
                    [self moveSrcPath:srcFilePath toDestPath:destFilePath overWrite:true];
                }else{
                    [self _recurseMergeReplaceFilesFromSrcDir:srcFilePath toDestDir:destFilePath];
                }
            }
        }];
    }
}

+ (long)fileLengthOfPath:(NSString *)path{
    if(![self pathExists:path isDir:0]){
        return 0;
    }
    uint64_t fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
    return (long)fileSize;
}

@end
