$(document).on('turbolinks:load',function(){
  var html = `<div class="error-message__need">必須項目です</div>`
  $("#token_submit").click(function() {
    $("#token_submit").prop("disabled", true);
      var  number = $(".number").val();
        cvc = $(".cvc").val();
        exp_month = $(".exp_month").val();
        exp_year = $(".exp_year").val();
      var card = {
          number: number,
          cvc: cvc,
          exp_month: exp_month,
          exp_year: exp_year
      };
    Payjp.setPublicKey('pk_test_f638357dbba49468618ee91b');
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        $("#token_submit").prop('disabled', false);
        if ($(".number").val().length === 0){
          $(".number").addClass("error_form");
          $("#number-error").html(html);
        };
        if  ($(".cvc").val().length === 0){
          $(".cvc").addClass("error_form");
          $("#cvc-error").html(html);
        };
        alert("カード情報を正しく入力してください");
      }
      else {
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");
        var token = response.id;
        $.ajax({
          url: "/signup",
          type: "POST",
          data: {
            payjp_token: token
          },
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
          },
          async: false
        })
      }
    });
  });
});
