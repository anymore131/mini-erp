package cn.edu.zust.se.controller;


import cn.dev33.satoken.util.SaResult;
import cn.edu.zust.se.entity.query.OrderLogQuery;
import cn.edu.zust.se.service.IContractFileService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author author
 * @since 2024-12-25
 */
@RestController
@RequestMapping("/contract-file")
@AllArgsConstructor
public class ContractFileController {
    private final IContractFileService contractFileService;
    @PostMapping("/add/{id}")
    public SaResult addOrderFile(@PathVariable("id") Integer contractId
            ,@RequestParam("remark") String remark
            ,@RequestParam("file") MultipartFile file) {
        return contractFileService.addContractFile(contractId, remark, file);
    }

    @GetMapping("/list/{id}")
    public SaResult listOrderFile(@PathVariable("id") Integer contractId) {
        return contractFileService.getContractFile(contractId);
    }

    @DeleteMapping("/remove/{id}")
    public SaResult removeOrderFile(@PathVariable("id") Integer id) {
        if (!contractFileService.removeContractFile(id)) {
            return SaResult.error("删除失败！");
        }
        return SaResult.ok("删除成功！");
    }

}
