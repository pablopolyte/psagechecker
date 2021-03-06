<?php
/**
 * 2007-2020 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */
if (!defined('_PS_VERSION_')) {
    exit;
}
/**
 * This function updates your module from previous versions to the version 1.1,
 * usefull when you modify your database, or register a new hook ...
 * Don't forget to create one file per version.
 */
function upgrade_module_1_1_0($module)
{
    $now = new \DateTime('now');
    \Configuration::updateValue('PS_AGE_CHECKER_DATE_INSTALL', $now->format('Y-m-d H:i:s'));
    \Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_EVERYWHERE', 'true');
    \Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_EVERYWHERE', 'true');
    \Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_CATEGORIES', '');
    \Configuration::updateValue('PS_AGE_CHECKER_POPUP_DISPLAY_PRODUCTS', '');

    return true;
}
