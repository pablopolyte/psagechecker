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
    <div id="giftcards">
        <h3>
            <i class="fa fa-search"></i> {l s='Image preselection' mod='pssocialfeed'} <small>{$module_display|escape:'htmlall':'UTF-8'}</small>
        </h3>

        <div id="image-preselection">
            <form id="search" class="form-horizontal" action="">
            {* SEARCH BLOCK *}
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-5 col-lg-3">
                    <div class="text-right">
                        <label class="control-label">
                                {l s='Chosen hashtag' mod='pssocialfeed'}
                        </label>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-7 col-lg-3">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="icon-search"></i></span>
                        <input class="form-control" name="PS_INSTA_SEARCH">
                    </div>
                    <div class="help-block">
                        <p>{l s='Ex: myshop, puffinfamily ...' mod='pssocialfeed'}</p>
                    </div>
                </div>
                <div>
                    <a id="search-tag" type="button" class="btn btn-primary" @click="getTag()"> {l s='Search' mod='pssocialfeed'}</a>
                </div>
            </div>
            {* SEARCH BLOCK *}
            <form>
            <div v-if="items == '' && search == false">
                <article class="alert alert-info" role="alert" data-alert="warning">
                    {l s='We recommend you to create and use hashtags that are relevant to your brand and encourage users to submit engaging content.' mod='pssocialfeed'}
                </article>
            </div>

            <div v-if="items" class="row">
                <paginate name="items" :list="items" :per="8">
                <div v-for="(tag, index) in paginated('items')" class="col-xs-12 col-md-6 col-lg-3 center">
                    <div class="tag-card">
                        <div class="card-image" :style="'background-size:cover;background-image:url('+tag.url+')'">
                        {*<div class="card-image">*}
                            {*<img :src="tag.url" style="width:100%;height:100%">*}
                        </div>
                        <div class="card-add">
                            <div v-if="tag.isActive == 0" id="add-image" @click="addImage(tag.id, index)" class="card-add-icon">
                                <i class="icon-plus"></i>
                            </div>
                            <div v-if="tag.isActive == 1" id="remove-image" @click="removeImage(tag.id, index)" class="card-remove-icon">
                                <i class="icon-trash"></i>
                            </div>
                        </div>
                        <div class="card-date">
                            <i class="icon-calendar detail-date"> (( tag.created_time ))</i>
                        </div>
                        <div class="card-detail">
                            <div class="top-detail">
                                <i class="icon-thumbs-up detail-likes"> (( tag.likes ))</i>
                                <i class="icon-comments detail-comments"> (( tag.comments ))</i>
                            </div>
                            <div class="bot-detail">
                                (( tag.tags ))
                            </div>
                        </div>
                    </div>
                </div>
            </paginate>
            </div>
            <div v-if="items" class="paginate-image">
                <paginate-links for="items" :limit="2" :show-step-links="true" :async="true"></paginate-links>
            </div>
            <div v-if="items == '' && search == true">
                <article class="alert alert-warning" role="alert" data-alert="warning">
                    {l s='There is no image associated to your tag.' mod='pssocialfeed'}
                </article>
            </div>
        </div>
    </div>
</div>

<div class="panel col-lg-10 right-panel addons-right-panel">
    <h3>
        <i class="fa fa-object-group"></i> {l s='Image manager' mod='pssocialfeed'} <small>{$module_display|escape:'htmlall':'UTF-8'}</small>
    </h3>

    <div id="image-manager" class="row">
        <div v-for="(image, index) in imageList" class="col-lg-4">
            <div class="card">
                <div class="card-image">
                    <img :src="image.url" height="150" width="150">
                </div>
                <div class="card-content">
                    <div class="card-info">
                        <i class="icon-calendar detail-date"> (( image.created_time ))</i>
                        <i class="icon-thumbs-up detail-likes"> (( image.likes ))</i>
                        <i class="icon-comments detail-comments"> (( image.comments ))</i>
                        <p class="hashtags">(( image.tags ))</p>
                    </div>
                    <div class="action-bar">
                        <div class="button-card">
                            <button v-if="image.isActive == 1" @click="disableImage(image.id, index)" type="button" class="btn btn-success"><i class="icon-check"></i> {l s='Enabled' mod='pssocialfeed'}</button>
                            <button v-if="image.isActive == 0" @click="disableImage(image.id, index)" type="button" class="btn btn-warning"><i class="icon-remove"></i> {l s='Disabled' mod='pssocialfeed'}</button>
                            <button @click="removeImage(image.id, image.id_media)" type="button" class="btn btn-danger"><i class="icon-trash"></i></button>
                        </div>
                        <div class="configure">
                            <button @click="loadModal(image.id)" type="button" class="btn btn-default" data-toggle="modal" data-target="#assignProducts"><i class="icon-cog"></i> {l s='Configure' mod='pssocialfeed'}</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="assignProducts" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="exampleModalLabel" style="display:inline-block;">{l s='Assign product to your image' mod='pssocialfeed'}</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="display:inline-block;font-size: 2.3rem;font-weight: 400;">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <article class="alert alert-warning" role="alert" data-alert="warning">
                    {l s='You can assign up to two products to each image. Please leave the fields below empty if you don’t prefer to assign products to your image.' mod='pssocialfeed'}
                </article>
                <label>{l s='Product 1' mod='pssocialfeed'}</label>
                <select id="product1" style="width:100%">
                    <option></option>
                    {foreach from=$products item=product}
                    <option value="{$product['id_product']|escape:'htmlall':'UTF-8'}">
                        {$product['id_product']|escape:'htmlall':'UTF-8'} - {$product['productName']|escape:'htmlall':'UTF-8'}
                    </option>
                    {/foreach}
                </select>
                <br><br>
                <label>{l s='Product 2' mod='pssocialfeed'}</label>
                <select id="product2" style="width:100%">
                    <option></option>
                    {foreach from=$products item=product}
                    <option value="{$product['id_product']|escape:'htmlall':'UTF-8'}">
                        {$product['id_product']|escape:'htmlall':'UTF-8'} - {$product['productName']|escape:'htmlall':'UTF-8'}
                    </option>
                    {/foreach}
                </select>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{l s='Close' mod='pssocialfeed'}</button>
                <button id="saveAssignProduct" type="button" data-id-image="" data-dismiss="modal" class="btn btn-primary">{l s='Save' mod='pssocialfeed'}</button>
            </div>
        </div>
    </div>
</div>

{literal}
<script type="text/javascript">
    var msgAddImage = "{/literal}{l s='The image was successfully added to your wall.' mod='pssocialfeed'}{literal}";
    var msgRemoveImage = "{/literal}{l s='The image was successfully deleted from your wall.' mod='pssocialfeed'}{literal}";
    var msgEnableImage = "{/literal}{l s='The image was successfully enabled.' mod='pssocialfeed'}{literal}";
    var msgDisableImage = "{/literal}{l s='The image was successfully disabled.' mod='pssocialfeed'}{literal}";
    var msgAssignProduct = "{/literal}{l s='Product has been successfully assign to the image.' mod='pssocialfeed'}{literal}";
</script>
{/literal}
