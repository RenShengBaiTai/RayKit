//
//  RSATool.m
//  contract
//
//  Created by admin on 2020/5/15.
//  Copyright © 2020 hjdj. All rights reserved.
//

#import "RayRSATool.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <Security/Security.h>

@implementation RayRSATool

+ (NSData *)getHashBytes:(NSData *)plainText {
    CC_SHA256_CTX ctx;
    uint8_t * hashBytes = NULL;
    NSData * hash = nil;
    
    // Malloc a buffer to hold hash.
    hashBytes = malloc( CC_SHA256_DIGEST_LENGTH * sizeof(uint8_t) );
    memset((void *)hashBytes, 0x0, CC_SHA256_DIGEST_LENGTH);
    // Initialize the context.
    CC_SHA256_Init(&ctx);
    // Perform the hash.
    CC_SHA256_Update(&ctx, (void *)[plainText bytes], (CC_LONG)[plainText length]);
    // Finalize the output.
    CC_SHA256_Final(hashBytes, &ctx);
    
    // Build up the SHA1 blob.
    hash = [NSData dataWithBytes:(const void *)hashBytes length:CC_SHA256_DIGEST_LENGTH];
    if (hashBytes) free(hashBytes);
    
    return hash;
}

+ (NSString *)signTheDataBySHA256WithRSA:(NSString *)plainText{
    
    uint8_t* signedBytes = NULL;
    size_t signedBytesSize = 0;
    OSStatus sanityCheck = noErr;
    NSData* signedHash = nil;
    
    // 按路径读取证书内容
    NSString * path = [[NSBundle mainBundle]pathForResource:@"private" ofType:@"p12"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    // 证书的密码
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    [options setObject:@"123456" forKey:(id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((CFDataRef) data, (CFDictionaryRef)options, &items);
    if (securityError!=noErr) {
        return nil ;
    }
    CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
    SecIdentityRef identityApp =(SecIdentityRef)CFDictionaryGetValue(identityDict,kSecImportItemIdentity);
    SecKeyRef privateKeyRef=nil;
    SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
    signedBytesSize = SecKeyGetBlockSize(privateKeyRef);
    
    signedBytes = malloc( signedBytesSize * sizeof(uint8_t) );
    memset((void *)signedBytes, 0x0, signedBytesSize);
    
    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    sanityCheck = SecKeyRawSign(privateKeyRef,
                                kSecPaddingPKCS1SHA256,
                                (const uint8_t *)[[self getHashBytes:plainTextBytes] bytes],
                                CC_SHA256_DIGEST_LENGTH,
                                (uint8_t *)signedBytes,
                                &signedBytesSize);
    
    if (sanityCheck == noErr)
    {
        signedHash = [NSData dataWithBytes:(const void *)signedBytes length:(NSUInteger)signedBytesSize];
    }
    else
    {
        return nil;
    }
    
    if (signedBytes)
    {
        free(signedBytes);
    }
    NSString *signatureResult = [[NSString alloc]initWithData:[signedHash base64EncodedDataWithOptions:0] encoding:NSUTF8StringEncoding];
    
    return signatureResult;
}


// 验签

+ (BOOL)VerifyBytesSHA256withRSA:(NSData *)plainData cer:(NSData *)signature{
    if (!plainData || !signature) {
        return NO;
    }
    SecKeyRef publicKey = [self getPublicKey];
    
    size_t signedHashBytesSize = SecKeyGetBlockSize(publicKey);
    const uint8_t * signedHashBytes = [signature bytes];
    size_t hashBytesSize = CC_SHA256_DIGEST_LENGTH;
    uint8_t * hashBytes = malloc(hashBytesSize);
    if (!CC_SHA256([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
        return NO;
    }
    OSStatus status = SecKeyRawVerify(publicKey,
                                      kSecPaddingPKCS1SHA256,
                                      hashBytes,
                                      hashBytesSize,
                                      signedHashBytes,
                                      signedHashBytesSize);
    return status == errSecSuccess;
}


+ (SecKeyRef)getPublicKey {

    NSString * path = [[NSBundle mainBundle]pathForResource:@"Your Public Certificate" ofType:@"cer"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    SecCertificateRef myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)data);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    CFErrorRef trustError = NULL;
    if (status == noErr) {
        
        if (@available(iOS 12.0, *)) {
            status = SecTrustEvaluateWithError(myTrust, &trustError);
        } else {
            // Fallback on earlier versions
        }
        if(trustError){
            NSLog(@"%@",trustError);
        }
    }
    SecKeyRef securityKey = SecTrustCopyPublicKey(myTrust);
    CFRelease(myCertificate);
    CFRelease(myPolicy);
    CFRelease(myTrust);
    return securityKey;
}

@end
