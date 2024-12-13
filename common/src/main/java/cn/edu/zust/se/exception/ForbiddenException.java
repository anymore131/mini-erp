package cn.edu.zust.se.exception;

/**
 * 没有权限访问特定资源时，抛出此异常
 */
public class ForbiddenException extends RuntimeException {
    public ForbiddenException(String message) {
        super(message);
    }
}
