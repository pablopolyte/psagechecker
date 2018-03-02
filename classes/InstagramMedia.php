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

class InstagramMedia extends ObjectModel
{
    public $id;
    public $id_media;
    public $authorName;
    public $profile_picture;
    public $tags;
    public $text;
    public $url;
    public $created_time;
    public $comments;
    public $likes;
    public $id_product1;
    public $id_product2;
    public $active;
    public $id_shop;
    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'pssocialfeed',
        'primary' => 'id_pssocialfeed',
        'fields' => array(
            'id_media' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => true),
            'authorName' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => true),
            'profile_picture' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => false),
            'tags' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => false),
            'text' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => false),
            'url' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => true),
            'created_time' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => true),
            'comments' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => false),
            'likes' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => false),
            'id_product1' => array('type' => self::TYPE_INT, 'validate' => 'isunsignedInt', 'required' => false),
            'id_product2' => array('type' => self::TYPE_INT, 'validate' => 'isunsignedInt', 'required' => false),
            'active'  => array('type' => self::TYPE_BOOL, 'validate' => 'isBool', 'required' => true),
            'id_shop' => array('type' => self::TYPE_INT, 'validate' => 'isunsignedInt', 'required' => true),
        )
    );

    /*
     * get all media
     */
    public static function getImages($id_shop, $isActive = false)
    {
        $sql= 'SELECT * FROM `'._DB_PREFIX_.'pssocialfeed` where id_shop ='.(int)$id_shop;
        if ($isActive) {
            $sql .= ' and active = 1';
        }
        $imageList = Db::getInstance()->ExecuteS($sql);

        $images = array();
        foreach ($imageList as $image) {
            array_push($images, array(
                'id' => $image['id_pssocialfeed'],
                'id_media' => $image['id_media'],
                'authorName' => $image['authorName'],
                'profile_picture' => $image['profile_picture'],
                'text' => $image['text'],
                'url' => $image['url'],
                'likes' => $image['likes'],
                'comments' => $image['comments'],
                'created_time' => $image['created_time'],
                'tags' => $image['tags'],
                'id_product1' => $image['id_product1'],
                'id_product2' => $image['id_product2'],
                'isActive' => $image['active'],
            ));
        }

        unset($imageList);

        return $images;
    }
}
