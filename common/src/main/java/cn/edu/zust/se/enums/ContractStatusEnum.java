package cn.edu.zust.se.enums;

import lombok.Getter;

@Getter
public enum ContractStatusEnum {
    START(0, "已添加"),
    PASS(1, "审批通过"),
    PROGRESS(2, "进行中"),
    END(3,"已结束");

    private final Integer code;
    private final String message;
    ContractStatusEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
    // 根据整数值获取枚举实例
    public static String fromCode(int code) {
        for (ContractStatusEnum status : ContractStatusEnum.values()) {
            if (status.getCode() == code) {
                return status.toString();
            }
        }
        throw new IllegalArgumentException("ContractStatusEnum unknown code: " + code);
    }

    // 根据字符串值获取枚举实例
    public static Integer fromMessage(String message) {
        for (ContractStatusEnum status : ContractStatusEnum.values()) {
            if (status.getMessage().equalsIgnoreCase(message)) {
                return status.code;
            }
        }
        throw new IllegalArgumentException("ContractStatusEnum unknown message: " + message);
    }
}
