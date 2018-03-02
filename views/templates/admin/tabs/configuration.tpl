{*
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
*}
<form method="post" action="{$moduleAdminLink|escape:'htmlall':'UTF-8'}&page=conf" class="form-horizontal">

<div class="panel col-lg-10 right-panel">
    <h3>
        <i class="fa fa-tasks"></i> {l s='Configuration' mod='psagechecker'} <small>{$module_display|escape:'htmlall':'UTF-8'}</small>
    </h3>

    {* PS AGE CHECHER STATUS *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="boldtext control-label">{l s='Display age verification pop up' mod='psagechecker'}</label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">
            <span class="switch prestashop-switch fixed-width-lg">
                <input class="yes" type="radio" name="PS_AGE_CHECKER_SHOW_POPUP" id="album_title_on" data-toggle="collapse" data-target="#" value="1" {if $show_popup eq 1}checked="checked"{/if}>
                <label for="album_title_on" class="radioCheck">{l s='YES' mod='psagechecker'}</label>

                <input class="no" type="radio" name="PS_AGE_CHECKER_SHOW_POPUP" id="album_title_off" data-toggle="collapse" data-target="#" value="0" {if $show_popup eq 0}checked="checked"{/if}>
                <label for="album_title_off" class="radioCheck">{l s='NO' mod='psagechecker'}</label>
                <a class="slide-button btn"></a>
            </span>
        </div>
    </div>
    {* PS AGE CHECHER STATUS *}

    {* PS AGE CHECHER MINIMUM AGE *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                        {l s='Minimum age' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
            <input class="addons-number-fields addons-inline-block" required="required" value="{$minimum_age|escape:'htmlall':'UTF-8'}" type="number" name="PS_AGE_CHECKER_AGE_MINIMUM">
        </div>
    </div>
    {* PS AGE CHECHER MINIMUM AGE *}

    {* PS AGE CHECHER VERIFICATION METHOD *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                        {l s='Verification method' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
            <label>
                <input type="radio" class="input_img" name="PS_AGE_CHECKER_VERIFICATION_METHOD" value="0" {if $show_popup eq 0}checked="checked"{/if}/>
                <img src="{$img_path}birth.png">
                <div class="help-block">
                    <p>{l s='confirm/Deny buttons'}</p>
                </div>

            </label>
            <label>
                <input type="radio" class="input_img" name="PS_AGE_CHECKER_VERIFICATION_METHOD" value="1" {if $show_popup eq 1}checked="checked"{/if}/>
                <img src="{$img_path}confirm.png">
                <div class="help-block">
                    <p>{l s='birth day check'}</p>
                </div>
            </label>
        </div>
    </div>
    {* PS AGE CHECHER VERIFICATION METHOD *}

</div>

<div class="panel col-lg-10 right-panel">
    <h3>
        <i class="fa fa-tasks"></i> {l s='Album Display' mod='psagechecker'} <small>{$module_display|escape:'htmlall':'UTF-8'}</small>
    </h3>

    {* ALBUM CUSTOM TITLE *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="boldtext control-label">{l s='Show album custom title' mod='psagechecker'}</label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">
            <span class="switch prestashop-switch fixed-width-lg">
                <input class="yes" type="radio" name="PS_INSTA_SHOW_ALBUM" id="album_title_on" data-toggle="collapse" data-target="#" value="1" {if $show_album eq 1}checked="checked"{/if}>
                <label for="album_title_on" class="radioCheck">{l s='YES' mod='psagechecker'}</label>

                <input class="no" type="radio" name="PS_INSTA_SHOW_ALBUM" id="album_title_off" data-toggle="collapse" data-target="#" value="0" {if $show_album eq 0}checked="checked"{/if}>
                <label for="album_title_off" class="radioCheck">{l s='NO' mod='psagechecker'}</label>
                <a class="slide-button btn"></a>
            </span>
        </div>
    </div>
    {* ALBUM CUSTOM TITLE *}

    <div id="PS_INSTA_SHOW_ALBUM" {if $show_album eq 0}class="hide"{/if}>
    {* ALBUM TITLE *}
    {foreach from=$languages item=language}
        {if $languages|count > 1}
            <div class="translatable-field lang-{$language.id_lang|escape:'htmlall':'UTF-8'}" {if $language.id_lang != $defaultFormLanguage}style="display:none"{/if}>
        {/if}
        <div class="form-group">
            <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
                <div class="text-right">
                    <label class="control-label required">
                        {l s='Album custom title' mod='psagechecker'}
                    </label>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-7 col-lg-4">
                <input class="" type="text" value="{$album_custom_title[$language.id_lang]|escape:'htmlall':'UTF-8'}" name="PS_INSTA_CUSTOM_TITLE_{$language.id_lang|escape:'htmlall':'UTF-8'}" placeholder="{l s='Title' mod='psagechecker'}">
            </div>
            {if $languages|count > 1}
                <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
                    <button type="button" class="btn btn-default dropdown-toggle" tabindex="-1" data-toggle="dropdown">
                        {$language.iso_code|escape:'htmlall':'UTF-8'}
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                        {foreach from=$languages item=lang}
                        <li><a class="currentLang" data-id="{$lang.id_lang|escape:'htmlall':'UTF-8'}" href="javascript:hideOtherLanguage({$lang.id_lang|escape:'javascript'});" tabindex="-1">{$lang.name|escape:'htmlall':'UTF-8'}</a></li>
                        {/foreach}
                    </ul>
                </div>
            {/if}
        </div>
        {if $languages|count > 1}
            </div>
        {/if}
    {/foreach}
    {* ALBUM TITLE *}

    {* TITLE COLOR *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                    {l s='Title text color' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-2">
            <div class="input-group">
                <input type="text" data-hex="true" class="color mColorPickerInput mColorPicker" name="PS_INSTA_TITLE_TEXT_COLOR" value="{if isset($album_custom_title_color)}{$album_custom_title_color|escape:'htmlall':'UTF-8'}{/if}" id="color_1" style="background-color:{if isset($album_custom_title_color)}{$album_custom_title_color|escape:'htmlall':'UTF-8'}{/if}; color: back;"><span style="cursor:pointer;" id="icp_color_1" class="mColorPickerTrigger input-group-addon" data-mcolorpicker="true"><img src="../img/admin/color.png" style="border:0;margin:0 0 0 3px" align="absmiddle"></span>
            </div>
        </div>
    </div>
    {* TITLE COLOR *}

    {* TITLE SIZE *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                        {l s='Title size text' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
            <input class="addons-number-fields addons-inline-block" required="required" value="{$album_custom_title_size|escape:'htmlall':'UTF-8'}" type="number" name="PS_INSTA_TITLE_TEXT_SIZE">
        </div>
    </div>
    {* TITLE SIZE *}
    </div>

    {* ALBUM CUSTOM DESCRIPTION *}
    {foreach from=$languages item=language}
        {if $languages|count > 1}
            <div class="translatable-field lang-{$language.id_lang|escape:'htmlall':'UTF-8'}" {if $language.id_lang != $defaultFormLanguage}style="display:none"{/if}>
        {/if}
        <div class="form-group">
            <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
                <div class="text-right">
                    <label for="buylater_title_text" class="control-label">
                            {l s='Album custom description' mod='psagechecker'}
                    </label>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-7 col-lg-6">
                <textarea class="autoload_rte" name="PS_INSTA_ALBUM_CUSTOM_DESC_{$language.id_lang|escape:'htmlall':'UTF-8'}" text="" rows="4" cols="80">{$album_custom_desc[$language.id_lang]|escape:'htmlall':'UTF-8'}</textarea>
            </div>
            {if $languages|count > 1}
                <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
                    <button type="button" class="btn btn-default dropdown-toggle" tabindex="-1" data-toggle="dropdown">
                        {$language.iso_code|escape:'htmlall':'UTF-8'}
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                        {foreach from=$languages item=lang}
                        <li><a class="currentLang" data-id="{$lang.id_lang|escape:'htmlall':'UTF-8'}" href="javascript:hideOtherLanguage({$lang.id_lang|escape:'javascript'});" tabindex="-1">{$lang.name|escape:'htmlall':'UTF-8'}</a></li>
                        {/foreach}
                    </ul>
                </div>
            {/if}
        </div>
        {if $languages|count > 1}
            </div>
        {/if}
    {/foreach}
    {* ALBUM CUSTOM DESCRIPTION *}

    <div class="panel-footer">
        <button type="submit" value="1" name="submitpsagecheckerModule" class="btn btn-default pull-right">
            <i class="process-icon-save"></i> {l s='Save' mod='psagechecker'}
        </button>
    </div>
</div>

<div class="panel col-lg-10 right-panel addons-right-panel">
    <h3>
        <i class="fa fa-pie-chart"></i> {l s='Choose your Instagram album\'s display position' mod='psagechecker'} <small>{$module_display|escape:'htmlall':'UTF-8'}</small>
    </h3>

    {* ON HOME PAGE *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="boldtext control-label">{l s='On homepage' mod='psagechecker'}</label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">
            <span class="switch prestashop-switch fixed-width-lg">
                <input class="yes" type="radio" name="PS_INSTA_ON_HOMEPAGE" id="homepage_on" data-toggle="collapse" data-target="#" value="1" {if $on_homepage eq 1}checked="checked"{/if}>
                <label for="homepage_on" class="radioCheck">{l s='YES' mod='psagechecker'}</label>

                <input class="no" type="radio" name="PS_INSTA_ON_HOMEPAGE" id="homepage_off" data-toggle="collapse" data-target="#" value="0" {if $on_homepage eq 0}checked="checked"{/if}>
                <label for="homepage_off" class="radioCheck">{l s='NO' mod='psagechecker'}</label>
                <a class="slide-button btn"></a>
            </span>
        </div>
    </div>
    {* ON HOME PAGE *}

    <div id="PS_INSTA_ON_HOMEPAGE" {if $on_homepage eq 0}class="hide"{/if}>
    {* NUMBER OF COLUMNS *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                        {l s='Number of columns' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-6 col-sm-5 col-md-2 col-lg-1">
            <select name="PS_INSTA_NUMBER_COLUMNS">
                {*{foreach from=$cmspage item='page'}*}
                    <option value="3" {if $number_columns eq 3}selected{/if}>3</option>
                    <option value="4" {if $number_columns eq 4}selected{/if}>4</option>
                    <option value="6" {if $number_columns eq 6}selected{/if}>6</option>
                {*{/foreach}*}
            </select>
            {*<input class="addons-number-fields addons-inline-block" required="required" value="{$number_columns|escape:'htmlall':'UTF-8'}" type="number" name="PS_INSTA_NUMBER_COLUMNS">*}
        </div>
    </div>
    {* NUMBER OF COLUMNS *}

    {* NUMBER OF ROWS *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                        {l s='Number of rows' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
            <input class="addons-number-fields addons-inline-block" required="required" value="{$number_rows|escape:'htmlall':'UTF-8'}" type="number" name="PS_INSTA_NUMBER_ROWS">
        </div>
    </div>
    {* NUMBER OF ROWS *}
    </div>

    <br>

    {* PRODUCT PAGE *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="boldtext control-label">{l s='On product pages' mod='psagechecker'}</label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">
            <span class="switch prestashop-switch fixed-width-lg">
                <input class="yes" type="radio" name="PS_INSTA_ON_PRODUCT_PAGE" id="product_page_on" data-toggle="collapse" data-target="#" value="1" {if $on_product_page eq 1}checked="checked"{/if}>
                <label for="product_page_on" class="radioCheck">{l s='YES' mod='psagechecker'}</label>

                <input class="no" type="radio" name="PS_INSTA_ON_PRODUCT_PAGE" id="product_page_off" data-toggle="collapse" data-target="#" value="0" {if $on_product_page eq 0}checked="checked"{/if}>
                <label for="product_page_off" class="radioCheck">{l s='NO' mod='psagechecker'}</label>
                <a class="slide-button btn"></a>
            </span>
        </div>
    </div>
    {* PRODUCT PAGE *}

    <div id="PS_INSTA_ON_PRODUCT_PAGE" {if $on_product_page eq 0}class="hide"{/if}>
    {* NUMBER OF COLUMNS *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                        {l s='Number of columns' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-6 col-sm-5 col-md-2 col-lg-1">
            <select name="PS_INSTA_COLUMNS_PRODUCT">
                {*{foreach from=$cmspage item='page'}*}
                    <option value="3" {if $number_columns_product_page eq 3}selected{/if}>3</option>
                    <option value="4" {if $number_columns_product_page eq 4}selected{/if}>4</option>
                    <option value="6" {if $number_columns_product_page eq 6}selected{/if}>6</option>
                {*{/foreach}*}
            </select>
            {*<input class="addons-number-fields addons-inline-block" required="required" value="{$number_columns|escape:'htmlall':'UTF-8'}" type="number" name="PS_INSTA_NUMBER_COLUMNS">*}
        </div>
    </div>
    {* NUMBER OF COLUMNS *}

    {* NUMBER OF ROWS *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                        {l s='Number of rows' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
            <input class="addons-number-fields addons-inline-block" required="required" value="{$number_rows_product_page|escape:'htmlall':'UTF-8'}" type="number" name="PS_INSTA_ROWS_PRODUCT">
        </div>
    </div>
    {* NUMBER OF ROWS *}
    </div>

    <br>

    {* SEPARATED CMS PAGE *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="boldtext control-label">{l s='Separated CMS page' mod='psagechecker'}</label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-4">
            <span class="switch prestashop-switch fixed-width-lg">
                <input class="yes" type="radio" name="PS_INSTA_SEPARATED_CMS" id="cms_page_on" data-toggle="collapse" data-target="#" value="1" {if $separated_cms eq 1}checked="checked"{/if}>
                <label for="cms_page_on" class="radioCheck">{l s='YES' mod='psagechecker'}</label>

                <input class="no" type="radio" name="PS_INSTA_SEPARATED_CMS" id="cms_page_off" data-toggle="collapse" data-target="#" value="0" {if $separated_cms eq 0}checked="checked"{/if}>
                <label for="cms_page_off" class="radioCheck">{l s='NO' mod='psagechecker'}</label>
                <a class="slide-button btn"></a>
            </span>
            <div class="help-block">
                <p>{l s='Before choosing this option, please make sure that you have created your Instagram album page. To create a new page on your website and customize its content, please' mod='psagechecker'} <a href="{$cmsConfPage}" target="_blank">{l s='click here' mod='psagechecker'}</a>
            </div>
        </div>
    </div>
    {* SEPARATED CMS PAGE *}

    <div id="PS_INSTA_SEPARATED_CMS" {if $separated_cms eq 0}class="hide"{/if}>
    {* INSTAGRAM ALBUME PAGE *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                    {l s='Instagram album page' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-2">
            <select class="" name="PS_INSTA_CMS">
                {foreach from=$cmspage item='page'}
                    <option value="{$page.id_cms|escape:'htmlall':'UTF-8'}" {if $page.id_cms eq $cms}selected{/if}>{$page.meta_title|escape:'htmlall':'UTF-8'}</option>
                {/foreach}
            </select>
        </div>
    </div>
    {* INSTAGRAM ALBUME PAGE *}
    </div>

    <div class="panel-footer">
        <button type="submit" value="1" name="submitpsagecheckerModule" class="btn btn-default pull-right">
            <i class="process-icon-save"></i> {l s='Save' mod='psagechecker'}
        </button>
    </div>
</div>

<div class="panel col-lg-10 right-panel addons-right-panel">
    <h3>
        <i class="fa fa-pie-chart"></i> {l s='Set up your image' mod='psagechecker'} <small>{$module_display|escape:'htmlall':'UTF-8'}</small>
    </h3>

    <article class="alert alert-info" role="alert" data-alert="warning">
        {l s='To add direct links to the products on the photo, please go to the Image manager tab and configure directly on the desired photo.' mod='psagechecker'}
    </article>

    {* PRODUCT SHEETS *}
    {*<div class="form-group">*}
        {*<div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">*}
            {*<div class="text-right">*}
                {*<label class="boldtext control-label">{l s='Insert links to product sheets' mod='psagechecker'}</label>*}
            {*</div>*}
        {*</div>*}
        {*<div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">*}
            {*<span class="switch prestashop-switch fixed-width-lg">*}
                {*<input class="yes" type="radio" name="PS_INSTA_PRODUCT_SHEETS" id="product_sheet_on" data-toggle="collapse" data-target="#pause_hover" value="1" {if $product_sheets eq 1}checked="checked"{/if}>*}
                {*<label for="product_sheet_on" class="radioCheck">{l s='YES' mod='psagechecker'}</label>*}

                {*<input class="no" type="radio" name="PS_INSTA_PRODUCT_SHEETS" id="product_sheet_off" data-toggle="collapse" data-target="#pause_hover" value="0" {if $product_sheets eq 0}checked="checked"{/if}>*}
                {*<label for="product_sheet_off" class="radioCheck">{l s='NO' mod='psagechecker'}</label>*}
                {*<a class="slide-button btn"></a>*}
            {*</span>*}
        {*</div>*}
    {*</div>*}
    {* PRODUCT SHEETS *}

    {* SHOW CUSTOM PRODUCT TITLE *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="boldtext control-label">{l s='Show custom product title' mod='psagechecker'}</label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">
            <span class="switch prestashop-switch fixed-width-lg">
                <input class="yes" type="radio" name="PS_INSTA_SHOW_CUSTOM_TITLE_BIS" id="product_custom_title_on" data-toggle="collapse" data-target="#" value="1" {if $show_custom_title eq 1}checked="checked"{/if}>
                <label for="product_custom_title_on" class="radioCheck">{l s='YES' mod='psagechecker'}</label>

                <input class="no" type="radio" name="PS_INSTA_SHOW_CUSTOM_TITLE_BIS" id="product_custom_title_off" data-toggle="collapse" data-target="#" value="0" {if $show_custom_title eq 0}checked="checked"{/if}>
                <label for="product_custom_title_off" class="radioCheck">{l s='NO' mod='psagechecker'}</label>
                <a class="slide-button btn"></a>
                <div class="help-block">
                    <p>{l s='Example : Shop this look' mod='psagechecker'}
                </div>
            </span>
        </div>
    </div>
    {* SHOW CUSTOM PRODUCT TITLE *}

    <br>

    <div id="PS_INSTA_SHOW_CUSTOM_TITLE_BIS" {if $show_custom_title eq 0}class="hide"{/if}>
    {* CUSTOM TITLE TEXT *}
    {foreach from=$languages item=language}
        {if $languages|count > 1}
            <div class="translatable-field lang-{$language.id_lang|escape:'htmlall':'UTF-8'}" {if $language.id_lang != $defaultFormLanguage}style="display:none"{/if}>
        {/if}
        <div class="form-group">
            <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
                <div class="text-right">
                    <label for="buylater_button_title_text" class="control-label required">
                        {l s='Custom product title' mod='psagechecker'}
                    </label>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-7 col-lg-4">
                <input class="" type="text" value="{if isset($custom_title)}{$custom_title[$language.id_lang]|escape:'htmlall':'UTF-8'}{/if}" name="PS_INSTA_CUSTOM_TITLE_BIS_{$language.id_lang|escape:'htmlall':'UTF-8'}" placeholder="{l s='Title' mod='psagechecker'}">
            </div>
            {if $languages|count > 1}
                <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
                    <button type="button" class="btn btn-default dropdown-toggle" tabindex="-1" data-toggle="dropdown">
                        {$language.iso_code|escape:'htmlall':'UTF-8'}
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                        {foreach from=$languages item=lang}
                        <li><a class="currentLang" data-id="{$lang.id_lang|escape:'htmlall':'UTF-8'}" href="javascript:hideOtherLanguage({$lang.id_lang|escape:'javascript'});" tabindex="-1">{$lang.name|escape:'htmlall':'UTF-8'}</a></li>
                        {/foreach}
                    </ul>
                </div>
            {/if}
        </div>
        {if $languages|count > 1}
            </div>
        {/if}
    {/foreach}
    {* CUSTOM TITLE TEXT *}

    {* TITLE TEXT COLOR *}
    <div class="form-group">
        <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
            <div class="text-right">
                <label class="control-label">
                    {l s='Title text color' mod='psagechecker'}
                </label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-7 col-lg-2">
            <div class="input-group">
                <input type="text" data-hex="true" class="color mColorPickerInput mColorPicker" name="PS_INSTA_CUSTOM_TITLE_COLOR_BIS" value="{if isset($custom_title_color)}{$custom_title_color|escape:'htmlall':'UTF-8'}{/if}" id="color_2" style="background-color:{if isset($custom_title_color)}{$custom_title_color|escape:'htmlall':'UTF-8'}{/if}; color: back;"><span style="cursor:pointer;" id="icp_color_2" class="mColorPickerTrigger input-group-addon" data-mcolorpicker="true"><img src="../img/admin/color.png" style="border:0;margin:0 0 0 3px" align="absmiddle"></span>
            </div>
        </div>
    </div>
    {* TITLE TEXT COLOR *}
    </div>

    <div class="panel-footer">
        <button type="submit" value="1" name="submitpsagecheckerModule" class="btn btn-default pull-right">
            <i class="process-icon-save"></i> {l s='Save' mod='psagechecker'}
        </button>
    </div>
</div>


</form>
