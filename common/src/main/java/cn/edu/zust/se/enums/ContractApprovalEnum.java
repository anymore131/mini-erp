package cn.edu.zust.se.enums;

import lombok.Getter;

@Getter
public enum ContractApprovalEnum {
    START(0, "已添加"),
    PASS(1, "审批通过"),
    REJECT(2, "不通过");

    private final Integer code;
    private final String message;
    ContractApprovalEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
    // 根据整数值获取枚举实例
    public static String fromCode(int code) {
        for (ContractApprovalEnum status : ContractApprovalEnum.values()) {
            if (status.getCode() == code) {
                return status.toString();
            }
        }
        throw new IllegalArgumentException("ContractApprovalEnum unknown code: " + code);
    }

    // 根据字符串值获取枚举实例
    public static Integer fromMessage(String message) {
        for (ContractApprovalEnum status : ContractApprovalEnum.values()) {
            if (status.getMessage().equalsIgnoreCase(message)) {
                return status.code;
            }
        }
        throw new IllegalArgumentException("ContractStatusEnum unknown message: " + message);
    }
}
