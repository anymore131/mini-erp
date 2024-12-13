package cn.edu.zust.se.exception;

/**
 * 输入数据不符合预期或格式不正确时，抛出此异常
 */
public class InvalidInputException extends RuntimeException {
    public InvalidInputException(String message) {
        super(message);
    }
}
