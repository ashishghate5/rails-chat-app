$(function() {
  $('#new_room_message').on('ajax:success', function(a, b,c ) {
    $(this).find('input[type="text"]').val('');
  });
});

function check_user() {
  value = document.getElementById('username_search').value;
  $.ajax({url: '/rooms/user_autocomplete',
    data: {value: value},
    dataType: "script",
    method: 'get'
  });
}