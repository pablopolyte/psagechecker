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
            if (current($category) === $rootCategory || current($category) === $homeCategory) { continue; };

            foreach ($category as $cat) {
                $cleanedCategories[] = array(
                    'id' => $cat['infos']['id_category'],
                    'id_parent' => $cat['infos']['id_parent'],
                    'name' => $cat['infos']['name'],
                );
            }
        }

        $this->ajaxDie(json_encode($cleanedCategories));
    }

    /**
     * ajaxProcessGetPaginatedProducts
     *
     * @param int $offset
     * @return string
     */
    public function ajaxProcessGetPaginatedProducts($offset = 0)
    {
        $currentIdLang = $this->context->language->id;
        $allProducts=Product::getProducts($currentIdLang, $offset, '50', 'id_product','DESC');
        $paginatedProducts = array();

        foreach ($allProducts as $product) {
            dump($product);
            // $isHomeOrRootCategories = array_key_exists('1', $category) || array_key_exists('2', $category);
            // if ($isHomeOrRootCategories) { continue; };

            // foreach ($category as $cat) {
            //     $trimmedCategories[] = array(
            //         'id' => $cat['infos']['id_category'],
            //         'id_parent' => $cat['infos']['id_parent'],
            //         'name' => $cat['infos']['name'],
            //     );
            // }
        }

        $this->ajaxDie(json_encode($paginatedProducts));
    }
}
