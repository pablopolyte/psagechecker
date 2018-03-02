<?php
/**
* 2007-2017 PrestaShop
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
*  @copyright 2007-2017 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class Psagechecker extends Module
{

    private $settings_conf = array(
        'show_album'                  => 'PS_INSTA_SHOW_ALBUM',
        'album_custom_title'          => 'PS_INSTA_CUSTOM_TITLE',
        'album_custom_title_color'    => 'PS_INSTA_TITLE_TEXT_COLOR',
        'album_custom_title_size'     => 'PS_INSTA_TITLE_TEXT_SIZE',
        'album_custom_desc'           => 'PS_INSTA_ALBUM_CUSTOM_DESC',
        'on_homepage'                 => 'PS_INSTA_ON_HOMEPAGE',
        'number_columns'              => 'PS_INSTA_NUMBER_COLUMNS',
        'number_rows'                 => 'PS_INSTA_NUMBER_ROWS',
        'on_product_page'             => 'PS_INSTA_ON_PRODUCT_PAGE',
        'number_columns_product_page' => 'PS_INSTA_COLUMNS_PRODUCT',
        'number_rows_product_page'    => 'PS_INSTA_ROWS_PRODUCT',
        'separated_cms'               => 'PS_INSTA_SEPARATED_CMS',
        'cms'                         => 'PS_INSTA_CMS',
        'max_product_sheets'          => 'PS_INSTA_MAXIMUM_PRODUCT_SHEETS',
        'show_custom_title'           => 'PS_INSTA_SHOW_CUSTOM_TITLE_BIS',
        'custom_title'                => 'PS_INSTA_CUSTOM_TITLE_BIS',
        'custom_title_color'          => 'PS_INSTA_CUSTOM_TITLE_COLOR_BIS',
    );

    public function __construct()
    {
        // Settings
        $this->name = 'psagechecker';
        $this->tab = 'social_networks';
        $this->version = '1.0.0';
        $this->author = 'PrestaShop';
        $this->need_instance = 0;

        $this->module_key = '';

        $this->controller_name = 'AdminAjaxpsagechecker';

        // bootstrap -> always set to true
        $this->bootstrap = true;

        parent::__construct();

        $this->output = '';

        $this->displayName = $this->l('Psagechecker - Check customer age');
        $this->description = $this->l('This module allows you to ...');
        $this->ps_version = (bool)version_compare(_PS_VERSION_, '1.7', '>=');

        // Settings paths
        $this->js_path = $this->_path.'views/js/';
        $this->css_path = $this->_path.'views/css/';
        $this->img_path = $this->_path.'views/img/';
        $this->docs_path = $this->_path.'docs/';
        $this->logo_path = $this->_path.'logo.png';
        $this->module_path = $this->_path;

        // Confirm uninstall
        $this->confirmUninstall = $this->l('Are you sure you want to uninstall this module?');
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
    }

    /**
     * install()
     *
     * @param none
     * @return bool
     */
    public function install()
    {
        // some stuff
        Configuration::updateValue('PS_AGECHECKER_STATUS', 'no');
        Configuration::updateValue('PS_AGECHECKER_AGE', '');
        Configuration::updateValue('PS_AGECHECKER_MEthod', '0');

        $values = array();
        $languages = Language::getLanguages(false);
        foreach ($languages as $lang) {
            $values['PS_INSTA_CUSTOM_TILTE'][$lang['id_lang']] = '#prestashop';
            $values['PS_INSTA_ALBUM_CUSTOM_DESC'][$lang['id_lang']] = '';
            $values['PS_INSTA_CUSTOM_TITLE_BIS'][$lang['id_lang']] = 'Shop this style';
        }
        Configuration::updateValue('PS_INSTA_CUSTOM_TILTE', $values['PS_INSTA_CUSTOM_TILTE']);
        Configuration::updateValue('PS_INSTA_ALBUM_CUSTOM_DESC', $values['PS_INSTA_ALBUM_CUSTOM_DESC']);
        Configuration::updateValue('PS_INSTA_CUSTOM_TITLE_BIS', $values['PS_INSTA_CUSTOM_TITLE_BIS']);

        include(dirname(__FILE__).'/sql/install.php'); // sql querries

        // register hook used by the module
        if (parent::install() &&
            $this->installTab() &&
            $this->registerHook('displayHome') &&
            $this->registerHook('displayFooterProduct')) {
            if (version_compare(_PS_VERSION_, '1.7', '>=')) {
                $this->registerHook('actionFrontControllerSetMedia');
                $this->registerHook('displayCMSDisputeInformation');
            } else {
                $this->registerHook('header');
            }
            return true;
        } else { // if something wrong return false
            $this->_errors[] = $this->l('There was an error during the uninstallation. Please contact us through Addons website.');
            return false;
        }
    }

    /**
     * uninstall()
     *
     * @param none
     * @return bool
     */
    public function uninstall()
    {
        foreach ($this->settings_conf as $value) {
            Configuration::deleteByName($value);
        }

        foreach ($this->settings_account as $value) {
            Configuration::deleteByName($value);
        }

        include(dirname(__FILE__).'/sql/uninstall.php'); // sql querriers

        // unregister hook
        if (parent::uninstall() &&
            $this->uninstallTab()) {
            return true;
        } else {
            $this->_errors[] = $this->l('There was an error during the desinstallation. Please contact us through Addons website');
            return false;
        }
        return parent::uninstall();
    }

    /**
     * This method is often use to create an ajax controller
     *
     * @param none
     * @return bool
     */
    public function installTab()
    {
        $tab = new Tab();
        $tab->active = 1;
        $tab->class_name = $this->controller_name;
        $tab->name = array();
        foreach (Language::getLanguages(true) as $lang) {
            $tab->name[$lang['id_lang']] = $this->name;
        }
        $tab->id_parent = -1;
        $tab->module = $this->name;
        $result = $tab->add();

        return ($result);
    }

    /**
     * uninstall tab
     *
     * @param none
     * @return bool
     */
    public function uninstallTab()
    {
        $id_tab = (int)Tab::getIdFromClassName($this->controller_name);
        if ($id_tab) {
            $tab = new Tab($id_tab);
            if (Validate::isLoadedObject($tab)) {
                return ($tab->delete());
            } else {
                $return = false;
            }
        } else {
            $return = true;
        }

        return ($return);
    }

    /**
     * load dependencies
     */
    public function loadAsset()
    {
        $controller = Context::getContext()->controller;
        // Load CSS
        $css = array(
            $this->css_path.'font-awesome.min.css',
            $this->css_path.'faq.css',
            $this->css_path.'menu.css',
            $this->css_path.'back.css',
            $this->css_path.'select2.min.css',
            $this->css_path.'select2-bootstrap.min.css',
            $this->css_path.$this->name.'.css',
        );

        $this->context->controller->addCSS($css, 'all');

        // Load JS
        $jss = array(
            $this->js_path.'vue.min.js',
            $this->js_path.'vue-paginate.min.js',
            $this->js_path.'faq.js',
            $this->js_path.'menu.js',
            $this->js_path.'back.js',
            $this->js_path.'sweetalert.min.js',
            $this->js_path.'select2.full.min.js',
            _PS_ROOT_DIR_.'js/tiny_mce/tiny_mce.js',
            _PS_ROOT_DIR_.'js/admin/tinymce.inc.js',
        );

        // prestashop plugin
        //$controller->addJqueryPlugin('select2');
        $controller->addJqueryPlugin('colorpicker');
        $controller->addJqueryUI('ui.sortable');

        $this->context->controller->addJS($jss);

        // Clean memory
        unset($jss, $css);
    }

    /**
     * FAQ API
     */
    public function loadFaq()
    {
        include_once('classes/APIFAQClass.php');
        $api = new APIFAQ();
        $faq = $api->getData($this->module_key, $this->version);
        return $faq;
    }

    /**
     * Load the configuration form
     */
    public function getContent()
    {
        if ((bool)version_compare(_PS_VERSION_, '1.7', '>=')) {
            $params = array('configure' => $this->name);
            $apiCallback = Context::getContext()->link->getAdminLink('AdminModules', true, false, $params);
        } else {
            $apiCallback = _PS_BASE_URL_.'/'.Context::getContext()->controller->admin_webpath.'/'.Context::getContext()->link->getAdminLink('AdminModules', true).'&configure='.$this->name.'&module_name='.$this->name;
        }

        $faq = $this->loadFaq();
        $this->loadAsset();
        $this->postProcess($apiCallback);

        $code = Tools::getValue('code');
        if (!empty($code)) {
            $instagram = new Andreyco\Instagram\Client(array(
                'apiKey'      => Configuration::get('PS_INSTA_ID'),
                'apiSecret'   => Configuration::get('PS_INSTA_SECRET'),
                'apiCallback' => $apiCallback,
            ));

            $data = $instagram->getOAuthToken($code);

            Configuration::updateValue('PS_INSTA_TOKEN', $data->access_token);

            $this->output .= $this->displayConfirmation($this->l('Saved with success !'));
        }

        // some stuff useful in smarty
        $context = Context::getContext();
        $id_lang = $this->context->language->id;
        $id_shop = $context->shop->id;
        if ($this->ps_version) {
            $params = array('configure' => $this->name);
            $moduleAdminLink = Context::getContext()->link->getAdminLink('AdminModules', true, false, $params);
        } else {
            $moduleAdminLink = Context::getContext()->link->getAdminLink('AdminModules', true).'&configure='.$this->name.'&module_name='.$this->name;
        }
        // controller ajax url
        $link = new Link();
        $controller_url = $link->getAdminLink($this->controller_name);

        //get readme
        $iso_lang = Language::getIsoById($id_lang);
        $doc = $this->docs_path.'readme_'.$iso_lang.'.pdf';

        //get tuto
        $iso_lang = Language::getIsoById($id_lang);
        $tuto = $this->docs_path.'tuto/tuto_'.$iso_lang.'.pdf';


        // get current page
        $currentPage = 'account';
        $page = Tools::getValue('page');
        if (!empty($page)) {
            $currentPage = Tools::getValue('page');
        }

        $CMS = CMS::getCMSPages($id_lang, null, true, $id_shop);
        $cmsConfPage = Context::getContext()->link->getAdminLink('AdminCmsContent');

        $params = array('addproduct');
        $productPage = Context::getContext()->link->getAdminLink('AdminProducts', true);

        $tmp = array();
        $languages = Language::getLanguages(false);
        foreach ($this->settings_conf as $index => $value) {
            if ($value === 'PS_INSTA_CUSTOM_TITLE' || $value === 'PS_INSTA_ALBUM_CUSTOM_DESC' || $value === 'PS_INSTA_CUSTOM_TITLE_BIS') {
                foreach ($languages as $lang) {
                    $tmp[$value][$lang['id_lang']] = Configuration::get($value, $lang['id_lang']);
                    $this->context->smarty->assign($index, $tmp[$value]);
                }
            } else {
                $tmp[$value] = Configuration::get($value);
                $this->context->smarty->assign($index, $tmp[$value]);
            }
        }
        foreach ($this->settings_account as $index => $value) {
            if ($value != 'PS_INSTA_TOKEN') {
                $tmp[$value] = Configuration::get($value);
                $this->context->smarty->assign($index, $tmp[$value]);
            }
        }

        // assign var to smarty
        $this->context->smarty->assign(array(
            'api_redirect_url' => $apiCallback,
            'module_name' => $this->name,
            'id_shop' => $id_shop,
            'module_version' => $this->version,
            'moduleAdminLink' => $moduleAdminLink,
            'id_lang' => $id_lang,
            'controller_url' => $controller_url,
            'apifaq' => $faq,
            'doc' => $doc,
            'tuto' => $tuto,
            'cmspage' => $CMS,
            'cmsConfPage' => $cmsConfPage,
            'module_display' => $this->displayName,
            'module_path' => $this->module_path,
            'logo_path' => $this->logo_path,
            'img_path' => $this->img_path,
            'languages' => $this->context->controller->getLanguages(),
            'defaultFormLanguage' => (int) $this->context->employee->id_lang,
            'productPage' => $productPage,
            'currentPage' => $currentPage,
            'products' => $this->getProducts(),
            'ps_base_dir' => _PS_BASE_URL_,
            'ps_version' => _PS_VERSION_,
            'isPs17' => $this->ps_version,
        ));

        $this->output .= $this->context->smarty->fetch($this->local_path.'views/templates/admin/menu.tpl');

        return $this->output;
    }

    public function postProcess($apiCallback)
    {
        // account form
        if (Tools::isSubmit('submitAccount')) {
            $errors = array();
            $languages = Language::getLanguages(false);

            $nbErrors = count($errors);
            if ($nbErrors == 0) {
                foreach ($this->settings_account as $value) {
                    if ($value != 'access_token') {
                        Configuration::updateValue($value, Tools::getValue($value));
                    }
                }
                $this->output .= $this->displayConfirmation($this->l('Saved with success !'));
            } else {
                $this->output .= $this->displayError($errors);
            }

            $instagram = new Andreyco\Instagram\Client(array(
                'apiKey'      => Configuration::get('PS_INSTA_ID'),
                'apiSecret'   => Configuration::get('PS_INSTA_SECRET'),
                'apiCallback' => $apiCallback,
                'scope'       => array('public_content', 'basic'),
            ));

            Tools::redirect($instagram->getLoginUrl());
        }

        // conf form
        if (Tools::isSubmit('submitpsagecheckerModule')) {
            $errors = array();
            $languages = Language::getLanguages(false);

            $nbErrors = count($errors);
            if ($nbErrors == 0) {
                foreach ($this->settings_conf as $value) {
                    if ($value === 'PS_INSTA_CUSTOM_TITLE' || $value === 'PS_INSTA_ALBUM_CUSTOM_DESC' || $value === 'PS_INSTA_CUSTOM_TITLE_BIS') {
                        $values = array();
                        foreach ($languages as $lang) {
                            $values[$value][$lang['id_lang']] = Tools::getValue($value.'_'.$lang['id_lang']);
                        }
                        Configuration::updateValue($value, $values[$value], true);
                        //p($values[$value]);
                    } else {
                        Configuration::updateValue($value, Tools::getValue($value));
                    }
                }
                //die('-');
                $this->output .= $this->displayConfirmation($this->l('Saved with success !'));
            } else {
                $this->output .= $this->displayError($errors);
            }
            //$errors[] = $this->l('Gift card validity period is required');
        }
    }

    public function hookDisplayHome($params)
    {
        if (Configuration::get('PS_INSTA_ON_HOMEPAGE')) {
            $this->loadFrontAsset();
            $this->displayWall();
            return $this->display(__FILE__, 'views/templates/hook/displayWall.tpl');
        }
    }

    public function hookDisplayFooterProduct()
    {
        if (Configuration::get('PS_INSTA_ON_PRODUCT_PAGE')) {
            $this->loadFrontAsset();
            $this->displayWall();
            $this->context->smarty->assign(array(
                'row' => Configuration::get('PS_INSTA_ROWS_PRODUCT'),
                'column' => Configuration::get('PS_INSTA_COLUMNS_PRODUCT'),
            ));
            return $this->display(__FILE__, 'views/templates/hook/displayWall.tpl');
        }
    }

    public function hookDisplayCMSDisputeInformation($params)
    {
        $currentCmsPage = Context::getContext()->controller->cms->id_cms;
        if (Configuration::get('PS_INSTA_SEPARATED_CMS') && Configuration::get('PS_INSTA_CMS') == $currentCmsPage) {
            $this->loadFrontAsset();
            $this->displayWall();
            return $this->display(__FILE__, 'views/templates/hook/displayWall.tpl');
        }
    }

    public function hookHeader($params)
    {
        if ('cms' === $this->context->controller->php_self) {
            $currentCmsPage = Context::getContext()->controller->cms->id;
            if (Configuration::get('PS_INSTA_SEPARATED_CMS') && Configuration::get('PS_INSTA_CMS') == $currentCmsPage) {
                $this->loadFrontAsset();
                $this->displayWall();
                $this->context->smarty->assign(array(
                    'header' => 1,
                ));
                return $this->display(__FILE__, 'views/templates/hook/displayWall.tpl');
            }
        }
    }

    public function displayWall()
    {
        $id_lang = Context::getContext()->language->id;

        $this->context->smarty->assign(array(
            'show_custom_title' => Configuration::get('PS_INSTA_SHOW_ALBUM'),
            'custom_title' => Configuration::get('PS_INSTA_CUSTOM_TITLE', $id_lang),
            'custom_title_font_size' => Configuration::get('PS_INSTA_TITLE_TEXT_SIZE'),
            'custom_title_color' => Configuration::get('PS_INSTA_TITLE_TEXT_COLOR'),
            'desc' => Configuration::get('PS_INSTA_ALBUM_CUSTOM_DESC', $id_lang),
            'show_custom_title_bis' => Configuration::get('PS_INSTA_SHOW_CUSTOM_TITLE_BIS'),
            'custom_title_bis' => Configuration::get('PS_INSTA_CUSTOM_TITLE_BIS', $id_lang),
            'custom_title_bis_font_text' => Configuration::get('PS_INSTA_CUSTOM_TITLE_COLOR_BIS'),
            'number_columns' => Configuration::get('PS_INSTA_NUMBER_COLUMNS'),
            'row' => Configuration::get('PS_INSTA_NUMBER_ROWS'),
            'column' => Configuration::get('PS_INSTA_NUMBER_COLUMNS'),
            'base_url' => Tools::getHttpHost(true),
            'header' => 0,
        ));
    }

    public function getProducts()
    {
        $id_lang = (int)Context::getContext()->language->id;
        $link = new Link();

        $products = Product::getProducts($id_lang, 0, 'all', 'name', 'ASC');

        $select2list = array();
        foreach ($products as $product) {
            $cover = Product::getCover($product['id_product']);
            $productCover = $link->getImageLink($product['name'], $product['id_product'].'-'.$cover['id_image']);
            array_push($select2list, array(
                'id_product' => $product['id_product'],
                'productName' => $product['name'],
                'imgUrl' => $productCover
            ));
        }

        return $select2list;
    }

    // load css and js in front -> ps16 only
    public function loadFrontAsset()
    {
        if (version_compare(_PS_VERSION_, '1.7.0.0') < 1) {
            $this->context->controller->addCSS($this->css_path.'front.css');
            $this->context->controller->addJS($this->js_path.'vue.min.js');
            $this->context->controller->addJS($this->js_path.'front.js');
        }
    }

    // load css and js in front -> ps17 only
    public function hookActionFrontControllerSetMedia()
    {
        if (version_compare(_PS_VERSION_, '1.7.0.0') >= 0) {
            $current_page = $this->context->controller->php_self;
            $currentCmsPage = 0;
            if ($current_page == 'cms') {
                $currentCmsPage = Context::getContext()->controller->cms->id_cms;
            }

            if ((Configuration::get('PS_INSTA_ON_PRODUCT_PAGE') && $current_page == 'product') ||
                (Configuration::get('PS_INSTA_SEPARATED_CMS') && Configuration::get('PS_INSTA_CMS') == $currentCmsPage) ||
                (Configuration::get('PS_INSTA_ON_HOMEPAGE') && $current_page == 'index')) {
                $this->context->controller->registerStylesheet(
                    'pssocialmedia-front-css',
                    'modules/'.$this->name.'/views/css/front.css'
                );
                $this->context->controller->registerJavascript(
                    'pssocialmedia-vue-js',
                    'modules/'.$this->name.'/views/js/vue.min.js'
                );
                $this->context->controller->registerJavascript(
                    'pssocialmedia-front-js',
                    'modules/'.$this->name.'/views/js/front.js'
                );
            }
        }
    }
}