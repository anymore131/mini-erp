package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.query.ClientRfmQuery;
import cn.edu.zust.se.service.IClientRfmService;
import org.springframework.web.bind.annotation.*;

/**
 * @author anymore131
 * @since 2024-12-26
 */
@RestController
@RequestMapping("/client-rfm")
public class ClientRfmController {
    private final IClientRfmService clientRfmService;
    public ClientRfmController(IClientRfmService clientRfmService) {
        this.clientRfmService = clientRfmService;
    }

    @PostMapping("/update")
    public SaResult updateRfm(@RequestParam(value = "userId", required = false) Integer userId) {
        clientRfmService.updateRfmByUserId(userId);
        return SaResult.ok();
    }

    @RequestMapping("/pageValue")
    public SaResult getHighValueCustomers(@RequestBody ClientRfmQuery clientRfmQuery) {
        return SaResult.data(clientRfmService.getValueCustomers(clientRfmQuery));
    }

    // 管理员获取情况
    @GetMapping("/customer-level")
    public SaResult getCustomerLevelDistribution(@RequestParam(value = "userId", required = false) Integer userId) {
        return SaResult.data(clientRfmService.getCustomerLevelDistribution(userId));
    }

    /**
     * 正常不使用
     * 初始化方法
     */
    @RequestMapping("/updateAll")
    public SaResult updateAllRfm() {
        clientRfmService.updateAllRfmScores();
        return SaResult.ok();
    }
}
