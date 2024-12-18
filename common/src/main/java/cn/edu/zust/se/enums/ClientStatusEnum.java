package cn.edu.zust.se.enums;

import lombok.Getter;

@Getter
public enum ClientStatusEnum {
    START(0, "已添加"),
    COOPERATION(1, "正在合作"),
    WAITING(2, "未开展合作");

    private final Integer code;
    private final String message;

    ClientStatusEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    // 根据整数值获取枚举实例
    public static String fromCode(int code) {
        for (ClientStatusEnum status : ClientStatusEnum.values()) {
            if (status.getCode() == code) {
                return status.toString();
            }
        }
        throw new IllegalArgumentException("ClientStatusEnum unknown code: " + code);
    }

    // 根据字符串值获取枚举实例
    public static Integer fromMessage(String message) {
        for (ClientStatusEnum status : ClientStatusEnum.values()) {
            if (status.getMessage().equalsIgnoreCase(message)) {
                return status.code;
            }
        }
        throw new IllegalArgumentException("ClientStatusEnum unknown message: " + message);
    }
}