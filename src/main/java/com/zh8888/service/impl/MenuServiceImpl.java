package com.zh8888.service.impl;

import com.zh8888.dao.MenuDao;
import com.zh8888.model.Menu;
import com.zh8888.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 菜单服务实现类
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuDao menuDao;

    @Override
    public List<Menu> getAllMenus() {
        return menuDao.getAllMenus();
    }

    @Override
    public Menu getMenuById(Integer id) {
        return menuDao.getMenuById(id);
    }

    @Override
    public Menu getMenuByNo(String menuNo) {
        return menuDao.getMenuByNo(menuNo);
    }

    @Override
    public List<Menu> getMenusByCategory(String category) {
        switch (category) {
            case "热菜":
                return menuDao.getHotDishes();
            case "凉菜":
                return menuDao.getColdDishes();
            case "汤类":
                return menuDao.getSoups();
            case "主食":
                return menuDao.getMainFoods();
            case "饮品":
                return menuDao.getDrinks();
            default:
                return menuDao.getMenusByTag(category);
        }
    }

    @Override
    public Map<String, List<Menu>> getMenusByCategories() {
        Map<String, List<Menu>> categorizedMenus = new LinkedHashMap<>();
        
        // 按固定顺序添加分类
        categorizedMenus.put("热菜", menuDao.getHotDishes());
        categorizedMenus.put("凉菜", menuDao.getColdDishes());
        categorizedMenus.put("汤类", menuDao.getSoups());
        categorizedMenus.put("主食", menuDao.getMainFoods());
        categorizedMenus.put("饮品", menuDao.getDrinks());
        
        return categorizedMenus;
    }

    @Override
    public List<Menu> searchMenusByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return new ArrayList<>();
        }
        return menuDao.searchMenusByName(name.trim());
    }

    @Override
    public List<Menu> searchMenusByTag(String tag) {
        if (tag == null || tag.trim().isEmpty()) {
            return new ArrayList<>();
        }
        return menuDao.getMenusByTag(tag.trim());
    }

    @Override
    public List<Menu> getRecommendedMenus() {
        // 获取经典菜品和辣菜作为推荐
        List<Menu> recommended = new ArrayList<>();
        
        List<Menu> classicMenus = menuDao.getMenusByTag("经典");
        if (classicMenus != null) {
            recommended.addAll(classicMenus);
        }
        
        List<Menu> spicyMenus = menuDao.getMenusByTag("辣");
        if (spicyMenus != null && spicyMenus.size() > 0) {
            // 避免重复，只添加不在经典菜品中的辣菜
            for (Menu spicy : spicyMenus) {
                boolean exists = recommended.stream()
                    .anyMatch(menu -> menu.getId().equals(spicy.getId()));
                if (!exists) {
                    recommended.add(spicy);
                }
            }
        }
        
        // 限制推荐菜品数量，最多8个
        if (recommended.size() > 8) {
            return recommended.subList(0, 8);
        }
        
        return recommended;
    }

    @Override
    public List<Menu> getVegetarianMenus() {
        return menuDao.getMenusByTag("素食");
    }

    @Override
    @Transactional
    public boolean addMenu(Menu menu) {
        if (menu == null || menu.getName() == null || menu.getPrice() == null) {
            return false;
        }
        
        // 检查菜品编号是否已存在
        if (menu.getMenuNo() != null && isMenuNoExist(menu.getMenuNo())) {
            return false;
        }
        
        return menuDao.insertMenu(menu) > 0;
    }

    @Override
    @Transactional
    public boolean updateMenu(Menu menu) {
        if (menu == null || menu.getId() == null) {
            return false;
        }
        
        // 检查菜品是否存在
        Menu existingMenu = menuDao.getMenuById(menu.getId());
        if (existingMenu == null) {
            return false;
        }
        
        // 如果更新菜品编号，检查新编号是否已被其他菜品使用
        if (menu.getMenuNo() != null && !menu.getMenuNo().equals(existingMenu.getMenuNo())) {
            if (isMenuNoExist(menu.getMenuNo())) {
                return false;
            }
        }
        
        return menuDao.updateMenu(menu) > 0;
    }

    @Override
    @Transactional
    public boolean deleteMenu(Integer id) {
        if (id == null) {
            return false;
        }
        
        // 检查菜品是否存在
        Menu existingMenu = menuDao.getMenuById(id);
        if (existingMenu == null) {
            return false;
        }
        
        return menuDao.deleteMenu(id) > 0;
    }

    @Override
    public boolean isMenuNoExist(String menuNo) {
        if (menuNo == null || menuNo.trim().isEmpty()) {
            return false;
        }
        return menuDao.getMenuByNo(menuNo.trim()) != null;
    }

    @Override
    public int getNextMenuNumber(String prefix) {
        String lastMenuNo = menuDao.getLastMenuNoByPrefix(prefix);
        if (lastMenuNo == null) {
            return 1; // 如果没有找到任何菜品，从1开始
        }
        
        try {
            // 提取编号部分（去掉前缀）
            String numberPart = lastMenuNo.substring(prefix.length());
            int lastNumber = Integer.parseInt(numberPart);
            return lastNumber + 1;
        } catch (Exception e) {
            return 1; // 解析失败时从1开始
        }
    }
} 