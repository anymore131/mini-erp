package cn.edu.zust.se.controller;


import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author anymore131
 * @since 2024-11-16
 */
@RestController
@RequestMapping("/users")
public class UsersController {

    @RequestMapping("/test")
    public String test(){
        return "test";
    }
}
