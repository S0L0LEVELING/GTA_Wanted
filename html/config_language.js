//--> Change your language here :
var config_language = 'fr';

$(function () {
    switch (config_language) {
        case 'fr':
            $('#tr_wanted').text('WANTED');
            $('#tr_suspect').text('INDIVIDU : ');
            $('#tr_form').text('FORMULAIRE');
            $("#tr_fName").attr("type", "Prénom : ");
            $("#tr_lName").attr("type", "Nom : ");
            $("#tr_reason").attr("type", "Raison : ");
            $("#tr_fNameHolder").attr("placeholder", "Veuillez saisir le prénom de la personne...");
            $("#tr_lNameHolder").attr("placeholder", "Veuillez saisir le nom de la personne...");
            $("#tr_reasonHolder").attr("placeholder", "Veuillez saisir une raison...");
            $('#tr_validate').html('Valider');
        break;

        case 'en':
            $('#tr_wanted').text('WANTED');
            $('#tr_suspect').text('SUSPECT : ');
            $('#tr_form').text('FORM');
            $("#tr_fName").attr("type", "First name : ");
            $("#tr_lName").attr("type", "Last name : ");
            $("#tr_reason").attr("type", "Reason : ");
            $("#tr_fNameHolder").attr("placeholder", "Type the first name here ...");
            $("#tr_lNameHolder").attr("placeholder", "Type the last name here ...");
            $("#tr_lNameHolder").attr("placeholder", "Type the last name here ...");
            $("#tr_reasonHolder").attr("placeholder", "Type the reason here ...");
            $('#tr_validate').html('Validate');
        break;
    };
})