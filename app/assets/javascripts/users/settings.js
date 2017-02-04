function add_tracked_websites(event) {
    event.preventDefault();
    var data, params_array = [];

    $('form input').each( function( index, element ){
        data = { user_website_id: $(this).attr('data-id'),
                 url: $( this ).val() };

        if (data.url) {
            params_array.push( data );
        }
    });


    $.ajax({
        url: add_website_url,
        data: { data: params_array },
        type: 'POST',
        success: function(response){
            if(response.status){
                $('#website-list-form').html(response.html);
            }
            else{
                // StatusMessage.show("Something went wrong! Please try again later!", {type: ERROR});
            }
        },
        failure: function(response){
            // StatusMessage.show("Something went wrong! Please try again later!", {type: ERROR});
        }
    })
}