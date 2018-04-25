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

    $(document).on('click', '.switch', function (e) {
        var toggleOption = $(this).children(':first').attr('name');
        var isChecked = $("input[name='"+toggleOption+"']:checked").val();

        if (isChecked == 1) {
            $('#'+toggleOption).removeClass('hide');
        } else {
            $('#'+toggleOption).addClass('hide');
        }
    });

    $(document).on('click', '.input_img', function () {
        if ($(this).hasClass('js-show-all')) {
            $('.confirm_deny').slideDown();
        } else {
            $('.confirm_deny').slideUp();
        }
    });


    $(document).on('change', '.slide_image', function (e) {

        readURL(this, $(this).attr('data-preview'));
    });
    function readURL(input, id) {
        if (input.files && input.files[0]) {

            var reader = new FileReader();
 
            reader.onload = function (e) {
                if ($('#'+id).hasClass('hide')) {
                    $('#'+id).removeClass('hide');
                }
                $('#'+id).attr('src', e.target.result);
            }

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

    $(document).on('change', ':file', function() {
        var input = $(this),
        numFiles = input.get(0).files ? input.get(0).files.length : 1,
        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.trigger('fileselect', [numFiles, label]);
    });

    $(':file').on('fileselect', function(event, numFiles, label) {
        var input = $(this).parents('.input-group').find(':text'),
        log = numFiles > 1 ? numFiles + ' files selected' : label;

        if(input.length) {
            input.val(log);
        } else {
            if(log) alert(log);
        }
    });


});
