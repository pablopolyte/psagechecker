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

    $(document).on('click', '#overlay, #close', function (e) {
        $("#overlay, #pssocialfeed-lightbox").addClass('pssocialfeed_hide');
    });


    $(document).on('click', '#deny_button', function (e) {
        $(".deny_msg_age_verify").removeClass('psagechecker-hide');
        $(".blockAgeVerify").addClass('psagechecker-hide');
    });

    $(document).on('click', '#submitAge', function (e) {
        var day = $("#day");
        var month = $("#month");
        var year = $("#year");

        console.log(getAge(year+'/'+month+'/'+day))
    });

    function getAge(dateString) {
        var today = new Date();
        var birthDate = new Date(dateString);
        var age = today.getFullYear() - birthDate.getFullYear();
        var m = today.getMonth() - birthDate.getMonth();

        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }

        return age;
    }

    function truncate(string){
        if (string.length > 35) {
            return string.substring(0,35)+'...';
        } else {
            return string;
        }
    };
});
