$(document).ready(function() {
    $(".add_to_cart_button").on('click', function(event) {
      // Empêcher le comportement de soumission du formulaire par défaut
      event.preventDefault();
  
      // Récupérer l'URL du formulaire (c'est l'URL de votre action `add_to_cart`)
      var url = $(this).attr('href');
  
      // Effectuer une requête AJAX à l'URL
      $.ajax({
        url: url,
        method: 'POST',
        success: function(data) {
          // Mettre à jour le panier sur la page avec les nouvelles données
          $("#cart").html(data);
        }
      });
    });
});
