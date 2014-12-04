$(function(){
    $('#borough-selection').change(function(event){
        var borough = $(this).val();
        $('.neighborhood-dropdown').hide();
        $('.see-buzz').addClass("disabled");
        if(borough == "Manhattan") {
            $('#manhattan-dropdown').show();
        } else if(borough == "Brooklyn") {
            $('#brooklyn-dropdown').show();
        } else if(borough == "Queens") {
            $('#queens-dropdown').show();
        }
    });

    $('.neighborhood-dropdown').change(function(event){
        var neighborhoodID = $(this).find("select").val();
        if(neighborhoodID == "") {
            $('.see-buzz').addClass("disabled");
        } else {
            $('.see-buzz').removeClass("disabled");
        }
    });

});