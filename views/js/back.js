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
    controller_url = controller_url.replace(/\amp;/g,'');

    if (!isPs17) {
        ad = 'test';
        iso = 'en';
    }

    $('#CB-OPACITY').bootstrapSlider();
    $("#CB-OPACITY").on("slide", function(slideEvt) {
        $(".cookiebanner-number").val(slideEvt.value);
    });

    $('.cookiebanner-number').bind('input', function() {
        $('#CB-OPACITY').bootstrapSlider('setValue', $(this).val());
    });



    tinySetup({
        editor_selector : "autoload_rte",
        plugins : 'code advlist autolink link lists charmap print textcolor colorpicker style',
    });

    $('#product1').select2({
        placeholder: select2placeholder,
        allowClear: true
    });
    $('#product2').select2({
        placeholder: select2placeholder,
        allowClear: true
    });

    tagList = [];
    imageList = [];
    getImages();
    generateCache();

    $(document).on('click', '#saveAssignProduct', function (e) {
        var id_image = $(this).attr('data-id-image');
        var id_product1 = $('#product1').val();
        var id_product2 = $('#product2').val();

        $.ajax({
            type: 'POST',
            url: controller_url,
            dataType: 'JSON',
            data: {
                action: 'AssignProduct',
                ajax: true,
                id_image: id_image,
                id_product1: id_product1,
                id_product2: id_product2
            },
            success: function(data) {
                generateCache();
                showSuccessMessage(msgAssignProduct);
            },
            error: function(err) {
                console.log(err);
            }
        });
    });

    $(window).keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            var tag = $("input[name=PS_INSTA_SEARCH]").val();
            getTag(tag);
        }
    });

    $(document).on('click', '.switch', function (e) {
        var toggleOption = $(this).children(':first').attr('name');
        var isChecked = $("input[name='"+toggleOption+"']:checked").val();

        if (isChecked == 1) {
            $('#'+toggleOption).removeClass('hide');
        } else {
            $('#'+toggleOption).addClass('hide');
        }
    });

    vImagePreselection = new Vue({
        el: '#image-preselection',
        delimiters: ["((","))"],
        data: {
            items: '',
            paginate: ['items'],
            search : false,
        },
        components: {
        },
        methods: {
            getTag: function () {
                var tag = $("input[name=PS_INSTA_SEARCH]").val();
                getTag(tag);
            },
            addImage: function (idMedia, index) {
                imageData = this.items[index];
                addImage(imageData, index);
            },
            removeImage: function (idMedia, index) {
                removeImageByIdMedia(idMedia, index);
            },
        }
    });

    vImageManager = new Vue({
        el: '#image-manager',
        delimiters: ["((","))"],
        data: {
            imageList: imageList,
        },
        methods: {
            getImages: function () {
                getImages();
            },
            disableImage: function (id, index) {
                disableImage(id, index);
            },
            removeImage: function (id, idMedia) {
                removeImageById(id, idMedia);
            },
            loadModal: function (id) {
                $('#saveAssignProduct').attr('data-id-image', id);
                getAssignedProduct(id);
            },
        }
    });

    function getObjects(obj, key, val, index) {
        var objects = [];
        var result = index;
        for (var i in obj) {
            if (!obj.hasOwnProperty(i)) continue;
            if (typeof obj[i] == 'object') {
                objects = objects.concat(getObjects(obj[i], key, val, i));
            } else if (i == key && obj[key] == val) {
                result = index;
                vImagePreselection.items[result].isActive = 0;
                //vImagePreselection.paginate.items.list[index].isActive = 0;
            }
        }
    }

    function getImages() {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: controller_url,
            data: {
                ajax: true,
                action: 'GetImages',
            },
            success: function(data) {
                vImageManager.imageList = data;
            },
            error: function(err) {
                console.log(err);
            }
        });
    }

    function getTag(tagName) {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: controller_url,
            data: {
                ajax: true,
                action: 'GetTag',
                tagName: tagName,
            },
            success: function(data) {
                vImagePreselection.items = data;
                vImagePreselection.search = true;
            },
            error: function(err) {
                console.log(err);
            }
        });
    }

    function addImage(imageData, index) {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: controller_url,
            data: {
                ajax: true,
                action: 'AddImage',
                imageData: imageData,
            },
            success: function(data) {
                vImagePreselection.paginate.items.list[index].isActive = 1;
                getImages();
                generateCache();
                showSuccessMessage(msgAddImage);
            },
            error: function(err) {
                console.log(err);
            }
        });
    }

    function disableImage(id, index) {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: controller_url,
            data: {
                ajax: true,
                action: 'DisableImage',
                id: id,
            },
            success: function(data) {
                if (data == 'disable') {
                    showSuccessMessage(msgDisableImage);
                    vImageManager.imageList[index].isActive = 0;
                } else {
                    vImageManager.imageList[index].isActive = 1;
                    showSuccessMessage(msgEnableImage);
                }
                generateCache();
            },
            error: function(err) {
                console.log(err);
            }
        });
    }

    function removeImageByIdMedia(idMedia, index) {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: controller_url,
            data: {
                ajax: true,
                action: 'RemoveImageByIdMedia',
                idMedia: idMedia,
            },
            success: function(data) {
                //vImagePreselection.items[index].isActive = 0;
                vImagePreselection.paginate.items.list[index].isActive = 0;
                getImages();
                generateCache();
                showSuccessMessage(msgRemoveImage);
            },
            error: function(err) {
                console.log(err);
            }
        });
    }

    function removeImageById(id, idMedia) {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: controller_url,
            data: {
                ajax: true,
                action: 'RemoveImageById',
                id: id,
            },
            success: function(data) {
                getObjects(vImagePreselection.items, 'id', idMedia);
                getImages();
                generateCache();
                showSuccessMessage(msgRemoveImage);
            },
            error: function(err) {
                console.log(err);
            }
        });
    }

    function getAssignedProduct(idImage) {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: controller_url,
            data: {
                ajax: true,
                action: 'GetAssignedProduct',
                id_image: idImage,
            },
            success: function(data) {
                $('#product1').val(data[0].product1).trigger('change');
                $('#product2').val(data[0].product2).trigger('change');
            },
            error: function(err) {
                console.log(err);
            }
        });
    }

    function generateCache() {
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: controller_url,
            data: {
                ajax: true,
                action: 'GenerateCache',
            },
            success: function(data) {
            },
            error: function(err) {
                console.log(err);
            }
        });
    }

    $(document).on('change', '.slide_image', function (e) {
        console.log('change');
        readURL(this, $(this).attr('data-preview'));
    });
    function readURL(input, id) {
        if (input.files && input.files[0]) {
            console.log('here');
            var reader = new FileReader();
            console.log(reader);
            reader.onload = function (e) {
                if ($('#'+id).hasClass('hide')) {
                    $('#'+id).removeClass('hide');
                }
                $('#'+id).attr('src', e.target.result);
            }
            console.log(input.files);
            reader.readAsDataURL(input.files[0]);
            $(".slide_url").attr('value', input.files[0].name);
        }
    }

    $(".slide_url").each(function() {
        var str = $(this).attr('value');
        var delimiter = '/';
        var split = str.split(delimiter);
        var image_name = split[split.length-1];
        $(this).attr('value', image_name);
    });

    

});
