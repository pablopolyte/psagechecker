<?php
/**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author    PrestaShop SA <contact@prestashop.com>
 *  @copyright 2007-2018 PrestaShop SA
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

class AdminAjaxPsAgeCheckerController extends ModuleAdminController
{
    /**
     * ajaxProcessGetCategories
     * Return all categories of the shop
     *
     * @return string
     */
    public function ajaxProcessGetCategories()
    {
        $currentIdLang = $this->context->language->id;
        $categories = CategoryCore::getCategories($currentIdLang);
        $cleanedCategories = array();

        $rootCategory = Configuration::get('PS_ROOT_CATEGORY');
        $homeCategory = Configuration::get('PS_HOME_CATEGORY');

        foreach ($categories as $category) {
            if (current($category)['infos']['id_category'] === $rootCategory
                || current($category)['infos']['id_category'] === $homeCategory
            ) { continue; };

            foreach ($category as $cat) {
                $cleanedCategories[$cat['infos']['id_parent']][] = array(
                    'id' => $cat['infos']['id_category'],
                    'id_parent' => $cat['infos']['id_parent'],
                    'name' => $cat['infos']['name'],
                );
            }
        }

        $this->ajaxDie(json_encode($cleanedCategories));
    }

    /**
     * ajaxProcessGetProductsByNameLike
     * Return all products with the term in the name or reference
     *
     * @return string
     */
    public function ajaxProcessGetProductsByNameLike()
    {
        $currentIdLang = $this->context->language->id;
        $searchTerm = Tools::getValue('searchTerm');
        $results = Product::searchByName($currentIdLang, $searchTerm);

        $this->ajaxDie(json_encode($results));
    }

    /**
     * ajaxProcessSelectedAllShop
     *
     * @return string
     */
    public function ajaxProcessSelectedAllShop()
    {
        Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_CATEGORIES', '');
        Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_PRODUCTS', '');
        $result = Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_EVERYWHERE', 'true');
        $this->ajaxDie(json_encode((bool)$result));
    }

    /**
     * ajaxProcessUnselectedAllShop
     *
     * @return string
     */
    public function ajaxProcessUnselectedAllShop()
    {
        $result = Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_EVERYWHERE', 'false');
        $this->ajaxDie(json_encode((bool)$result));
    }

    /**
     * ajaxProcessAddProduct
     *
     * @return string
     */
    public function ajaxProcessAddProduct()
    {
        $response = true;
        $productId = Tools::getValue('productId');
        $products = Configuration::get('PS_AGE_CHECKER_POPUP_DISPLAY_PRODUCTS');
        $arrayCurrentProducts = explode(',', $products);

        $isAlreadyPresent = array_search($productId, $arrayCurrentProducts);

        if ($isAlreadyPresent == false || empty($isAlreadyPresent)) {
            $products = "$products,$productId";
            $response = Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_PRODUCTS', $products);
        };

        $this->ajaxDie(json_encode($response));
    }

    /**
     * ajaxProcessRemoveProduct
     *
     * @return string
     */
    public function ajaxProcessRemoveProduct()
    {
        $response = true;
        $productId = Tools::getValue('productId');
        $products = Configuration::get('PS_AGE_CHECKER_POPUP_DISPLAY_PRODUCTS');
        $arrayCurrentProducts = explode(',', $products);

        $key = array_search($productId, $arrayCurrentProducts);
        if ($key != false) { unset($arrayCurrentProducts[$key]); }

        $products = array_filter($arrayCurrentProducts, 'strlen');
        $products = implode(',', $products);
        $response = Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_PRODUCTS', $products);

        $this->ajaxDie(json_encode((bool)$response));
    }

    /**
     * ajaxProcessRemoveAllProducts
     *
     * @return string
     */
    public function ajaxProcessRemoveAllProducts()
    {
        $response = Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_PRODUCTS', '');
        $this->ajaxDie(json_encode((bool)$response));
    }

    /**
     * ajaxProcessRemoveAllCategories
     *
     * @return string
     */
    public function ajaxProcessRemoveAllCategories()
    {
        $response = Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_CATEGORIES', '');
        $this->ajaxDie(json_encode((bool)$response));
    }

    /**
     * ajaxProcessAddCategory
     *
     * @return string
     */
    public function ajaxProcessAddCategory()
    {
        $response = true;
        $categoryId = Tools::getValue('categoryId');
        $categories = Configuration::get('PS_AGE_CHECKER_POPUP_DISPLAY_CATEGORIES');
        $arrayCurrentCategories = explode(',', $categories);
        $isAlreadyPresent = array_search($categoryId, $arrayCurrentCategories);
        if ($isAlreadyPresent == false || empty($isAlreadyPresent)) {
            $categories = "$categories,$categoryId";
            $response = Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_CATEGORIES', $categories);
        };

        $this->ajaxDie(json_encode((bool)$response));
    }

    /**
     * ajaxProcessRemoveCategory
     *
     * @return string
     */
    public function ajaxProcessRemoveCategory()
    {
        $response = true;
        $categoryId = Tools::getValue('categoryId');
        $categories = Configuration::get('PS_AGE_CHECKER_POPUP_DISPLAY_CATEGORIES');
        $arrayCurrentCategories = explode(',', $categories);

        $key = array_search($categoryId, $arrayCurrentCategories);
        if ($key != false) { unset($arrayCurrentCategories[$key]); }
        $categories = array_filter($arrayCurrentCategories, 'strlen');
        $categories = implode(',', $arrayCurrentCategories);
        $result = Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_CATEGORIES', $categories);

        $this->ajaxDie(json_encode((bool)$result));
    }
}
