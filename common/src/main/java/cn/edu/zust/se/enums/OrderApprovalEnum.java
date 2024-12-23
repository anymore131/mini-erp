package cn.edu.zust.se.enums;

import lombok.Getter;

@Getter
public enum OrderApprovalEnum {
    START(0, "未操作"),
    PASS(1, "批准"),
    REJECT(2, "需修改");

    private final Integer code;
    private final String message;
    OrderApprovalEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
    // 根据整数值获取枚举实例
    public static String fromCode(int code) {
        for (OrderApprovalEnum status : OrderApprovalEnum.values()) {
            if (status.getCode() == code) {
                return status.toString();
            }
        }
        throw new IllegalArgumentException("OrderApprovalEnum unknown code: " + code);
    }

    // 根据字符串值获取枚举实例
    public static Integer fromMessage(String message) {
        for (OrderApprovalEnum status : OrderApprovalEnum.values()) {
            if (status.getMessage().equalsIgnoreCase(message)) {
                return status.code;
            }
        }
        throw new IllegalArgumentException("OrderApprovalEnum unknown message: " + message);
    }
}
