$(document).on('turbolinks:load', function(){
  function addImageHtml(image){
    var html = `<li class="product-image">
                  <img src=${image}>
                  <div class="product-image__option">
                    <div class="product-image__edit" >
                      編集
                    </div>
                    <div>
                      <a class="product-image__delete">削除</a>
                    </div>
                  </div>
                </li>`
    return html;
  };
  var centerInfoHtml = `<p class='sell-upload-form__image--images-container'>
                          ドラッグアンドドロップして
                          <br>
                          ファイルをアップロード
                        </p>
`
  var files_array = [];
  $('#preview').on('dragover',function(e){
    e.preventDefault();
  });
  $('#preview').on('drop',function(event){
    event.preventDefault();
    if($(".sell-upload-form__image--images-container").length){
      $(".sell-upload-form__image--images-container").remove();
    };
    files = event.originalEvent.dataTransfer.files;
    for (var i=0; i<files.length; i++) {
      files_array.push(files[i]);
      var fileReader = new FileReader();
      fileReader.onload = function( event ) {
      var image = event.target.result;
      $(addImageHtml(image)).appendTo("#preview").trigger("create");
      };
      fileReader.readAsDataURL(files[i]);
    }
  });
  $(document).on('click','.product-image__delete', function(){
    var index = $(".product-image__delete").index(this);
    files_array.splice(index - 1, 1);
    $(this).parent().parent().parent().remove();
    if(files_array.length === 0){
      $("#preview").append(centerInfoHtml);
    }
  });
  $(".sell-form").on('submit',function(e){
    e.preventDefault();
    var formData = new FormData(this);
    files_array.forEach(function(file){
      formData.append("product_image[image][]" , file)
    });
    var url = $(this).attr("action");
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      contentType: false,
      processData: false,
      async: true
    })
    .fail(function(data){
      $(".sell-container-submit__btn").prop("disabled", false);
      var errors = JSON.parse(data.responseText).errors;
      if(errors === "image is blank"){
        $("#product_image_error").text("画像がありません");
      }else{
        $.each(errors,function(key,value){
          $("#product_" + key).addClass("error_form");
          if (key === "price"){
            $(".sell-container-submit__btn").val("出品する");
            $("#product_" + key + "_error").text("300以上9999999以下で入力してください");
          }else{
            value.forEach(function(message){
              $(".sell-container-submit__btn").val("出品する");
              if(message === "can't be blank"){
                $("#product_" + key + "_error").text("入力してください");
              }else if(message === "is reserved"){
                $("#product_" + key + "_error").text("選択してください");
              }else if(message === "image is blank"){
                $("#product_" + key + "_error").text("画像がありません");
                $("#preview").css("border","1px dashed #ea352d");
              }else if(message === "image is too many"){
                $("#product_" + key + "_error").text("画像は10枚まで投稿できます");
                $("#preview").css("border","1px dashed #ea352d");
              }
            });
          }
        })
      }
    })
  })
});