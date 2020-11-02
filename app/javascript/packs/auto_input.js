$('button').on('click', function () {
  document.getElementById("test_input").value = "こんにちは"
})

$('select').on('change', function () {
  var element = document.getElementById("my_undone_action");
  document.getElementById("savings_record_savings_name").value = element.value.split("&")[0];
  document.getElementById("savings_record_earned_time").value = element.value.split("&")[1];
})
