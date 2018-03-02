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
*
* Don't forget to prefix your containers with your own identifier
* to avoid any conflicts with others containers.
*/

$(window).ready(function() {

    if (header) {
        $('#pssocialfeed_block').appendTo('#center_column');
    }

    //$('.grid').removeClass("preload");
    images = [];
    product1 = [];
    product2 = [];
    imageInfo = {
        'product1' : product1,
        'product2': product2
    };

    window.vImageWall = new Vue({
        el: '#pssocialfeed_block',
        delimiters: ["((","))"],
        data: {
            images: images,
            imageInfo: imageInfo,
            row: row,
            column: column,
            currentItems: '',
            noMoreResults: false,
        },
        created:function() {
            this.getImages();
        },
        methods: {
            getImages: function () {
                $.ajax({
                    url: base_url+'/modules/pssocialfeed/cache/api-cache.json',
                    success: function(data) {
                        this.images = data;
                        var items = this.column * this.row;
                        this.images = data.slice(0, items);
                        this.currentItems = items;
                    }.bind(this)
                });
            },
            loadMore: function (currentItems) {
                $.ajax({
                    url: base_url+'/modules/pssocialfeed/cache/api-cache.json',
                    success: function(data) {
                        var items = parseFloat(this.currentItems) + parseFloat(this.column)*2;
                        this.images = data;
                        this.images = data.slice(0, items);
                        this.currentItems = items;
                        if (items > data.length) {
                            this.noMoreResults = true;
                        }
                    }.bind(this)
                });
            },
            getInfoImage: function (index) {
                this.imageInfo['product1'] = this.images[index].product1;
                this.imageInfo['product2'] = this.images[index].product2;
                this.imageInfo.authorName = this.images[index].authorName;
                this.imageInfo.text = this.images[index].text;
                this.imageInfo.url = this.images[index].url;
                this.imageInfo.profile_picture = this.images[index].profile_picture;

                if (this.imageInfo['product1'].name) {
                    this.imageInfo['product1'].name = truncate(this.imageInfo['product1'].name);
                }
                if (this.imageInfo['product2'].name) {
                    this.imageInfo['product2'].name = truncate(this.imageInfo['product2'].name);
                }
                $("#overlay, #pssocialfeed-lightbox").removeClass('pssocialfeed_hide');
            },
            productClass: function (product) {
                if (product === null) {
                    return "col-md-12 col-lg-6";
                }
            }
        }
    });

    $(document).on('click', '#overlay, #close', function (e) {
        $("#overlay, #pssocialfeed-lightbox").addClass('pssocialfeed_hide');
    });

    function truncate(string){
        if (string.length > 35) {
            return string.substring(0,35)+'...';
        } else {
            return string;
        }
    };
});
