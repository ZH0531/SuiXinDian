package com.zh8888.controller;

import com.zh8888.model.CartItem;
import com.zh8888.model.User;
import com.zh8888.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 购物车控制器
 */
@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    /**
     * 添加商品到购物车
     */
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addToCart(
            @RequestParam Integer menuId,
            @RequestParam(defaultValue = "1") Integer quantity,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 检查用户是否登录
            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                response.put("success", false);
                response.put("message", "请先登录");
                return ResponseEntity.ok(response);
            }

            // 添加到购物车
            boolean success = cartService.addToCart(currentUser.getId(), menuId, quantity);
            
            if (success) {
                response.put("success", true);
                response.put("message", "添加成功");
                response.put("cartCount", cartService.getCartItemCount(currentUser.getId()));
            } else {
                response.put("success", false);
                response.put("message", "添加失败");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "系统异常");
        }
        
        return ResponseEntity.ok(response);
    }

    /**
     * 更新购物车商品数量
     */
    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCartItem(
            @RequestParam Integer menuId,
            @RequestParam Integer quantity,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                response.put("success", false);
                response.put("message", "请先登录");
                return ResponseEntity.ok(response);
            }

            boolean success = cartService.updateCartItemQuantity(currentUser.getId(), menuId, quantity);
            
            if (success) {
                response.put("success", true);
                response.put("message", "更新成功");
                response.put("cartCount", cartService.getCartItemCount(currentUser.getId()));
                response.put("cartTotal", cartService.calculateCartTotal(currentUser.getId()));
            } else {
                response.put("success", false);
                response.put("message", "更新失败");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "系统异常");
        }
        
        return ResponseEntity.ok(response);
    }

    /**
     * 从购物车移除商品
     */
    @PostMapping("/remove")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeFromCart(
            @RequestParam Integer menuId,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                response.put("success", false);
                response.put("message", "请先登录");
                return ResponseEntity.ok(response);
            }

            boolean success = cartService.removeFromCart(currentUser.getId(), menuId);
            
            if (success) {
                response.put("success", true);
                response.put("message", "移除成功");
                response.put("cartCount", cartService.getCartItemCount(currentUser.getId()));
                response.put("cartTotal", cartService.calculateCartTotal(currentUser.getId()));
            } else {
                response.put("success", false);
                response.put("message", "移除失败");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "系统异常");
        }
        
        return ResponseEntity.ok(response);
    }

    /**
     * 获取购物车信息
     */
    @GetMapping("/info")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCartInfo(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                response.put("success", false);
                response.put("message", "请先登录");
                return ResponseEntity.ok(response);
            }

            List<CartItem> cartItems = cartService.getCartItems(currentUser.getId());
            BigDecimal cartTotal = cartService.calculateCartTotal(currentUser.getId());
            int cartCount = cartService.getCartItemCount(currentUser.getId());
            
            response.put("success", true);
            response.put("cartItems", cartItems);
            response.put("cartTotal", cartTotal);
            response.put("cartCount", cartCount);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "系统异常");
        }
        
        return ResponseEntity.ok(response);
    }

    /**
     * 清空购物车
     */
    @PostMapping("/clear")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> clearCart(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                response.put("success", false);
                response.put("message", "请先登录");
                return ResponseEntity.ok(response);
            }

            boolean success = cartService.clearCart(currentUser.getId());
            
            if (success) {
                response.put("success", true);
                response.put("message", "购物车已清空");
                response.put("cartCount", 0);
                response.put("cartTotal", BigDecimal.ZERO);
            } else {
                response.put("success", false);
                response.put("message", "清空失败");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "系统异常");
        }
        
        return ResponseEntity.ok(response);
    }

    /**
     * 前端同步购物车到服务器（目前仅返回成功以消除404）
     */
    @PostMapping("/sync")
    @ResponseBody
    public ResponseEntity<Map<String,Object>> syncCart(HttpSession session) {
        Map<String,Object> resp=new HashMap<>();
        resp.put("success", true);
        return ResponseEntity.ok(resp);
    }
} 