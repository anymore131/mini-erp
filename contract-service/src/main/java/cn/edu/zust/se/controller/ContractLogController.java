package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.query.ContractLogQuery;
import cn.edu.zust.se.service.IContractLogService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author author
 * @since 2024-12-24
 */
@RestController
@RequestMapping("/contract-log")
@AllArgsConstructor
public class ContractLogController {
    private final IContractLogService contractLogService;
    @RequestMapping("/pageLogs")
    public SaResult pageLogs(@RequestBody ContractLogQuery query) {
        return SaResult.data(contractLogService.pageLogs(query));
    }
}
