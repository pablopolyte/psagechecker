<?php
/**
* 2007-2016 PrestaShop
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
* @author    PrestaShop SA <contact@prestashop.com>
* @copyright 2007-2015 PrestaShop SA
* @license   http://addons.prestashop.com/en/content/12-terms-and-conditions-of-use
* International Registered Trademark & Property of PrestaShop SA
*/

class AdminAjaxPssocialfeedController extends ModuleAdminController
{
    public function ajaxProcessGetTag()
    {
        $tag = pSQL(Tools::getValue('tagName'));

        $instagram = new Andreyco\Instagram\Client(array(
            'apiKey'      => Configuration::get('PS_INSTA_ID'),
            'apiSecret'   => Configuration::get('PS_INSTA_SECRET'),
            'apiCallback' => '',
            'scope'       => array('public_content', 'basic'),
        ));

        $instagram->setAccessToken(Configuration::get('PS_INSTA_TOKEN'));

        $feed = $instagram->getTagMedia($tag);
        $feed = $feed->data;

        $images = array();
        foreach ($feed as $image) {
            $active = 0;
            if ($this->checkImageExist($image->id)) {
                $active = 1;
            }
            $hashtags = '';
            foreach ($image->tags as $hashtag) {
                if (empty($hashtags)) {
                    $hashtags .= '#'.$hashtag;
                } else {
                    $hashtags .= ', #'.$hashtag;
                }
            }

            array_push($images, array(
                'id' => $image->id,
                'authorName' => $image->user->username,
                'profile_picture' => $image->user->profile_picture,
                'text' => $image->caption->text,
                'url' => $image->images->standard_resolution->url,
                'likes' => $image->likes->count,
                'comments' => $image->comments->count,
                'created_time' => date('j / m / Y', $image->created_time),
                'tags' => $hashtags,
                'isActive' => $active,
            ));
        }

        unset($feed, $image, $instagram);

        die(json_encode($images));
    }

    public function ajaxProcessGetImages()
    {
        $id_shop = (int)Context::getContext()->shop->id;
        $imageList = InstagramMedia::getImages($id_shop);

        die(json_encode($imageList));
    }

    public function ajaxProcessAddImage()
    {
        $imageData = Tools::getValue('imageData');
        $id_shop = (int)Context::getContext()->shop->id;

        if (isset($imageData)) {
            $image = new InstagramMedia();
            $image->id_media = $imageData['id'];
            $image->authorName = $imageData['authorName'];
            $image->profile_picture = $imageData['profile_picture'];
            $image->tags = $imageData['tags'];
            $image->text = $imageData['text'];
            $image->url = $imageData['url'];
            $image->created_time = $imageData['created_time'];
            $image->comments = $imageData['comments'];
            $image->likes = $imageData['likes'];
            $image->active = 1;
            $image->id_shop = $id_shop;
            $image->save();
        }
    }

    public function ajaxProcessRemoveImageByIdMedia()
    {
        $idMedia = Tools::getValue('idMedia');
        $id_shop = (int)Context::getContext()->shop->id;

        if (isset($idMedia)) {
            $sql = 'SELECT id_pssocialfeed FROM `'._DB_PREFIX_.'pssocialfeed` psig WHERE psig.id_media ="'.pSQL($idMedia).'" and psig.id_shop ='.(int)$id_shop;
            $result = Db::getInstance()->getRow($sql);

            $id_image = $result['id_pssocialfeed'];

            $image = new InstagramMedia($id_image);
            $image->delete();
        }
    }

    public function ajaxProcessRemoveImageById()
    {
        $id = (int)Tools::getValue('id');

        $image = new InstagramMedia($id);
        $image->delete();
    }

    public function ajaxProcessDisableImage()
    {
        $id = (int)Tools::getValue('id');

        $image = new InstagramMedia($id);
        $active = $image->active;
        if ($active == 1) {
            $image->active = 0;
        } else {
            $image->active = 1;
        }
        $image->save();

        if ($image->active == 0) {
            die(json_encode('disable'));
        } else {
            die(json_encode('enable'));
        }
    }

    public function ajaxProcessAssignProduct()
    {
        $id_image = (int)Tools::getValue('id_image');

        if (!empty($id_image)) {
            $image = new InstagramMedia($id_image);
            $image->id_product1 = (int)Tools::getValue('id_product1');
            $image->id_product2 = (int)Tools::getValue('id_product2');
            $image->save();
        }
    }

    public function ajaxProcessGetAssignedProduct()
    {
        $id_image = (int)Tools::getValue('id_image');

        $assignedProducts = array();
        if (!empty($id_image)) {
            $image = new InstagramMedia($id_image);
            $id_product1 = $image->id_product1;
            $id_product2 = $image->id_product2;

            array_push($assignedProducts, array(
                'product1' => $id_product1,
                'product2' => $id_product2,
            ));

            die(json_encode($assignedProducts));
        }
    }

    public function checkImageExist($idMedia)
    {
        $id_shop = (int)Context::getContext()->shop->id;
        $sql = 'SELECT id_pssocialfeed FROM `'._DB_PREFIX_.'pssocialfeed` psig WHERE psig.id_media ="'.pSQL($idMedia).'" and psig.id_shop ='.(int)$id_shop.';';
        $result = Db::getInstance()->getRow($sql);

        if (empty($result)) {
            $return = false;
        } else {
            $return = true;
        }

        return $return;
    }

    public function displayAjaxGenerateCache()
    {
        $id_lang = Context::getContext()->language->id;
        $id_shop = Context::getContext()->shop->id;
        $link = new Link();

        $mediaList = InstagramMedia::getImages($id_shop, true);

        $images = array();
        foreach ($mediaList as $image) {
            $product1 = new Product($image['id_product1'], false, $id_lang);
            $product2 = new Product($image['id_product2'], false, $id_lang);

            $product1_cover = Product::getCover($image['id_product1']);
            $product2_cover = Product::getCover($image['id_product2']);

            $product1_rewrite = $product1->link_rewrite;
            $product2_rewrite = $product2->link_rewrite;

            $product1_cover = Tools::getShopProtocol().$link->getImageLink($product1_rewrite, $image['id_product1'].'-'.$product1_cover['id_image']);
            $product2_cover = Tools::getShopProtocol().$link->getImageLink($product2_rewrite, $image['id_product2'].'-'.$product2_cover['id_image']);

            $priceProduct1 = Product::getPriceStatic($image['id_product1'], true, null, 2);
            $priceProduct2 = Product::getPriceStatic($image['id_product2'], true, null, 2);

            array_push($images, array(
                'id' => $image['id'],
                'id_media' => $image['id_media'],
                'authorName' => $image['authorName'],
                'profile_picture' => $image['profile_picture'],
                'text' => $image['text'],
                'url' => $image['url'],
                'likes' => $image['likes'],
                'comments' => $image['comments'],
                'created_time' => $image['created_time'],
                'tags' => $image['tags'],
                'product1' => array(
                    'name' => $product1->name,
                    'image' => $product1_cover,
                    'price' => Context::getContext()->currency->sign.$priceProduct1,
                    'url' => $link->getProductLink($product1),
                ),
                'product2' => array(
                    'name' => $product2->name,
                    'image' => $product2_cover,
                    'price' => Context::getContext()->currency->sign.$priceProduct2,
                    'url' => $link->getProductLink($product2),
                ),
            ));
        }

        unset($link, $product1, $product2);

        file_put_contents(_PS_MODULE_DIR_.'pssocialfeed/cache/api-cache.json', json_encode($images));
        die(json_encode('cache generated'));
    }
}
