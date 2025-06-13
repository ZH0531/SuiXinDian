package com.zh8888.model;

import lombok.Data;

import java.math.BigDecimal;

/**
 * 购物车项实体类
 */
@Data
public class CartItem {
    
    /**
     * 菜品ID
     */
    private Integer menuId;
    
    /**
     * 菜品编号
     */
    private String menuNo;
    
    /**
     * 菜品名称
     */
    private String menuName;
    
    /**
     * 菜品图片
     */
    private String menuImage;
    
    /**
     * 单价
     */
    private BigDecimal price;
    
    /**
     * 数量
     */
    private Integer quantity;
    
    /**
     * 小计金额
     */
    private BigDecimal subtotal;
    
    /**
     * 构造函数
     */
    public CartItem() {
        this.quantity = 1;
    }
    
    public CartItem(Menu menu) {
        this.menuId = menu.getId();
        this.menuNo = menu.getMenuNo();
        this.menuName = menu.getName();
        this.menuImage = menu.getImageUrl();
        this.price = menu.getPrice();
        this.quantity = 1;
        this.subtotal = menu.getPrice();
    }
    
    /**
     * 计算小计
     */
    public BigDecimal calculateSubtotal() {
        if (price != null && quantity != null) {
            subtotal = price.multiply(new BigDecimal(quantity));
            return subtotal;
        }
        return BigDecimal.ZERO;
    }
    
    /**
     * 增加数量
     */
    public void addQuantity(int amount) {
        this.quantity += amount;
        calculateSubtotal();
    }
    
    /**
     * 设置数量
     */
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
        calculateSubtotal();
    }
} 