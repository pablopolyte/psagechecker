<!--
* 2007-2017 PrestaShop
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
* @author    PrestaShop SA <contact@prestashop.com>
* @copyright 2007-2017 PrestaShop SA
* @license   http://addons.prestashop.com/en/content/12-terms-and-conditions-of-use
* International Registered Trademark & Property of PrestaShop SA
-->

<div id="pssocialfeed_block" class="preload">
    <div id="pssocialfeed-lightbox" class="lightbox pssocialfeed_hide">
        <div class="lightbox-content">
            <div style="height:100%">
                <div class="logo_age_verify">
                    <img src="{{$ps_url}}logo.png" height="50px"/><br />
                </div>
                <div class="age_verify">
                    {l s='Age Verification' mod='psagechecker'}
                </div>
                <div class="custom_msg_age_verify">
                    {$custom_msg nofilter}
                </div>
                <div class="age_verify_buttons">
                    <button class="btn btn_deny" >{$deny_button|escape:'htmlall':'UTF-8'}</button>
                    <button class="btn btn_confirm" >{$confirm_button|escape:'htmlall':'UTF-8'}</button>
                </div>
            </div>
        </div>
    </div>
    <div id="overlay" class="pssocialfeed_hide"></div>

</div>
<style>
    .lightbox{
        background-color: {$popup_bg_color|escape:'htmlall':'UTF-8'} !important;
        font-family: {$font_family|escape:'htmlall':'UTF-8'} !important;;
    }
    .btn_deny{
        background-color: {$deny_bg_color|escape:'htmlall':'UTF-8'} !important;
        color: {$deny_txt_color|escape:'htmlall':'UTF-8'} !important;
    }
    .btn_confirm{
        background-color: {$confirm_bg_color|escape:'htmlall':'UTF-8'} !important;
        color: {$confirm_txt_color|escape:'htmlall':'UTF-8'} !important;
    }
    #pssocialfeed_block .lightbox{
        width : {$popup_width|escape:'htmlall':'UTF-8'}px !important;
        height : {$popup_height|escape:'htmlall':'UTF-8'}px !important;
    }
</style>
{literal}
<script type="text/javascript">
    var header = "{/literal}{$header|escape:'htmlall':'UTF-8'}{literal}";
    var row = "{/literal}{$row|escape:'htmlall':'UTF-8'}{literal}";
    var column = "{/literal}{$column|escape:'htmlall':'UTF-8'}{literal}";
    var base_url = "{/literal}{$base_url|escape:'htmlall':'UTF-8'}{literal}";
</script>
{/literal}
