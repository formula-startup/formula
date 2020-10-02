$(document).on("turbolinks:load", function(){
  // 商品出品時のカテゴリ登録
  // 入力欄のHTMLを作成
    var bigCategoryboxHtml = `
      <div class="select-wrap big_category_wrapper">
        <select class="default-select sell-select-box sell_bigcategory_box" name="product[bigcategory_id]" id="bigcategory_id">
          <option value="">---</option>
        <i class="select-arrow fas fa-chevron-down"></i>
      </div>
    `

    var smallCategoryboxHtml = `
    <div class="select-wrap small_category_wrapper">
      <select class="default-select sell-select-box sell_smallcategory_box " name="product[smallcategory_id]" id="smallcategory_id">
        <option value="">---</option>
      <i class="select-arrow fas fa-chevron-down"></i>
    </div>
    `

    var sizeBoxHtml = `
    <div class="size_wrapper">
      <p class="margin-2rem">
        <label class="signup-label" for="category_index_サイズ">サイズ</label>
        <span class="signup-form-container__span span-need">必須</span>
      </p>
        <div class="select-wrap size_wrapper">
          <select class="default-select sell-select-box size_box " name="product[size_id]" id="size_id">
            <option value="">---</option>
          <i class="select-arrow fas fa-chevron-down"></i>
        </div>
    </div>
    `
  // 挿入する選択肢のHTMLを作成
  function buildcategoryOptions(category){
    var optionHtml =`
    <option value="${category.id}">
      ${category.name}
    </option>
  `
  return optionHtml;
  };


  // 商品出品時のカテゴリー登録
  $('.select_category_index').on('change', function(){
    var category_index_id = $('#product_category_index_id').val();
    $('.small_category_wrapper').remove();
    $('.size_wrapper').remove();

    // bigcategoryの箱を追加
    if(!($('.big_category_wrapper').length)){
      var bigBoxHtml = bigCategoryboxHtml;
      $('.category_wrapper').append(bigBoxHtml);
    };
    if(category_index_id == "") {
      $('.big_category_wrapper').remove();
    };
    $.ajax({
      url:       "products/bigcategory",
      type:      "GET",
      dataTytpe: "json",
      data:      {category_id: category_index_id}
    })
    // bigcategoryの選択肢を追加
    .done(function(bigcategory_options){
      var insertHtml = "";
      $('#bigcategory_id').children('option').remove();
      var defaultOption = `
      <option value="">---</option>
      `
      $('#bigcategory_id').append(defaultOption);
      $.each(bigcategory_options, function(i, bigcategory_option){
        insertHtml = buildcategoryOptions(bigcategory_option);
        optionHtml = insertHtml;
        $('#bigcategory_id').append(optionHtml);
      });

      // smallcategoryの箱を追加
      $('.sell_bigcategory_box').on('change',function(){
        var bigCategoryId = $('#bigcategory_id').val();
        if(!($('.small_category_wrapper').length)){
          var smallBoxHtml = smallCategoryboxHtml;
          $('.category_wrapper').append(smallBoxHtml);
        };
        if( bigCategoryId == "") {
          $('.small_category_wrapper').remove();
          $('.size_wrapper').remove();
        };
        $.ajax({
          url:      'products/smallcategory',
          type:     'GET',
          dataType: 'json',
          data:     {bigcategory_id: bigCategoryId}
        })
        // smallcategoryの選択肢を追加
        .done(function(smallcategory_options){
          var insertSmallCategoryHtml = "";
          $('#smallcategory_id').children('option').remove();
          $('#smallcategory_id').append(defaultOption);
          $.each(smallcategory_options, function(i, smallcategory_option){
            insertSmallCategoryHtml = buildcategoryOptions(smallcategory_option);
            smallOptionHtml         = insertSmallCategoryHtml;
            $('#smallcategory_id').append(smallOptionHtml);
          });

          // sizeの箱を追加
          $('.sell_smallcategory_box').on('change',function(){
            var smallCategoryId = $('#smallcategory_id').val();
            if(!($('.size_wrapper').length)){
              var sizeHtml = sizeBoxHtml;
              $('.category_wrapper').append(sizeHtml);
            };
            if (smallCategoryId == ''){
              $('.size_wrapper').remove();
            };
            $.ajax({
              url:      'products/size',
              type:     'GET',
              dataType: 'json',
              data:     {smallcategory_id: smallCategoryId}
            })
            // sizeの選択肢を追加
            .done(function(size_options){
              var insertSizeHtml = "";
              $('#size_id').children('option').remove();
              $('#size_id').append(defaultOption);
              $.each(size_options, function(i, size_option){
                insertSizeHtml = buildcategoryOptions(size_option);
                sizeOptionHtml = insertSizeHtml;
                $('#size_id').append(sizeOptionHtml);
              });
              if($('#size_id').children('option').length == 1) {
                $('.size_wrapper').remove();
              };
            });
          });
        });
      });
    });
  });


  // TOP PAGEカテゴリリスト表示
  // カテゴリリスト表示機能（マウスが乗ったら発火）
  $('.box__lower__left__category').hover(function(){
    $('.box__lower__left__category__wrapper').show();
    $('.category_index_box').show();
    $('.category_index_box').children().show();
    // マウスが外れたら発火
  }, function(){
    $(this).children("div").hide();
    $('.bigcategory_box').hide();
    $('.smallcategory_box').hide();
  });

  // bigcategoryの表示
  $('.category_index_box').children('li').hover(function(){
    $('.category_index_box').children().removeClass('hover_red');
    $('.smallcategory_box').hide();
    $(this).addClass('hover_red');
    var categoryArray  = $(this).attr('class');
    var categoryClass  = categoryArray.split(' ');
    var categoryId     = categoryClass[0]
    $('.bigcategory_box').children().hide();
    $('.bigcategory_box').show();
    // 該当のbigcategory表示
    $('.bigcategory_box').children('.'+categoryId).show();
    // マウスが外れたら発火
  }, function(){
    $(this).removeClass('hover_red');
  });

  // smallcategoryの表示
  $('.bigcategory_box').children('li').hover(function(){
    $('.bigcategory_box').children().removeClass('hover_gray');
    $(this).addClass('hover_gray');
    var bigCategoryArray = $(this).attr('class');
    var bigCategoryClass = bigCategoryArray.split(" ");
    var categoryId       = bigCategoryClass[0];
    var bigCategoryId    = bigCategoryClass[1];
    $('.smallcategory_box').children().hide();
    $('.smallcategory_box').show();
    // 選んでいるCategory_indexを赤色にする
    $('.category_box').children('.'+categoryId+'_red').addClass('hover_red');
    // 該当のsmallcategoryの表示
    $('.smallcategory_box').children('.'+bigCategoryId).show();
    // マウスが外れたら発火
  }, function(){
    $(this).removeClass('hover_gray');
  });

  // smallcategoryホバー時
  $('.smallcategory_box').children('li').hover(function(){
    $(this).addClass('hover_gray');
    var smallCategoryArray  = $(this).attr('class');
    var smallCategoryClass  = smallCategoryArray.split(" ");
    var bigCategoryId       = smallCategoryClass[0];
    // 選んでいるbigCategoryを灰色にする
    $('.bigcategory_box').children('.'+bigCategoryId+'_gray').addClass('hover_gray');
    // マウスが外れたら発火
  }, function(){
    $(this).removeClass('hover_gray');
    var smallCategoryArray  = $(this).attr('class');
    var smallCategoryClass  = smallCategoryArray.split(" ");
    var bigCategoryId       = smallCategoryClass[0];
    $('.bigcategory_box').children('.'+bigCategoryId+'_gray').removeClass('hover_gray');
  });

});
