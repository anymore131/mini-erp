package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.query.ClientRfmQuery;
import cn.edu.zust.se.service.IClientRfmService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * @author anymore131
 * @since 2024-12-26
 */
@RestController
@RequestMapping("/client-rfm")
@RequiredArgsConstructor
public class ClientRfmController {
    private final IClientRfmService clientRfmService;

    @RequestMapping("/pageValue")
    public SaResult getHighValueCustomers(@RequestBody ClientRfmQuery clientRfmQuery) {
        return SaResult.data(clientRfmService.getValueCustomers(clientRfmQuery));
    }

    @GetMapping("/{userId}")
    public SaResult getByUserId(@PathVariable("userId") Integer userId) {
        return SaResult.data(clientRfmService.getByUserId(userId));
    }

    @GetMapping("/all")
    public SaResult getAll() {
        return SaResult.data(clientRfmService.getAll());
    }

    @GetMapping("/update")
    public void updateManual() {
        clientRfmService.updateManual();
    }
}
