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
    {if $show_custom_title eq 1}
    <h3 class="custom_title" style="color:{$custom_title_color};font-size:{$custom_title_font_size}px !important;">{$custom_title|escape:'htmlall':'UTF-8'}</h3>
    {/if}
    <div class="desc">{$desc nofilter}</div>
    <div class="container">
        <div class="grid">
            <div v-if="column == 4" v-for="(image, index) in images" class="col-lg-3">
                <div class="insta-card" @click="getInfoImage(index)">
                    <div class="insta-card-img" :style="'background-position:center;background-size:cover;background-image:url('+image.url+')'"></div>
                    <!-- <img class="insta-card-img" :src="image.url" style="width:100%;height:100%;"> -->
                </div>
            </div>
            <div v-if="column == 3" v-for="(image, index) in images" class="col-lg-4">
                <div class="insta-card" @click="getInfoImage(index)">
                    <div class="insta-card-img" :style="'background-position:center;background-size:cover;background-image:url('+image.url+')'"></div>
                    <!-- <img class="insta-card-img" :src="image.url" style="width:100%;height:100%;"> -->
                </div>
            </div>
            <div v-if="column == 6" v-for="(image, index) in images" class="col-lg-2">
                <div class="insta-card" @click="getInfoImage(index)">
                    <div class="insta-card-img" :style="'background-position:center;background-size:cover;background-image:url('+image.url+')'"></div>
                    <!-- <img class="insta-card-img" :src="image.url" style="width:100%;height:100%;"> -->
                </div>
            </div>
        </div>
    </div>
    <div v-if="images" class="load-more">
        <button v-if="noMoreResults === false" class="btn btn-primary" @click="loadMore(currentItems)">{l s='Load more' mod='pssocialfeed'}</button>
        <!-- <button v-if="noMoreResults" class="btn btn-primary">{l s='No more results' mod='pssocialfeed'}</button> -->
    </div>

    <div id="pssocialfeed-lightbox" class="lightbox pssocialfeed_hide">
        <div class="lightbox-content">
            <div style="height:100%">
                <div class="col-xl-6 col-lg-6 col-md-12 content-left">
                    <div class="pssocialfeed-account-block-mobile">
                        <div class="row">
                            <div class="col-sm-4 col-xs-4" style="text-align:right;">
                                <img :src="imageInfo.profile_picture" width="60" height="60" style="border-radius:50%;">
                            </div>
                            <div class="col-sm-8 col-cs-8" style="text-align:left;">
                                <i class="posted">{l s='Posted by' mod='pssocialfeed'}</i>
                                <br>
                                <span class="author">(( imageInfo.authorName ))</span>
                                <br>
                                <i class="via">{l s='via instagram' mod='pssocialfeed'}</i>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="lightbox-img" :style="'background-image:url('+imageInfo.url+')'"></div>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-6 col-md-12 content-right">
                    <div class="pssocialfeed-account-block">
                        <div class="row">
                            <div class="col-lg-2 col-md-4">
                                <img :src="imageInfo.profile_picture" width="60" height="60" style="border-radius:50%;">
                            </div>
                            <div class="col-lg-10 col-md-8">
                                <i class="posted">{l s='Posted by' mod='pssocialfeed'}</i>
                                <br>
                                <span class="author">(( imageInfo.authorName ))</span>
                                <br>
                                <i class="via">{l s='via instagram' mod='pssocialfeed'}</i>
                            </div>
                        </div>
                    </div>
                    <div style="margin-bottom:20px;height:100px;">
                        <p class="text">(( imageInfo.text ))</p>
                    </div>
                    <div class="product">
                        {if $show_custom_title_bis eq 1}
                        <h3 v-if="imageInfo.product1.name || imageInfo.product2.name" class="custom-title" style="color:{$custom_title_bis_font_text}">{$custom_title_bis|escape:'htmlall':'UTF-8'}</h3>
                        {/if}
                        <div class="">
                            <div v-if="imageInfo.product1.name && imageInfo.product2.name !== null" class="col-md-12 col-lg-6">
                                <div class="col-lg-12 product-image" :style="">
                                    <a :href="imageInfo.product1.url" target="_blank"><img :src="imageInfo.product1.image" width="125" height="125"></a>
                                </div>
                                <div class="col-lg-12 product-name">
                                    <a :href="imageInfo.product1.url" target="_blank">(( imageInfo.product1.name ))</a>
                                </div>
                                <div class="col-lg-12 price" style="margin-top:10px;text-align:center;">
                                    <span>(( imageInfo.product1.price ))
                                    <!-- <div class="col-lg-6 product-button">
                                        <a :href="imageInfo.product1.url" class="btn btn-primary btn-sm" target="_blank">{l s='BUY' mod='pssocialfeed'}</a>
                                    </div> -->
                                </div>
                            </div>
                            <div v-if="imageInfo.product1.name  && imageInfo.product2.name === null" class="col-md-12 col-lg-12">
                                <div class="col-lg-12 product-image" :style="">
                                    <a :href="imageInfo.product1.url" target="_blank"><img :src="imageInfo.product1.image" width="125" height="125"></a>
                                </div>
                                <div class="col-lg-12 product-name">
                                    <a :href="imageInfo.product1.url" target="_blank">(( imageInfo.product1.name ))</a>
                                </div>
                                <div class="col-lg-12 price" style="margin-top:10px;text-align:center;">
                                    <span>(( imageInfo.product1.price ))
                                    <!-- <div class="col-lg-6 product-button">
                                        <a :href="imageInfo.product1.url" class="btn btn-primary btn-sm" target="_blank">{l s='BUY' mod='pssocialfeed'}</a>
                                    </div> -->
                                </div>
                            </div>
                            <div v-if="imageInfo.product2.name && imageInfo.product1.name !== null" class="col-md-12 col-lg-6">
                                <div class="col-lg-12 product-image">
                                    <a :href="imageInfo.product2.url" target="_blank"><img :src="imageInfo.product2.image" width="125" height="125"></a>
                                </div>
                                <div class="col-lg-12 product-name">
                                    <a :href="imageInfo.product1.url" target="_blank">(( imageInfo.product2.name ))</a>
                                </div>
                                <div class="col-lg-12 price" style="margin-top:10px;text-align:center;">
                                    <span>(( imageInfo.product2.price ))
                                    <!-- <div class="col-lg-6 product-button">
                                        <a :href="imageInfo.product2.url" class="btn btn-primary btn-sm" target="_blank">{l s='BUY' mod='pssocialfeed'}</a>
                                    </div> -->
                                </div>
                            </div>
                            <div v-if="imageInfo.product2.name  && imageInfo.product1.name === null" class="col-md-12 col-lg-12">
                                <div class="col-lg-12 product-image">
                                    <a :href="imageInfo.product2.url" target="_blank"><img :src="imageInfo.product2.image" width="125" height="125"></a>
                                </div>
                                <div class="col-lg-12 product-name">
                                    <a :href="imageInfo.product1.url" target="_blank">(( imageInfo.product2.name ))</a>
                                </div>
                                <div class="col-lg-12 price" style="margin-top:10px;text-align:center;">
                                    <span>(( imageInfo.product2.price ))
                                    <!-- <div class="col-lg-6 product-button">
                                        <a :href="imageInfo.product2.url" class="btn btn-primary btn-sm" target="_blank">{l s='BUY' mod='pssocialfeed'}</a>
                                    </div> -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="close">×</div>
    </div>
    <div id="overlay" class="pssocialfeed_hide"></div>

</div>

{literal}
<script type="text/javascript">
    var header = "{/literal}{$header|escape:'htmlall':'UTF-8'}{literal}";
    var row = "{/literal}{$row|escape:'htmlall':'UTF-8'}{literal}";
    var column = "{/literal}{$column|escape:'htmlall':'UTF-8'}{literal}";
    var base_url = "{/literal}{$base_url|escape:'htmlall':'UTF-8'}{literal}";
</script>
{/literal}
