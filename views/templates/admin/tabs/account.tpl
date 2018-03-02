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
<div class="panel col-lg-10 right-panel">
    <h3>
        <i class="fa fa-instagram"></i> {l s='Account settings' mod='pssocialfeed'} <small>{$module_display|escape:'htmlall':'UTF-8'}</small>
    </h3>
    <form method="post" action="{$moduleAdminLink|escape:'htmlall':'UTF-8'}&page=account" class="form-horizontal">
        <div>
            <br>
            {* INSTAGRAM CLIENT ID *}
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
                    <div class="text-right">
                        <label class="control-label">
                                {l s='Instagram client ID' mod='pssocialfeed'}
                        </label>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="icon-user"></i></span>
                        <input id="client_id" class="form-control" required="required" value="{$user_id|escape:'htmlall':'UTF-8'}" name="PS_INSTA_ID">
                    </div>
                </div>
            </div>
            {* INSTAGRAM CLIENT ID *}

            {* INSTAGRAM CLIENT SECRET *}
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
                    <div class="text-right">
                        <label class="control-label">
                                {l s='Instagram client secret' mod='pssocialfeed'}
                        </label>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="icon-user-secret"></i></span>
                        <input id="client_secret" class="form-control" required="required" value="{$user_secret|escape:'htmlall':'UTF-8'}" name="PS_INSTA_SECRET">
                    </div>
                    <div class="help-block">
                        <p>{l s='Please' mod='pssocialfeed'} <a href="{$tuto}" target="_blank">{l s='click here' mod='pssocialfeed'}</a> {l s='in case you don\'t know how to request an Instagram client ID' mod='pssocialfeed'}
                    </div>
                </div>
            </div>
            {* INSTAGRAM USER SECRET *}

            <article class="alert alert-info" role="alert" data-alert="warning">
                {l s='Be careful! Before saving your Instagram credentials, please make sure that you have entered this URL on your Instagram Developer platform, in the Security > Valid redirect URIs section.' mod='pssocialfeed'}
                <p class="api-redirect-url">{$api_redirect_url|escape:'htmlall':'UTF-8'}</p>
            </article>

        </div>
        <div class="panel-footer">
            <button type="submit" value="1" id="submitAccount" name="submitAccount" class="btn btn-default pull-right">
                <i class="process-icon-save"></i> {l s='Save' mod='pssocialfeed'}
            </button>
        </div>
    </form>
</div>
