{**
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
 *}

<div class="panel col-lg-10 right-panel">
    <h3>
        <i class="fa fa-question-circle"></i>
        {l s='Help for the psagechecker module' mod='psagechecker'}
        <small>{$module_display|escape:'htmlall':'UTF-8'}</small>
    </h3>
    <div class="row">
        <div class="col-xs-4">
            <div class="col-xs-4">
                <img src="{$logo_path|escape:'htmlall':'UTF-8'}" alt=""/>
            </div>
            <div class="col-xs-8 borderRightSolid">
                <p>
                    <span class="data_label" style="color:#00aff0;">
                        <b>{l s='This module allows you to :' mod='psagechecker'}</b>
                    </span>
                </p>

                <div>
                    <div class="numberCircle">1</div>
                    <div class="numberCircleText">
                        <p class="numberCircleText">
                            {l s='Choose a minimum age required to enter your website' mod='psagechecker'}
                        </p>
                    </div>
                </div>
                <div>
                    <div class="numberCircle">2</div>
                    <div class="numberCircleText">
                        <p class="numberCircleText">
                            {l s='Choose a verification method : Confirm/Deny buttons or Birth date check' mod='psagechecker'}
                        </p>
                    </div>
                </div>
                <div>
                    <div class="numberCircle">3</div>
                    <div class="numberCircleText">
                        <p class="numberCircleText">
                            {l s='Customize and adapt your age verification popup to the colors of your online store' mod='psagechecker'}
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-8">
            <div class="helpContentRight-sub">
                <b>{l s='Need help ?' mod='psagechecker'}</b>
                <br>

                {l s='Find here the documentation of this module' mod='psagechecker'}
                <a class="btn btn-primary" href="{$doc|escape:'htmlall':'UTF-8'}" target="_blank" style="margin-left:20px;" href="#">
                    <i class="fa fa-book"></i> {l s='Documentation' mod='psagechecker'}</a>
                </a>
                <br><br>

                <div class="tab-pane panel" id="faq">
                    <div class="panel-heading">
                        <i class="icon-question"></i> {l s='FAQ' mod='psagechecker'}
                    </div>

                    {foreach from=$apifaq item=categorie name='faq'}
                        <span class="faq-h1">{$categorie->title|escape:'htmlall':'UTF-8'}</span>
                        <ul>
                            {foreach from=$categorie->blocks item=QandA}
                                {if !empty($QandA->question)}
                                    <li>
                                        <span class="faq-h2"><i class="icon-info-circle"></i> {$QandA->question|escape:'htmlall':'UTF-8'}</span>
                                        <p class="faq-text hide">
                                            {$QandA->answer|escape:'htmlall':'UTF-8'|replace:"\n":"<br />"}
                                        </p>
                                    </li>
                                {/if}
                            {/foreach}
                        </ul>
                        {if !$smarty.foreach.faq.last}<hr/>{/if}
                    {/foreach}
                </div>

                {l s='You couldn\'t find any answer to your question ?' mod='psagechecker'}
                <b>
                    <a href="http://addons.prestashop.com/contact-form.php" target="_blank">
                        {l s='Contact us on PrestaShop Addons' mod='psagechecker'}
                    </a>
                </b>
            </div>
        </div>
    </div>
</div>
