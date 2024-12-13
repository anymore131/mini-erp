package cn.edu.zust.se.exception;

/**
 * 访问需要身份验证的资源，但未提供有效凭证时，抛出此异常
 */
public class UnauthorizedException extends RuntimeException {
    public UnauthorizedException(String message) {
        super(message);
    }
}
