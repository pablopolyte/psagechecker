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

$(window).ready(function() {
    var d = new Date();
    d.setMonth(d.getMonth() + 1);

    var c = getCookie('psagechecker');
    if (c.length == 0)
    {
        $('body').css('overflow', 'hidden');
        $("#psagechecker_block").removeClass('psagechecker-hide');
        $("#overlay").removeClass('psagechecker-hide');
    } else {
        $('body').css('overflow', 'initial');
    }

    $(document).on('click', '#deny_button', function (e) {
        $(".deny_msg_age_verify").removeClass('psagechecker-hide');
        $(".blockAgeVerify").addClass('psagechecker-hide');
    });

    $(document).on('click', '#confirm_button', function (e) {
        setCookie("psagechecker", "on", d);
        $("#psagechecker_block").addClass('psagechecker-hide');
        $('body').css('overflow', 'initial');
    });

    $(document).on('click', '#submitAge', function (event) {
        event.preventDefault();
        var day = $("#day").val();
        var month = $("#month").val();
        var year = $("#year").val();
        var age = getAge(year+'/'+month+'/'+day);

        if (day != '' && month != '' && year != '') {
            if ( age < age_required) {
                $(".deny_msg_age_verify").removeClass('psagechecker-hide');
                $(".blockAgeVerify").addClass('psagechecker-hide');
            } else {
                setCookie("psagechecker", "on", d);
                $("#psagechecker_block").addClass('psagechecker-hide');
                $('body').css('overflow', 'initial');
            }
        } else {
            $(".deny_msg_age_verify").removeClass('psagechecker-hide');
            $(".blockAgeVerify").addClass('psagechecker-hide');
        }
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

    //function getCookie
    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1);
            if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
        }
        return "";
    }

    //function setcookie
    function setCookie(cname, cvalue, exdays) {
        document.cookie = cname + "=" + cvalue +"expire=" + exdays + "; path=/";
        //$.cookie( cname, cvalue, { path: '/', expires: 30 });
    }

});
