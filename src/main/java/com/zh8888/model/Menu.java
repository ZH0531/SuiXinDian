package com.zh8888.model;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 菜单实体类
 */
@Data
public class Menu {
    
    /**
     * 菜品ID
     */
    private Integer id;
    
    /**
     * 菜品编号
     */
    private String menuNo;
    
    /**
     * 菜品名称
     */
    private String name;
    
    /**
     * 价格
     */
    private BigDecimal price;
    
    /**
     * 菜品图片URL
     */
    private String imageUrl;
    
    /**
     * 菜品描述
     */
    private String description;
    
    /**
     * 标签（包含分类信息）
     */
    private String tags;
    
    /**
     * 创建时间
     */
    private Date createTime;
    
    /**
     * 检查菜品是否为热菜
     */
    public boolean isHotDish() {
        return tags != null && tags.contains("热菜");
    }
    
    /**
     * 检查菜品是否为凉菜
     */
    public boolean isColdDish() {
        return tags != null && tags.contains("凉菜");
    }
    
    /**
     * 检查菜品是否为汤类
     */
    public boolean isSoup() {
        return tags != null && tags.contains("汤类");
    }
    
    /**
     * 检查菜品是否为主食
     */
    public boolean isMainFood() {
        return tags != null && tags.contains("主食");
    }
    
    /**
     * 检查菜品是否为饮品
     */
    public boolean isDrink() {
        return tags != null && tags.contains("饮品");
    }
    
    /**
     * 检查菜品是否辣
     */
    public boolean isSpicy() {
        return tags != null && tags.contains("辣");
    }
    
    /**
     * 检查菜品是否为素食
     */
    public boolean isVegetarian() {
        return tags != null && tags.contains("素食");
    }
} 