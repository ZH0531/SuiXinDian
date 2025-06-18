package com.zh8888.dao;

import com.zh8888.model.Menu;
import java.util.List;

/**
 * 菜单数据访问接口
 */
public interface MenuDao {
    
    /**
     * 获取所有菜品
     * @return 菜品列表
     */
    List<Menu> getAllMenus();
    
    /**
     * 根据ID查询菜品
     * @param id 菜品ID
     * @return 菜品对象
     */
    Menu getMenuById(Integer id);
    
    /**
     * 根据菜品编号查询菜品
     * @param menuNo 菜品编号
     * @return 菜品对象
     */
    Menu getMenuByNo(String menuNo);
    
    /**
     * 根据标签搜索菜品（包含分类）
     * @param tag 标签关键字
     * @return 菜品列表
     */
    List<Menu> getMenusByTag(String tag);
    
    /**
     * 根据菜品名称模糊搜索
     * @param name 菜品名称关键字
     * @return 菜品列表
     */
    List<Menu> searchMenusByName(String name);
    
    /**
     * 获取热菜列表
     * @return 热菜列表
     */
    List<Menu> getHotDishes();
    
    /**
     * 获取凉菜列表
     * @return 凉菜列表
     */
    List<Menu> getColdDishes();
    
    /**
     * 获取汤类列表
     * @return 汤类列表
     */
    List<Menu> getSoups();
    
    /**
     * 获取主食列表
     * @return 主食列表
     */
    List<Menu> getMainFoods();
    
    /**
     * 获取饮品列表
     * @return 饮品列表
     */
    List<Menu> getDrinks();
    
    /**
     * 添加新菜品
     * @param menu 菜品对象
     * @return 受影响的行数
     */
    int insertMenu(Menu menu);
    
    /**
     * 更新菜品信息
     * @param menu 菜品对象
     * @return 受影响的行数
     */
    int updateMenu(Menu menu);
    
    /**
     * 删除菜品
     * @param id 菜品ID
     * @return 受影响的行数
     */
    int deleteMenu(Integer id);
    
    /**
     * 根据前缀获取最后一个菜品编号
     * @param prefix 编号前缀
     * @return 最后一个菜品编号
     */
    String getLastMenuNoByPrefix(String prefix);
} 