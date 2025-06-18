package com.zh8888.service;

import com.zh8888.model.Menu;
import java.util.List;
import java.util.Map;

/**
 * 菜单服务接口
 */
public interface MenuService {
    
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
     * 根据分类获取菜品列表
     * @param category 分类名称（热菜、凉菜、汤类、主食、饮品）
     * @return 菜品列表
     */
    List<Menu> getMenusByCategory(String category);
    
    /**
     * 获取按分类分组的菜品
     * @return 分类菜品Map，key为分类名称，value为菜品列表
     */
    Map<String, List<Menu>> getMenusByCategories();
    
    /**
     * 根据菜品名称搜索菜品
     * @param name 菜品名称关键字
     * @return 菜品列表
     */
    List<Menu> searchMenusByName(String name);
    
    /**
     * 根据标签搜索菜品
     * @param tag 标签关键字
     * @return 菜品列表
     */
    List<Menu> searchMenusByTag(String tag);
    
    /**
     * 获取推荐菜品（辣菜、经典菜等）
     * @return 推荐菜品列表
     */
    List<Menu> getRecommendedMenus();
    
    /**
     * 获取素食菜品
     * @return 素食菜品列表
     */
    List<Menu> getVegetarianMenus();
    
    /**
     * 添加新菜品
     * @param menu 菜品对象
     * @return 添加成功返回true，失败返回false
     */
    boolean addMenu(Menu menu);
    
    /**
     * 更新菜品信息
     * @param menu 菜品对象
     * @return 更新成功返回true，失败返回false
     */
    boolean updateMenu(Menu menu);
    
    /**
     * 删除菜品
     * @param id 菜品ID
     * @return 删除成功返回true，失败返回false
     */
    boolean deleteMenu(Integer id);
    
    /**
     * 检查菜品编号是否已存在
     * @param menuNo 菜品编号
     * @return 存在返回true，不存在返回false
     */
    boolean isMenuNoExist(String menuNo);
    
    /**
     * 获取指定前缀的下一个编号
     * @param prefix 编号前缀
     * @return 下一个编号
     */
    int getNextMenuNumber(String prefix);
    
    /**
     * 获取菜品总数
     * @return 菜品总数
     */
    int getMenuCount();
} 